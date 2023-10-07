terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "vm-1" {

  count = 2

  name = "terraform-${count.index}"
  allow_stopping_for_update = true
  platform_id               = "standard-v3"
  zone                      = "ru-central1-a"


  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8earpjmhevh8h6ug5o"
      type = "network-hdd"
      size = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./meta.txt")}"
  }

  scheduling_policy {
    preemptible = true
  }

}

# save public ip to hosts file
resource "local_file" "ip" {
    filename  = "./deploy_nginx/hosts"
    content = <<-EOT
    [nginx]
    ${yandex_compute_instance.vm-1[0].network_interface.0.nat_ip_address}
    ${yandex_compute_instance.vm-1[1].network_interface.0.nat_ip_address}
    EOT
}

# check connections
resource "null_resource" "step-1" {

  count = 2

  depends_on = [
    local_file.ip
  ]

  # need to wait ssh initialization
  provisioner "remote-exec" {
      connection {
        host        = yandex_compute_instance.vm-1[count.index].network_interface.0.nat_ip_address
        type        = "ssh"
        user        = "egushchin"
      }
      inline = ["echo '==== connected! ===='"]
  }  

}

# run nginx playbook
resource "null_resource" "step-2" {

  depends_on = [
    null_resource.step-1
  ]
  
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u egushchin -i ./deploy_nginx/hosts --private-key ${var.private_key_path} ${var.playbook_path_nginx}"
  }
}

resource "yandex_lb_target_group" "group-n" {
  name      = "netology-group"
  region_id = "ru-central1"
  folder_id = var.folder_id

  target {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    address   = "${yandex_compute_instance.vm-1[0].network_interface.0.ip_address}"
  }

  target {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    address   = "${yandex_compute_instance.vm-1[1].network_interface.0.ip_address}"
  }
}

resource "yandex_lb_network_load_balancer" "netology-balancer" {
  name = "netology-balancer"

  listener {
    name = "netology-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.group-n.id}"

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
