output "platform" {
    value = [
        values({
            for vm in yandex_compute_instance.platform: 
            vm.name => {
                "name": vm.name,
                "id" : vm.id,
                "fqdn": vm.fqdn
            }
        })
  ]
}

output "databases" {
    value = [
        values({
            for vm in yandex_compute_instance.db_vm: 
            vm.name => {
                "name": vm.name,
                "id" : vm.id,
                "fqdn": vm.fqdn
            }
        })
  ]
}