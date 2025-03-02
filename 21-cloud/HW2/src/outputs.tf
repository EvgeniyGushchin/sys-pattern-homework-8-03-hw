output "image_url" {
  value = "https://${yandex_storage_bucket.eg-bucket.bucket}.storage.yandexcloud.net/${yandex_storage_object.my_image.key}"
}

# output "load_balancer_ip" {
#   value = yandex_lb_network_load_balancer.my_lb.listener[0].external_address_spec[0].address
# }