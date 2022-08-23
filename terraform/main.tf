provider "yandex" {
  service_account_key_file = "key.json"  
  cloud_id  = "b1gv92bclvqg566p0ijb"
  folder_id = "b1grkli7naup3hik34ga"
}

data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2004-lts-gpu"
}

resource "yandex_compute_instance" "node01" {
  name     = "node01"
  hostname = "node01.netology.cloud"
  zone     = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = data.yandex_compute_image.ubuntu_image.id
      name        = "root-node01"
      type        = "network-nvme"
      size        = "50"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "net" {
  name = "net"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet"
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.101.0/24"]
  zone           = "ru-central1-a"
}