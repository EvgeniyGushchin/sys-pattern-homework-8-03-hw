variable "token" {
  description = "Yandex Cloud security token"
  default     = #YOUR_TOKEN_HERE #generate yours by https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
}

variable "folder_id" {
  description = "folder for VM"
  default     = #YOUR_FOLDER_ID_HERE
}

variable "cloud_id" {
  description = "Yandex Cloud ID where resources will be created"
  default     = #YOUR_CLOUD_ID_HERE
}

