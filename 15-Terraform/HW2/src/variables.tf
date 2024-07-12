###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

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
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAJw5qmPMY6PAeaB39fk8NnZ2gTGkJzA0qlV2J9flbEM egushchin@thumbtack.net"
#   description = "ssh-keygen -t ed25519"
# }

### VM vars

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Web VM family"
}

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Web VM name"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v2"
  description = "Web VM platform"
}

# variable "vm_web_cores" {
#   type        = number
#   default     = 2
#   description = "Web VM cores number"
# }

# variable "vm_web_memory" {
#   type        = number
#   default     = 1
#   description = "Web VM memory"
# }

# variable "vm_web_core_fraction" {
#   type        = number
#   default     = 5
#   description = "Web VM core fraction"
# }

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Web VM is preemptible"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "Web VM NAT flag"
}

# resources

variable "vms_resources" {
  type = map(map(number))
}

variable "metadata" {
  type = map(string)
}

# test

variable "test" {
  type = list(map(list(string)))
}