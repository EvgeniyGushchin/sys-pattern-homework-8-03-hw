# Домашнее задание к занятию "`Запуск приложений в K8S`" - `Гущин Евгений`

### Задание 1

1. Создал Deployment с контейнерами nginx и multitoo [deployment.yaml](./deployment.yaml) 
из-за конфликта портов пришлось добавлять env переменную с указание порта

![task2](../../img/20-kuber/HW3/task1_1.png)  

![task2](../../img/20-kuber/HW3/task1_2.png)  

![task2](../../img/20-kuber/HW3/task1_3.png)  

2. Увеличил количество реплик до 2

![task2](../../img/20-kuber/HW3/task1_4.png)  

3. Создал сервис [service.yaml](./service.yaml) 

4. Создал отдельный под для multitool [multitool.yaml](./multitool.yaml) 
![task2](../../img/20-kuber/HW3/task1_5.png)  

5. Подключился к поду и проверил из него доступ к приложениям
![task2](../../img/20-kuber/HW3/task1_6.png)  


### Задание 2

1. Создал Deployment приложения nginx со стартом только после того, как будет запущен сервис этого приложения.
[deployment2.yaml](./deployment2.yaml) 

![task2](../../img/20-kuber/HW3/task2_1.png)  

2. Создал сервис и запустил его [service2.yaml](./service2.yaml) 
Убедился, что Deployment стартанул

![task2](../../img/20-kuber/HW3/task2_2.png)  


