###cloud vars

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

### VM

variable "vm_resources" { 
  type         = map(number)
  default      = {
    cores = 4
    memory = 4
    core_fraction = 20
    disk_size = 50
  }
}

variable "ubuntu_image" {
  type = string
  description = "image id"
  default = "fd8kc2n656prni2cimp5"
}

### VPC

variable "vpc_name" {
  type        = string
  default     = "netology-diplom"
  description = "VPC network name"
}

### Subnets

variable "subnet-zones" {
  type = list(string)
  default = [ "ru-central1-a", "ru-central1-b", "ru-central1-d" ]
}

variable "cidr" {
  type = map(list(string))
  default = {
    "cidr" = [ "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24" ]
  }
}



