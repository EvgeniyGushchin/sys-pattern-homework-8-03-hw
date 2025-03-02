// в начале напоролся на ошибку
// │ Error: error creating Storage S3 Bucket: error getting storage client: failed to get default storage client
// пришлось создавать сервисный аккаунт
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

resource "yandex_compute_instance_group" "lamp_group" {
  name                = "lamp-instance-group"
  folder_id           = var.folder_id
  service_account_id  = yandex_iam_service_account.sa.id
  deletion_protection = false

  instance_template {
    platform_id = "standard-v3"
    name        = "lamp-{instance.index}"
    resources {
      cores         = var.vm_resources.cores
      memory        = var.vm_resources.memory
      core_fraction = var.vm_resources.core_fraction
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.lamp_image
        size     = var.vm_resources.disk_size
      }
    }

    scheduling_policy {
      preemptible = true
    }

    network_interface {
      network_id = yandex_vpc_network.netology_network.id
      subnet_ids  = ["${yandex_vpc_subnet.public_subnet.id}"]
      nat        = true
    }

    metadata = {
      user-data = "${file("./meta.yml")}"
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion  = 1
  }

  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "Network Load Balancer target group"
  }

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

resource "yandex_lb_network_load_balancer" "eg_lb" {
  name = "network-lb"

  listener {
    name = "http-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp_group.load_balancer.0.target_group_id

    healthcheck {
      name = "http-healthcheck"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
