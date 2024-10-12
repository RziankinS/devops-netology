resource "yandex_vpc_network" "network-dev" {
  name = "network-dev"
}

resource "yandex_vpc_subnet" "subnet-zones" {
  count = 3
  name = "subnet-${var.subnet-zones[count.index]}"
  zone = "${var.subnet-zones[count.index]}"
  network_id = "${yandex_vpc_network.network-dev.id}"
  v4_cidr_blocks = [ "${var.cidr.cidr[count.index]}" ]
}