# Домашнее задание к занятию "`Резервное копирование»`" - `Гущин Евгений`

### Задание 1

![task1](../../img/9_FaultTolerance/HW3/Task1_1.png?raw=true)

---

### Задание 2

Скрипт для для создания бэкапов
```bash
#!/bin/bash

user=''

if [[ $1 ]]
then
  user=$1
else
  user="$(whoami)"
fi

if [[ ! -d "/home/${user}" ]]
then
  echo "Directory /home/${user} DOES NOT exists."
  exit 0
fi

rsync -ac --delete --exclude '.*' /home/$user/ /tmp/backup/$user
```
---
Crontab
```bash
0 15 * * * /home/ubuntu/script.sh 2>&1 | /usr/bin/logger -t CRONOUTPUT
```

![task2](../../img/9_FaultTolerance/HW3/Task2_1.png?raw=true)
![task2](../../img/9_FaultTolerance/HW3/Task2_2.png?raw=true)
![task2](../../img/9_FaultTolerance/HW3/Task2_3.png?raw=true)

### Задание 3

![task3](../../img/9_FaultTolerance/HW3/Task3_1.png?raw=true)

### Задание 4

[backup.sh](backup.sh)
[restore.sh](restore.sh)

Папка с бэкапами
![task4](../../img/9_FaultTolerance/HW3/Task4_1.png?raw=true)

Запускаем бэкап
![task4](../../img/9_FaultTolerance/HW3/Task4_2.png?raw=true)

Самый старый бэкап удален
![task4](../../img/9_FaultTolerance/HW3/Task4_3.png?raw=true)

Удаляем папку http1
![task4](../../img/9_FaultTolerance/HW3/Task4_4.png?raw=true)

Восстанавливаем из бэкапа
![task4](../../img/9_FaultTolerance/HW3/Task4_5.png?raw=true)
