vms_resources = {
    web = {
        cores = 2
        memory = 1
        core_fraction = 5
    },
    db = {
        cores = 2
        memory = 2
        core_fraction = 20
    }
}

each_vm = [ 
    {
        vm_name     = "main"
        cpu         = 2
        ram         = 2
        core_fraction = 5
        disk_volume = 8
    },
    {
        vm_name     = "replica"
        cpu         = 4
        ram         = 4
        core_fraction = 20
        disk_volume = 10
    }
]