# Домашнее задание к занятию "`Хранение в K8s. Часть 2`" - `Гущин Евгений`

### Задание 1

1. Создал Deployment приложения, состоящего из контейнеров busybox и multitool. [deployment1.yaml](./deployment1.yaml)
Отдельно создал Persistent Volume [pv.yaml](./pv.yaml)


3. busybox пишет в файл, а multitool может его прочесть

![task2](../../img/20-kuber/HW7/task1_1.png)  
![task2](../../img/20-kuber/HW7/task1_2.png)  

4. Удалил Deployment. Статус PV поменялся на Released потому, что не осталось объектов, которые его используют.

![task2](../../img/20-kuber/HW7/task1_3.png)

5. файл сохранился на локальном диске ноды

![task2](../../img/20-kuber/HW7/task1_4.png)

Удалил PV, но файл остался на локальном диске потому, что:
- RECLAIM POLICY: Retain
- Так же возможно для данной версии PV *RECLAIM POLICY* Delete не поддерживатеся

![task2](../../img/20-kuber/HW7/task1_5.png)

### Задание 2

1. Создал Deployment [deployment2.yaml](./deployment2.yaml) и включил плагин *hostpath-storage*
2. Файл пишется и читается

![task2](../../img/20-kuber/HW7/task2_1.png)
![task2](../../img/20-kuber/HW7/task2_2.png)



