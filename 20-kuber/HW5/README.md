# Домашнее задание к занятию "`Сетевое взаимодействие в K8S. Часть 2`" - `Гущин Евгений`

### Задание 1

1. Создал Deployment с контейнерами nginx и multitool [deployment.yaml](./deployment.yaml) 
сервис для доступа контейнерам [service.yaml](./service.yaml) 

2. развернул все поды и сервис

![task2](../../img/20-kuber/HW5/task1_1.png)  

3. проверил доступ из подов используя имя сервиса

![task2](../../img/20-kuber/HW5/task1_2.png)  

![task2](../../img/20-kuber/HW5/task1_3.png)  


### Задание 2

1. Включил Ingress-controller в MicroK8S:
![task2](../../img/20-kuber/HW5/task2_1.png)  

2. Создал Ingress [ingress.yaml](./ingress.yaml).

![task2](../../img/20-kuber/HW5/task2_2.png)  

3. Проверил доступ к nginx и multitool по доменному имени

![task2](../../img/20-kuber/HW5/task2_3.png)  



