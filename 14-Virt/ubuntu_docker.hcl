
source "yandex" "ubuntu_docker" {
  disk_type           = "network-hdd"
  folder_id           = "b1gnq14tjgmbrp18q9eu"
  image_description   = "my custom debian with docker"
  image_name          = "ubuntu-docker2"
  source_image_family = "ubuntu-2204-lts-oslogin"
  ssh_username        = "egushchin"
  subnet_id           = "e9bj23hg86396rhe2s6b"
  token               = "YOUR TOKEN"
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

build {
  sources = ["source.yandex.ubuntu_docker"]

  provisioner "shell" {
    inline = [
    <<EOF
        export DEBIAN_FRONTEND=noninteractive
        # Add Docker's official GPG key:
        sudo apt-get update
        sudo apt-get install ca-certificates curl gnupg
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg

        # Add the repository to Apt sources:
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
          $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
          sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
        sudo apt-get install -y htop
        sudo apt-get install -y tmux
      EOF
    ]  
    }

}
