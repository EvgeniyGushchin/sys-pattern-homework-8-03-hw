cloud_id = "b1gji0p5kdm6lm63cdit"
folder_id = "b1gnq14tjgmbrp18q9eu"

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

metadata = {
  serial-port-enable = 1
  ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAJw5qmPMY6PAeaB39fk8NnZ2gTGkJzA0qlV2J9flbEM egushchin@thumbtack.net"
}

test = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]