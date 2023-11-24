
resource "yandex_vpc_network" "postgres_network" { 
  name = "postgres_network" 
}

resource "yandex_vpc_subnet" "postgres_subnet_1" {
  name           = "postgres_subnet_1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.postgres_network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "postgres_subnet_2" {
  name           = "postgres_subnet_2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.postgres_network.id
  v4_cidr_blocks = ["192.168.11.0/24"]
}