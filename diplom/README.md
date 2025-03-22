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