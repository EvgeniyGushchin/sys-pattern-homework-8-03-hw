# Домашнее задание к занятию "`«ELK`" - `Гущин Евгений`

### Задание 1

![task1](../../img/11_DataStorage/HW3/Task1.png?raw=true)

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
