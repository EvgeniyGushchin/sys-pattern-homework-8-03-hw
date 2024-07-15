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
  description = "VPC network&subnet name"
}

#

variable "vm_web_name_prefix" {
  type        = string
  default     = "web"
  description = "VM prefix name"
}

variable "vm_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Web VM family"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v2"
  description = "Web VM platform"
}

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

# db vm

variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, core_fraction=number, disk_volume=number }))
}

# resources

variable "vms_resources" {
  type = map(map(number))
}
