resource "yandex_vpc_network" "diplom-net" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "diplom-private-subnet" {
  count = 3
  name = "subnet-${var.subnet-zones[count.index]}"
  zone = "${var.subnet-zones[count.index]}"
  network_id = "${yandex_vpc_network.diplom-net.id}"
  v4_cidr_blocks = [ "${var.private-cidr[count.index]}" ]
  route_table_id = yandex_vpc_route_table.diplom-route.id
}

resource "yandex_vpc_subnet" "diplom-public-subnet" {
  name           = "public_${var.vpc_name}"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.diplom-net.id
  v4_cidr_blocks = var.public-cidr
}

resource "yandex_vpc_route_table" "diplom-route" {
  name       = "private-into-nat"
  network_id = yandex_vpc_network.diplom-net.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_ip
  }
}

# resource "yandex_lb_target_group" "k8s_masters" {
#   name = "k8s-masters-target-group"

#   target {
#     subnet_id  = yandex_vpc_subnet.diplom-private-subnet.0.id
#     address    = yandex_compute_instance.vm-instance.0.network_interface.0.ip_address
#   }
# }

# resource "yandex_lb_network_load_balancer" "k8s_lb" {
#   name = "k8s-load-balancer"

#   listener {
#     name = "k8s-listener"
#     port = 6443
#     external_address_spec {
#       ip_version = "ipv4"
#     }
#   }

#   attached_target_group {
#     target_group_id = yandex_lb_target_group.k8s_masters.id

#     healthcheck {
#       name = "k8s-healthcheck"
#       http_options {
#         port = 6443
#         path = "/healthz"
#       }
#     }
#   }
# }