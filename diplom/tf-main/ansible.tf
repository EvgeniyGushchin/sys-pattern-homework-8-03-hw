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

resource "null_resource" "installation" {
  depends_on = [
    local_file.hosts_templatefile,
  ]

  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ../ansible/kubespray/inventory/mycluster/hosts.yaml -u ubuntu --become --become-user=root ../ansible/install.yml"
  }

}