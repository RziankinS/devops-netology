terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.127.0"
    }
  }

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    } 
  skip_region_validation      = true
    skip_credentials_validation = true
	skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "yandex" {
  #service_account_key_file = "authorized_key.json"
  token     = "${var.yandex_cloud_auth}"
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
  #zone      = var.zone
}