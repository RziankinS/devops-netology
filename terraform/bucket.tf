resource "yandex_iam_service_account" "sa-bucket" {
  name = "sa-bucket"
}

resource "yandex_resourcemanager_cloud_iam_member" "bucket-editor" {
  cloud_id = var.yandex_cloud_id  
  role = "storage.editor"
  member = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
  depends_on = [ yandex_iam_service_account.sa-bucket ]
}

resource "yandex_resourcemanager_cloud_iam_member" "bucket-kms-encrypter" {
  cloud_id = var.yandex_cloud_id  
  role = "kms.keys.encrypter"
  member = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
  depends_on = [ yandex_iam_service_account.sa-bucket ]
}

resource "yandex_resourcemanager_cloud_iam_member" "bucket-kms-decrypter" {
  cloud_id = var.yandex_cloud_id  
  role = "kms.keys.decrypter"
  member = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
  depends_on = [ yandex_iam_service_account.sa-bucket ]
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa-bucket.id
  description = "static access key for bucket"
}

resource "yandex_kms_symmetric_key" "secret-key" {
  name = "entcryption-key"
  description = "Key for encrypting bucket objects"
  default_algorithm = "AES_256"
  rotation_period = "72h"
}

resource "yandex_storage_bucket" "rziankins-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "rziankins-bucket"
  acl = "public-read"
  anonymous_access_flags {
    read = true
    list = true
    config_read = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.secret-key.id
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "image" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = yandex_storage_bucket.rziankins-bucket.bucket
  key = "image.jpg"
  source = "media/image.jpg"
  acl = "public-read"
  depends_on = [ yandex_storage_bucket.rziankins-bucket ]
}
