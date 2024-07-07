# Домашнее задание к занятию "`Практическое применение Docker`" - `Гущин Евгений`

### Задание 1

1. Сделал форк https://github.com/EvgeniyGushchin/shvirtd-example-python.git
2. Добавил Dockerfile.python и .dockerignore

---

### Задание 3

2. [compose.yaml](https://github.com/EvgeniyGushchin/shvirtd-example-python/blob/main/compose.yaml)

![task2](../../img/14-Virt/HW5/task5-1.png)  
![task2](../../img/14-Virt/HW5/task5-2.png)  
![task2](../../img/14-Virt/HW5/task5-3.png)  

---

### Задание 4

1. скрипт [start.sh](https://github.com/EvgeniyGushchin/sys-pattern-homework-8-03-hw/blob/main/14-Virt/HW5/start.sh)
2. форк https://github.com/EvgeniyGushchin/shvirtd-example-python.git

![task2](../../img/14-Virt/HW5/task5-4.png)  


---

### Задание 6

`docker run -rm -it -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive:latest hashicorp/terraform:latest`

![task2](../../img/14-Virt/HW5/task6-1.png) 
![task2](../../img/14-Virt/HW5/task6-2.png) 

---

### Задание 6.1

```bash
docker run --name test hashicorp/terraform:latest
docker cp test:/bin/terraform .
```

![task2](../../img/14-Virt/HW5/task6-3.png) 




