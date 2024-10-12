resource "yandex_iam_service_account" "sa-dev" {
  name = "sa-dev"
}

resource "yandex_resourcemanager_folder_iam_member" "terraform-editor" {
#  cloud_id = var.yandex_cloud_id  
  folder_id = var.yandex_folder_id 
  role = "editor"
  member = "serviceAccount:${yandex_iam_service_account.sa-dev.id}"
  depends_on = [yandex_iam_service_account.sa-dev]
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa-dev.id
  description = "access key"
}

resource "yandex_storage_bucket" "rziankins-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "rziankins-bucket"
  acl = "private"
  force_destroy = true
#  depends_on = [ yandex_resourcemanager_folder_iam_member.dev-editor ]
}

resource "local_file" "Config_backend" {
  content = <<EOT
bucket = "${yandex_storage_bucket.rziankins-bucket.bucket}"
region = "ru-central1"
key = "terraform/terraform.tfstate"
access_key = "${yandex_iam_service_account_static_access_key.sa-static-key.access_key}"
secret_key = "${yandex_iam_service_account_static_access_key.sa-static-key.secret_key}"
skip_region_validation = true
skip_credentials_validation = true
# skip_requesting_account_id  = true 
# skip_s3_checksum            = true 
EOT
  filename = "../secret.backend.tfvars"
}

#resource "yandex_storage_object" "tfstate" {
#    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#    bucket = yandex_storage_bucket.rziankins-bucket.bucket
#    key = "terraform.tfstate"
#    source = "terraform/dip/terraform.tfstate"
#    acl    = "private"
#    depends_on = [yandex_storage_bucket.rziankins-bucket]
#}