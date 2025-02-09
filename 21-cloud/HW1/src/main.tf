resource "yandex_vpc_network" "netology" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public" {
  name           = var.public_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netology.id
  v4_cidr_blocks = var.public_subnet_cidr
}

resource "yandex_compute_instance" "nat_instance" {

  name        = "nat-instance"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    ip_address = "192.168.10.254"
    nat        = true
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = var.metadata.ssh-keys
  }

}

resource "yandex_vpc_subnet" "private" {
  name           = var.private_subnet_name
  v4_cidr_blocks = var.private_subnet_cidr
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netology.id
  route_table_id = yandex_vpc_route_table.private_route_table.id
}

resource "yandex_vpc_route_table" "private_route_table" {
  name       = "private-route-table"
  network_id = yandex_vpc_network.netology.id

  static_route {
    destination_prefix = "0.0.0.0/0" 
    next_hop_address   = yandex_compute_instance.nat_instance.network_interface.0.ip_address
  }
}

resource "yandex_compute_instance" "private_vm" {

  name        = "private_vm"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
  }

  metadata = {
    serial-port-enable = var.metadata.serial-port-enable
    ssh-keys           = var.metadata.ssh-keys
  }

}
