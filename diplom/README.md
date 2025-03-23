# Дипломный практикум в Yandex.Cloud

## Цели:
   1. Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.  
   2. Запустить и сконфигурировать Kubernetes кластер.  
   3. Установить и настроить систему мониторинга.  
   4. Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.  
   5. Настроить CI для автоматической сборки и тестирования.  
   6. Настроить CD для автоматического развёртывания приложения. 

## Этапы выполнения:
### Создание облачной инфраструктуры 

1. Создал сервисный аккаунт и бакет для хранения состояния
[tf-bucket](./tf-bucket/)

2. Подготовил backend для Terraform:
```
backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket     = "diplom-bucket"
    key        = "diplom.tfstate"
    region     = "ru-central1"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    skip_metadata_api_check = true
}
```

3. Проинициализировал Terraform с использованием ключей от сервисного аккаунта
![img](./img/ter1.png)

4. .tfstate записался в bucket
![img](./img/ter2.png)

5. Написал скрипт для создания основной инфраструктуры для кластера [tf-main](./tf-main/):
- [ВМ](./tf-main/nodes.tf)
- [Сеть](./tf-main/network.tf)
- [Шаблон инвентори](./tf-main/hosts.tftpl)

6. После запуска `terraform apply` получил требуемую инфраструктуру

![img](./img/cloud1.png)

![img](./img/cloud2.png)

и инвентори файл для развертывания кластера

```yaml
---
all:
  vars:
    ansible_ssh_user: ubuntu
    ansible_ssh_private_key_file: ~/.ssh/id_ed25519
    ansible_ssh_common_args: '-o ProxyCommand="ssh -W %h:%p -q -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no "{{ ansible_ssh_user }}"@89.169.141.102 -i "{{ ansible_ssh_private_key_file }}""'
    become: true
    ansible_python_interpreter: /usr/bin/python3
  hosts:
    node-0:
      ansible_host: 10.10.1.32
      ip: 10.10.1.32
      access_ip: 10.10.1.32
    node-1:
      ansible_host: 10.10.2.6
      ip: 10.10.2.6
      access_ip: 10.10.2.6
    node-2:
      ansible_host: 10.10.3.32
      ip: 10.10.3.32
      access_ip: 10.10.3.32
  children:
    kube_control_plane:
      hosts:
        node-0:
    kube_node:
      hosts:
        node-1:
        node-2:
    
    etcd:
      hosts:
         node-0:
    k8s_cluster:
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
```

### Создание Kubernetes кластера

Для развертывания кластера использовал *kubespray* и созданный на предидущем этапе инвентори файл.

1. Установил зависимости для *kubespray*:

```pip install -r requirements.txt```

2. Также в настройках поменял версию кубера с 1.31 на 1.30. Более свежая версия не хотела устанавливаться. Возможно надо поиграть с версиями *kubespray* и *ansible* 

![img](./img/kube0.png)

3. Добавил:
- [install.yml](./ansible/install.yml) для развертывания кластера
- [prepare.yml](./ansible/prepare.yml) для ожидания ВМ кластера
- [config.yml](./ansible/config.yml) работа с конфиг файлом после развертывания кластера

3. В [ansible.tf](./tf-main/ansible.tf) добавил шаг по запуску `ansible-playbook`
```
resource "null_resource" "installation" {
  depends_on = [
    local_file.hosts_templatefile,
  ]

  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ../ansible/kubespray/inventory/mycluster/hosts.yaml -u ubuntu --become --become-user=root ../ansible/install.yml"
  }

}
```

4. После отработки Ansible, кластер установился
![img](./img/ans1.png)

![img](./img/kube2.png)
![img](./img/kube1.png)

