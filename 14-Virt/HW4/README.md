# Домашнее задание к занятию "`Оркестрация группой Docker контейнеров на примере Docker Compose.`" - `Гущин Евгений`

### Задание 1

https://hub.docker.com/repository/docker/egushchin55/custom-nginx/general

---

### Задание 2

![task2](../../img/14-Virt/HW4/2-1.png) 
![task2](../../img/14-Virt/HW4/2-2.png)  
![task2](../../img/14-Virt/HW4/2-3.png)  

---

### Задание 3

![task3](../../img/14-Virt/HW4/3-1.png)  
![task3](../../img/14-Virt/HW4/3-2.png)  
![task3](../../img/14-Virt/HW4/3-3.png)  
![task3](../../img/14-Virt/HW4/3-4.png)  
![task3](../../img/14-Virt/HW4/3-5.png)  
![task3](../../img/14-Virt/HW4/3-6.png)  

---

### Задание 4

С запуском centos и debian на Маке с М1 чипом возникли трудности пожтому воспользовался образом из первого задания

![task3](../../img/14-Virt/HW4/4-1.png)  
![task3](../../img/14-Virt/HW4/4-2.png)  

---

### Задание 5

![task3](../../img/14-Virt/HW4/5-1.png)  
![task3](../../img/14-Virt/HW4/5-2.png)  
![task3](../../img/14-Virt/HW4/5-3.png)  
![task3](../../img/14-Virt/HW4/5-4.png)  

При удалении одного compose файла, связанный с ним контейнер при выполнении команды `docker compose up -d` помечается как orphan(сирота) и предлагается удалить такой контейнер выполнив команду с ключом `--remove-orphans`
