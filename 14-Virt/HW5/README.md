# Домашнее задание к занятию "`Практическое применение Docker`" - `Гущин Евгений`

### Задание 1

1. Сделал форк https://github.com/EvgeniyGushchin/shvirtd-example-python.git
2. Добавил Dockerfile.python и .dockerignore

---

### Задание 2

2. [compose.yaml](https://github.com/EvgeniyGushchin/shvirtd-example-python/blob/main/compose.yaml)

![task2](../../img/14-Virt/HW5/task5-1.png)  
![task2](../../img/14-Virt/HW5/task5-2.png)  
![task2](../../img/14-Virt/HW5/task5-3.png)  

---

### Задание 3

![task3](../../img/14-Virt/HW4/3_1.png)  
![task3](../../img/14-Virt/HW4/3_2.png)  
![task3](../../img/14-Virt/HW4/3_3.png)  
![task3](../../img/14-Virt/HW4/3_4.png)  
![task3](../../img/14-Virt/HW4/3_5.png)  
![task3](../../img/14-Virt/HW4/3_6.png)  

---

### Задание 4

С запуском centos и debian на Маке с М1 чипом возникли трудности пожтому воспользовался образом из первого задания

![task3](../../img/14-Virt/HW4/4_1.png)  
![task3](../../img/14-Virt/HW4/4_2.png)  

---

### Задание 5

![task3](../../img/14-Virt/HW4/5_1.png)  
![task3](../../img/14-Virt/HW4/5_2.png)  
![task3](../../img/14-Virt/HW4/5_3.png)  
![task3](../../img/14-Virt/HW4/5_4.png)  

При удалении одного compose файла, связанный с ним контейнер при выполнении команды `docker compose up -d` помечается как orphan(сирота) и предлагается удалить такой контейнер выполнив команду с ключом `--remove-orphans`