output "internal_ip_address_nodes" {
  value = {
    for node in yandex_compute_instance.vm-instance:
    node.hostname => node.network_interface.0.ip_address
  }
}

output "external_ip_address_nodes" {
  value = {
    for node in yandex_compute_instance.vm-instance:
    node.hostname => node.network_interface.0.nat_ip_address
  }
}

# output "load_balancer_ip" {
#   value = one(yandex_lb_network_load_balancer.k8s_lb.listener).external_address_spec
# }