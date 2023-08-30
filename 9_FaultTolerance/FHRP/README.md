# Домашнее задание к занятию "`Disaster recovery и Keepalived`" - `Гущин Евгений`

### Задание 1

![task1](../../img/9_FaultTolerance/HW1/Task1_1.png?raw=true)
![task1](../../img/9_FaultTolerance/HW1/Task1_2.png?raw=true)

---

### Задание 2

Скрипт для проверки порта и наличия файла
```bash
#!/bin/bash

nc -zv localhost 80 &>/dev/null

if [[ $? -eq 0 ]] &&  [[ -f "/var/www/html/index.html" ]];
then
   exit 0
else
   exit 1
fi
```
---
Конфиг keepalived
```json
lobal_defs {
  script_user egushchin
  enable_script_security
}
vrrp_script nginx_test {
   script "/etc/keepalived/test.sh"
   interval 3
}
vrrp_instance VI_1 {
    state MASTER
    interface enp0s2
    virtual_router_id 100
    priority 101
    advert_int 1

    virtual_ipaddress {
      192.168.123.100/24
    }

    track_process {
      nginx_test
    }
}
```

![task2](../../img/9_FaultTolerance/HW1/Task2_1.png?raw=true)
![task2](../../img/9_FaultTolerance/HW1/Task2_2.png?raw=true)
![task2](../../img/9_FaultTolerance/HW1/Task2_3.png?raw=true)
![task2](../../img/9_FaultTolerance/HW1/Task2_4.png?raw=true)
![task2](../../img/9_FaultTolerance/HW1/Task2_5.png?raw=true)
![task2](../../img/9_FaultTolerance/HW1/Task2_6.png?raw=true)

