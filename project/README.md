# Дипломный практикум в Yandex.Cloud


## 1. Создание облачной инфраструктуры в ЯО при помощи Terraform
   
###  1.1. Создаем сервисный аккаунт:

![1](https://github.com/RziankinS/devops-netology/blob/ff04a0ef967b58e93cde09b53f2afb187c66aa79/screen/project/%D1%81%D0%B5%D1%80%D0%B2%D0%B8%D1%81%D0%BD%D1%8B%D0%B9%20%D0%B0%D0%BA%D0%BA%D0%B0%D1%83%D0%BD%D1%82.png)

---

###  1.2. Подготавливаем backend для Terraform, вариант S3 bucket:
      
![2](https://github.com/RziankinS/devops-netology/blob/935d01b42eac2857a5db1a4e5f0cd34902ba4112/screen/project/tfstate.png)

---

###  1.3. Создаем VPC с подсетями в разных зонах доступности:
      
![3](https://github.com/RziankinS/devops-netology/blob/ca6d747d9463e0a73f462f7f459f52df051706ad/screen/project/vpc.png)

---

###  1.4.1. Проводим проверку, выполнения команды "terraform apply -auto-approve" для создания сервисного аккаунта и бакета

<details>
<summary>terraform apply --auto-approve</summary>
   
```bash
sergei@XWHD911:~/yandex-cloud/terraform/bucket$ terraform apply --auto-approve
yandex_iam_service_account.sa-dev: Refreshing state... [id=ajec7uhkm7ep6ltnnls9]
yandex_resourcemanager_folder_iam_member.terraform-editor: Refreshing state... [id=b1gh1p257m29u8c4p09p/editor/serviceAccount:ajec7uhkm7ep6ltnnls9]
yandex_iam_service_account_static_access_key.sa-static-key: Refreshing state... [id=ajecg0shkh0l920d7r4p]
yandex_storage_bucket.rziankins-bucket: Refreshing state... [id=rziankins-bucket]
local_file.Config_backend: Refreshing state... [id=80a4e0e907b94ee7bc08d9a3ead00ea69f598942]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
sergei@XWHD911:~/yandex-cloud/terraform/bucket$
```
</details>
---

###  1.4.2. Проводим проверку, выполнения команды "terraform apply -auto-approve" для конфигурации инфраструктуры

<details>
<summary>terraform apply --auto-approve</summary>

```bash
sergei@XWHD911:~/yandex-cloud/terraform$ terraform apply --auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_instance.k8s-cluster[0] will be created
  + resource "yandex_compute_instance" "k8s-cluster" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hostname                  = "vm-0"
      + id                        = (known after apply)
      + labels                    = {
          + "index" = "0"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6N/0+q5CNzN9QpDeEG8Z0NK5/MQF8OeQOiAct7RxK/ sergei@XWHD911
            EOT
        }
      + name                      = "vm-0"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v2"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8l04iucc4vsh00rkb1"
              + name        = (known after apply)
              + size        = 30
              + snapshot_id = (known after apply)
              + type        = "network-ssd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_compute_instance.k8s-cluster[1] will be created
  + resource "yandex_compute_instance" "k8s-cluster" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hostname                  = "vm-1"
      + id                        = (known after apply)
      + labels                    = {
          + "index" = "1"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6N/0+q5CNzN9QpDeEG8Z0NK5/MQF8OeQOiAct7RxK/ sergei@XWHD911
            EOT
        }
      + name                      = "vm-1"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v2"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-b"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8l04iucc4vsh00rkb1"
              + name        = (known after apply)
              + size        = 30
              + snapshot_id = (known after apply)
              + type        = "network-ssd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_compute_instance.k8s-cluster[2] will be created
  + resource "yandex_compute_instance" "k8s-cluster" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hostname                  = "vm-2"
      + id                        = (known after apply)
      + labels                    = {
          + "index" = "2"
        }
      + maintenance_grace_period  = (known after apply)
      + maintenance_policy        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH6N/0+q5CNzN9QpDeEG8Z0NK5/MQF8OeQOiAct7RxK/ sergei@XWHD911
            EOT
        }
      + name                      = "vm-2"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v2"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-d"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd8l04iucc4vsh00rkb1"
              + name        = (known after apply)
              + size        = 30
              + snapshot_id = (known after apply)
              + type        = "network-ssd"
            }
        }

      + metadata_options (known after apply)

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy (known after apply)

      + resources {
          + core_fraction = 100
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_vpc_network.network-dev will be created
  + resource "yandex_vpc_network" "network-dev" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "network-dev"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_subnet.subnet-zones[0] will be created
  + resource "yandex_vpc_subnet" "subnet-zones" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet-ru-central1-a"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.10.1.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # yandex_vpc_subnet.subnet-zones[1] will be created
  + resource "yandex_vpc_subnet" "subnet-zones" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet-ru-central1-b"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.10.2.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }

  # yandex_vpc_subnet.subnet-zones[2] will be created
  + resource "yandex_vpc_subnet" "subnet-zones" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet-ru-central1-d"
      + network_id     = (known after apply)
      + v4_cidr_blocks = [
          + "10.10.3.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-d"
    }

Plan: 7 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + external_ip_address_nodes = {
      + vm-0 = (known after apply)
      + vm-1 = (known after apply)
      + vm-2 = (known after apply)
    }
  + internal_ip_address_nodes = {
      + vm-0 = (known after apply)
      + vm-1 = (known after apply)
      + vm-2 = (known after apply)
    }
yandex_vpc_network.network-dev: Creating...
yandex_vpc_network.network-dev: Creation complete after 7s [id=enpv40jrtm0s61dcfhqk]
yandex_vpc_subnet.subnet-zones[0]: Creating...
yandex_vpc_subnet.subnet-zones[1]: Creating...
yandex_vpc_subnet.subnet-zones[2]: Creating...
yandex_vpc_subnet.subnet-zones[2]: Creation complete after 1s [id=fl8360ie0hnqi0601kc4]
yandex_vpc_subnet.subnet-zones[1]: Creation complete after 2s [id=e2lt4pg94d2fcfh3b9v8]
yandex_vpc_subnet.subnet-zones[0]: Creation complete after 2s [id=e9be3vhri8g88pvrck94]
yandex_compute_instance.k8s-cluster[2]: Creating...
yandex_compute_instance.k8s-cluster[1]: Creating...
yandex_compute_instance.k8s-cluster[0]: Creating...
yandex_compute_instance.k8s-cluster[2]: Still creating... [10s elapsed]
yandex_compute_instance.k8s-cluster[0]: Still creating... [10s elapsed]
yandex_compute_instance.k8s-cluster[1]: Still creating... [10s elapsed]
yandex_compute_instance.k8s-cluster[2]: Still creating... [20s elapsed]
yandex_compute_instance.k8s-cluster[1]: Still creating... [20s elapsed]
yandex_compute_instance.k8s-cluster[0]: Still creating... [20s elapsed]
yandex_compute_instance.k8s-cluster[2]: Still creating... [30s elapsed]
yandex_compute_instance.k8s-cluster[1]: Still creating... [30s elapsed]
yandex_compute_instance.k8s-cluster[0]: Still creating... [30s elapsed]
yandex_compute_instance.k8s-cluster[2]: Creation complete after 32s [id=fv40upsi69tdamcm83n3]
yandex_compute_instance.k8s-cluster[1]: Still creating... [40s elapsed]
yandex_compute_instance.k8s-cluster[0]: Still creating... [40s elapsed]
yandex_compute_instance.k8s-cluster[1]: Creation complete after 43s [id=epdu8nnescqbiaakbcdt]
yandex_compute_instance.k8s-cluster[0]: Still creating... [50s elapsed]
yandex_compute_instance.k8s-cluster[0]: Still creating... [1m0s elapsed]
yandex_compute_instance.k8s-cluster[0]: Still creating... [1m10s elapsed]
yandex_compute_instance.k8s-cluster[0]: Creation complete after 1m15s [id=fhmjttc7qu41es5dteiq]

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_nodes = {
  "vm-0" = "89.169.140.240"
  "vm-1" = "158.160.28.123"
  "vm-2" = "51.250.38.161"
}
internal_ip_address_nodes = {
  "vm-0" = "10.10.1.6"
  "vm-1" = "10.10.2.9"
  "vm-2" = "10.10.3.30"
}
sergei@XWHD911:~/yandex-cloud/terraform$
```
</details>

---

- [x] Подготовленная инфрастуктура

![4](https://github.com/RziankinS/devops-netology/blob/85cef33b057292592f00105e658550c714542500/screen/project/%D0%B8%D0%BD%D1%84%D1%80%D0%B0%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0.png)

---

![5](https://github.com/RziankinS/devops-netology/blob/ca6d747d9463e0a73f462f7f459f52df051706ad/screen/project/vms.png)
---

