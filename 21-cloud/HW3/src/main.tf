
resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = "bucket-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "eg-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  max_size   = 1073741824
  bucket = "egushchin-bucket"
  acl    = "public-read"
  website {
    index_document = "korjik.jpeg"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.netology-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

// без указания ключей выдает ошибку
// error getting storage client: failed to get default storage client
resource "yandex_storage_object" "my_image" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = yandex_storage_bucket.eg-bucket.bucket
  key    = "korjik.jpeg"
  source = "./korjik.jpeg"
  acl    = "public-read"
}

resource "yandex_vpc_network" "netology_network" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "public_subnet" {
  name           = var.public_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netology_network.id
  v4_cidr_blocks = var.private_subnet_cidr
}

resource "yandex_kms_symmetric_key" "netology-key" {
  name              = "netology-key"
  description       = "netology key"
  default_algorithm = "AES_128"
  rotation_period   = "168h"
}