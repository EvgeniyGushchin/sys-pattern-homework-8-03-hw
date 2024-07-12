### VM vars

variable "vm_db_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "DB VM family"
}

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "DB VM name"
}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v2"
  description = "DB VM platform"
}

# variable "vm_db_cores" {
#   type        = number
#   default     = 2
#   description = "DB VM cores number"
# }

# variable "vm_db_memory" {
#   type        = number
#   default     = 2
#   description = "DB VM memory"
# }

# variable "vm_db_core_fraction" {
#   type        = number
#   default     = 20
#   description = "DB VM core fraction"
# }

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "DB VM is preemptible"
}

variable "vm_db_nat" {
  type        = bool
  default     = true
  description = "DB VM NAT flag"
}

variable "default_zone_db" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr_db" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name_db" {
  type        = string
  default     = "platform_db"
  description = "VPC network & subnet name"
}