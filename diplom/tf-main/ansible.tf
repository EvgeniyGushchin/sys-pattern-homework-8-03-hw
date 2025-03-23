resource "local_file" "hosts_templatefile" {
  depends_on = [
    yandex_compute_instance.vm-instance,
    yandex_compute_instance.nat-instance,
  ]
  
  content = templatefile("./hosts.tftpl", {
    nodes = yandex_compute_instance.vm-instance[*],
    nat_instance = yandex_compute_instance.nat-instance,
  })
  filename = "../ansible/kubespray/inventory/mycluster/hosts.yaml"
}

resource "null_resource" "update_k8s_cluster_yml" {
  depends_on = [
    local_file.hosts_templatefile,
    yandex_lb_network_load_balancer.nlb-k8s,
  ]
  provisioner "local-exec" {
    command = <<EOT
      sed -i '' 's/supplementary_addresses_in_ssl_keys:.*/supplementary_addresses_in_ssl_keys: ["${one(one(yandex_lb_network_load_balancer.nlb-k8s.listener).external_address_spec).address}"]/' ../ansible/kubespray/inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml
    EOT
  }
}

resource "null_resource" "installation" {
  depends_on = [
    local_file.hosts_templatefile,
    null_resource.update_k8s_cluster_yml
  ]

  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ../ansible/kubespray/inventory/mycluster/hosts.yaml -u ubuntu --become --become-user=root ../ansible/install.yml"
  }

}