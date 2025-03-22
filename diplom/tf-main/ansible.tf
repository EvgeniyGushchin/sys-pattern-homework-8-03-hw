resource "local_file" "hosts_templatefile" {
  depends_on = [
    yandex_compute_instance.vm-instance,
  ]
  
  content = templatefile("${path.module}/hosts.tftpl", {
    nodes = yandex_compute_instance.vm-instance[*]
  })
  filename = "../ansible/hosts.yaml"
}