resource "yandex_mdb_mysql_cluster" "db_cluster" {
  name        = "netology"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.network-netology.id
  version     = "8.0"
  deletion_protection = false

  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-hdd"
    disk_size          = 20
  }
  
  access {
    web_sql = true
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  backup_window_start {
    hours = 23
    minutes = 59
  }

  dynamic "host" {
    for_each = range(2)
    content {
      zone      = var.default_zone_a
      name      = "dba-${host.key}"
      subnet_id = local.public_subnets_id["public-a"]
    }
  }
  dynamic "host" {
    for_each = range(2)
    content {
      zone                    = var.default_zone_b
      name                    = "dbb-${host.key}"
      replication_source_name = "dba-${host.key}"
      subnet_id               = local.public_subnets_id["public-b"]
    }
  }

  timeouts {
    create = "1h30m"
    update = "2h"
    delete = "30m"
  }

}

resource "yandex_mdb_mysql_database" "netology_db" {
  cluster_id = yandex_mdb_mysql_cluster.db_cluster.id
  name       = "netology_db"
}

resource "yandex_mdb_mysql_user" "egushchin" {
  cluster_id = yandex_mdb_mysql_cluster.db_cluster.id
  name       = "egushchin"
  password   = "12345678"

  permission {
    database_name = yandex_mdb_mysql_database.netology_db.name
    roles         = ["ALL"]
  }

  connection_limits {
    max_questions_per_hour   = 10
    max_updates_per_hour     = 20
    max_connections_per_hour = 30
    max_user_connections     = 40
  }

  global_permissions = ["PROCESS"]

  authentication_plugin = "SHA256_PASSWORD"
}



