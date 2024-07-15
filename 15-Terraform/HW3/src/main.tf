resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
    family = var.vm_family
}

resource "null_resource" "web_hosts_provision" {
  
  depends_on = [yandex_compute_instance.platform]

  # provisioner "local-exec" {
  #   command = "eval $(ssh-agent) && cat ~/.ssh/id_ed25519 | ssh-add -"
  #   on_failure  = continue 
  # }
  
  provisioner "local-exec" {
    command     = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ./hosts.cfg ./test.yml"
    on_failure  = continue 
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
  triggers = {
    always_run        = "${timestamp()}"
  }

}
