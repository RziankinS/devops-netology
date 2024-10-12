terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.129.0"
    }
  }
}

provider "yandex" {
  token     = "${var.yandex_cloud_auth}"
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
  zone      = var.zone
}