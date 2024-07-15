resource "yandex_compute_instance" "db_vm" {
  for_each    = {
    for index, vm in var.each_vm:
    vm.vm_name => vm
  }
  name        = each.value.vm_name
  platform_id = var.vm_web_platform
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      size = each.value.disk_volume
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