resource "yandex_compute_instance" "vm-instance" {
  count = 3
  platform_id = "standard-v3"
  name = "node-${count.index}"
  zone = "${var.subnet-zones[count.index]}"
  hostname = "node-${count.index}"
  allow_stopping_for_update = true
  labels = {
    index = "${count.index}"
  }

  scheduling_policy {
    preemptible = true
  }

  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = "${var.ubuntu_image}"
      type = "network-ssd"
      size = var.vm_resources.disk_size
    }
  }
  
  network_interface {
    subnet_id = "${yandex_vpc_subnet.diplom-private-subnet[count.index].id}"
    nat = false
  }

  metadata = {
      user-data = "${file("./meta.yml")}"
  }
}

resource "yandex_compute_instance" "nat-instance" {
  name                      = "vm-nat"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true

  scheduling_policy {
    preemptible = true
  }

  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }

  boot_disk {
    initialize_params {
        image_id = "${var.ubuntu_image}"
    }
  }

   network_interface {
      subnet_id  = yandex_vpc_subnet.diplom-public-subnet.id
      ip_address = var.nat_ip
      nat        = true
   }

   metadata = {
      user-data = "${file("./meta.yml")}"
   }
}
