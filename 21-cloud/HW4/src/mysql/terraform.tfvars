cloud_id = "b1gji0p5kdm6lm63cdit"
folder_id = "b1g7pc0hmo9p3cilj7gq"

subnets = {
  "public_subnets" = [
    {
      name = "public-a"
      zone = "ru-central1-a"
      cidr = ["192.168.10.0/24"]
    },
    {
      name = "public-b"
      zone = "ru-central1-b"
      cidr = ["192.168.20.0/24"]
    }
  ],
  "private_subnets" = [
    {
      name = "private-a"
      zone = "ru-central1-a"
      cidr = ["192.168.30.0/24"]
    },
    {
      name = "private-b"
      zone = "ru-central1-b"
      cidr = ["192.168.40.0/24"]
    }
  ],
}