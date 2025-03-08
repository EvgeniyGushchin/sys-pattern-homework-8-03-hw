
resource "yandex_kubernetes_cluster" "regional_cluster_resource_name" {
  name        = "netology-cluster"
  description = "description"
  network_id = yandex_vpc_network.network-netology.id
  master {
    master_location {
      zone      = local.public_subnets_id["public-a"].zone
      subnet_id = local.public_subnets_id["public-a"].id
   }
    master_location {
      zone      = local.public_subnets_id["public-b"].zone
      subnet_id = local.public_subnets_id["public-b"].id
    }
    master_location {
      zone      = local.public_subnets_id["public-d"].zone
      subnet_id = local.public_subnets_id["public-d"].id
    }
    

    public_ip = true

   # security_group_ids = ["${yandex_vpc_security_group.security_group_name.id}"]

    maintenance_policy {
      auto_upgrade = true
    }

    master_logging {
      enabled                    = true
      kube_apiserver_enabled     = true
      cluster_autoscaler_enabled = true
      events_enabled             = true
      audit_enabled              = true
    }
  }

  service_account_id      = yandex_iam_service_account.sa.id
  node_service_account_id = yandex_iam_service_account.sa.id

  labels = {
    my_key       = "my_value"
    my_other_key = "my_other_value"
  }

  release_channel         = "RAPID"
  network_policy_provider = "CALICO"

  kms_provider {
    key_id = yandex_kms_symmetric_key.key-a.id
  }
}

resource "yandex_kms_symmetric_key" "key-a" {
  name              = "netology-symetric-key"
  description       = ""
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}

resource "yandex_kubernetes_node_group" "k8s-ng" {
  cluster_id = yandex_kubernetes_cluster.regional_cluster_resource_name.id
  name        = "k8s-ng"
  description = "node group"
  version     = "1.29"
  instance_template {
    name = "test-{instance.short_id}-{instance_group.id}"
    platform_id = "standard-v3"
    network_acceleration_type = "standard"
    network_interface {
      nat        = true
      subnet_ids = ["${local.public_subnets_id["public-b"].id}"]
    }

    resources {
      memory = 2
      cores  = 2
      core_fraction = 20
    }

    boot_disk {
      type = "network-hdd"
      size = 30
    }

    scheduling_policy {
      preemptible = true
    }

    container_runtime {
      type = "containerd"
    }

    metadata = {
      user-data = "${file("./meta.yml")}"
    }

  }

  scale_policy {
    auto_scale {
      min     = 3
      max     = 6
      initial = 3
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-b"
    }
  }

}