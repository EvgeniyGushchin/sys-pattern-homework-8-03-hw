resource "yandex_vpc_network" "network-netology" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "subnet-netology" {
  for_each = {
    for k, v in local.subnet_array : "${v.name}" => v
  }
  network_id = yandex_vpc_network.network-netology.id
  v4_cidr_blocks = each.value.cidr
  zone           = each.value.zone
  name           = each.value.name
}
