resource "yandex_mdb_postgresql_cluster" "my_cluster" {
  name                = "my_cluster"
  environment         = "PRODUCTION"
  network_id          = yandex_vpc_network.postgres_network.id
  security_group_ids  = [ yandex_vpc_security_group.pgsql-sg.id  ]
  deletion_protection = true

  config {
    version = 15
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  }

  host {
    zone             = "ru-central1-a"
    name             = "mypg-host-a"
    subnet_id        = yandex_vpc_subnet.postgres_subnet_1.id
    assign_public_ip = true
  }

  host {
    zone             = "ru-central1-b"
    name             = "mypg-host-b"
    subnet_id        = yandex_vpc_subnet.postgres_subnet_2.id
    assign_public_ip = true
  }
}

resource "yandex_mdb_postgresql_database" "db1" {
  cluster_id = yandex_mdb_postgresql_cluster.my_cluster.id
  name       = "db1"
  owner      = "user1"
}

resource "yandex_mdb_postgresql_user" "user1" {
  cluster_id = yandex_mdb_postgresql_cluster.my_cluster.id
  name       = "user1"
  password   = "12345678"
}


resource "yandex_vpc_security_group" "pgsql-sg" {
  name       = "pgsql-sg"
  network_id = yandex_vpc_network.postgres_network.id

  ingress {
    description    = "PostgreSQL"
    port           = 6432
    protocol       = "TCP"
    v4_cidr_blocks = [ "0.0.0.0/0" ]
  }
}