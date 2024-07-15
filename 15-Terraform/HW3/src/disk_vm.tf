resource "yandex_compute_disk" "gb_disk" {
    count   = 3
    name    = "gb-disk-${count.index}"
    type    = "network-hdd"
    size    = 1
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = var.vm_web_platform
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  dynamic "secondary_disk" {
    for_each = "${yandex_compute_disk.gb_disk.*.id}"
    content {
        disk_id = secondary_disk.value
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = local.metadata.serial-port-enable
    ssh-keys           = local.metadata.ssh-keys
  }

}