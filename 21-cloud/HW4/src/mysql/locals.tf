locals {
  subnet_array = flatten([for k, v in var.subnets : [for j in v : {
    name = j.name
    zone = j.zone
    cidr = j.cidr
    }
  ]])

  # Фильтруем подсети по зоне и ключевому слову в имени
  public_subnets_id = {
    for name, subnet in yandex_vpc_subnet.subnet-netology :
    name => subnet.id
    if strcontains(name, "public")
  }
}