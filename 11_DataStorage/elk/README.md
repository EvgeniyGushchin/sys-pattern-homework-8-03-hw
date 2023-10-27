# Домашнее задание к занятию "`«Кеширование Redis/memcached`" - `Гущин Евгений`

### Задание 1

[Playbook](Task1)
![task1](../../img/9_FaultTolerance/HW4/Task1_1.png?raw=true)
![task1](../../img/9_FaultTolerance/HW4/Task1_2.png?raw=true)
![task1](../../img/9_FaultTolerance/HW4/Task1_3.png?raw=true)

---

### Задание 2

[Playbook](Task2)

![task2](../../img/9_FaultTolerance/HW4/Task2_1.png?raw=true)
![task2](../../img/9_FaultTolerance/HW4/Task2_1.1.png?raw=true)
![task2](../../img/9_FaultTolerance/HW4/Task2_2.png?raw=true)
![task2](../../img/9_FaultTolerance/HW4/Task2_3.png?raw=true)

### Задание 3

### Задание 4

```bash
for key in $(redis-cli --scan)
do
        echo "$key => $(redis-cli get $key)"
done
```
### Задание 5