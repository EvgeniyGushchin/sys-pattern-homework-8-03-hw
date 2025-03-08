output "public_subnet_info" {
  value = [for k, v in var.subnets["public_subnets"] : zipmap(["subnet_id", "zone"], [yandex_vpc_subnet.subnet-netology[v.name].id, yandex_vpc_subnet.subnet-netology[v.name].zone])]
}

output "private_subnet_info" {
  value = [for k, v in var.subnets["private_subnets"] : zipmap(["subnet_id", "zone"], [yandex_vpc_subnet.subnet-netology[v.name].id, yandex_vpc_subnet.subnet-netology[v.name].zone])]
}

# output "locals" {
#   value = local.public_a_subnet
# }