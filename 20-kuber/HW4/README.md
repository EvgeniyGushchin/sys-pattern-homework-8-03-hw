# Домашнее задание к занятию "`Сетевое взаимодействие в K8S. Часть 1`" - `Гущин Евгений`

### Задание 1

1. Создал Deployment с контейнерами nginx и multitool [deployment.yaml](./deployment.yaml) 
отдельный под с multitool [multitool.yaml](./multitool.yaml) 
сервис для доступа контейнерам [service.yaml](./service.yaml) 

2. развернул все поды и сервис

![task2](../../img/20-kuber/HW4/task1_1.png)  

3. проверил доступ из пода `standalone-multitool` используя имя сервиса

![task2](../../img/20-kuber/HW4/task1_2.png)  

![task2](../../img/20-kuber/HW4/task1_3.png)  


### Задание 2

1. Создал отдельный сервис с типом `NodePort` [service_external.yaml](./service_external.yaml).

![task2](../../img/20-kuber/HW4/task2_1.png)  

2. Проверил доступ к кластеру с локальной машины

![task2](../../img/20-kuber/HW4/task2_2.png)  

![task2](../../img/20-kuber/HW4/task2_3.png)  


