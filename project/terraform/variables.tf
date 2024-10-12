variable "yandex_cloud_id" {
  default = "b1ggp2bhrul82jpvs4rt"
}

variable "yandex_folder_id" {
  default = "b1gh1p257m29u8c4p09p"
}

variable "ubuntu" {
  default = "fd8l04iucc4vsh00rkb1"
}

variable "subnet-zones" {
  type = list(string)
  default = [ "ru-central1-a", "ru-central1-b", "ru-central1-d" ]
}

variable "cidr" {
  type = map(list(string))
  default = {
    "cidr" = [ "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24" ]
  }
}

variable "yandex_cloud_auth" {
  default = "y0_AgAAAAByvTpdAATuwQAAAAEO5OVIAAA4qKML0qJD9JUFpfLt4_JGjkhA_w"
  sensitive = true
}