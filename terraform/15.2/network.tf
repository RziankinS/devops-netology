resource "yandex_vpc_network" "network-dev" {
  name = "network_dev"
}

resource "yandex_vpc_subnet" "subnet-public" {
  name = "public"
  zone = var.zone
  network_id = yandex_vpc_network.network-dex.id
  v4_cidr_blocks = [ "192.168.10.0/24" ]
}
