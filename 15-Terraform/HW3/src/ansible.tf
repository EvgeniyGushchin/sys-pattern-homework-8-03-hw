resource "local_file" "hosts" {
    content = templatefile("${path.module}/hosts.tftpl",
    { 
        webservers = yandex_compute_instance.platform, 
        databases = yandex_compute_instance.db_vm,
        storages = yandex_compute_instance.storage.*
    })

    filename = "${abspath(path.module)}/hosts.cfg"
}

resource "local_file" "hosts2" {
    content = templatefile("${path.module}/hosts2.tftpl",
    { 
        webservers = yandex_compute_instance.platform, 
        databases = yandex_compute_instance.db_vm,
        storages = yandex_compute_instance.storage.*
    })

    filename = "${abspath(path.module)}/hosts2.cfg"
}