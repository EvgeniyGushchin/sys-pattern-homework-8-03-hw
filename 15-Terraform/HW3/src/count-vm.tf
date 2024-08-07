resource "yandex_compute_instance" "platform" {
  depends_on = [yandex_compute_instance.db_vm]
  count = 2
  name        = "${var.vm_web_name_prefix}-${count.index + 1}"
  platform_id = var.vm_web_platform
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
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