# Домашнее задание к занятию "`Система мониторинга Zabbix. Часть 2`" - `Гущин Евгений`

### Задание 1

![template1](../../img/SMON/HW3_img/Task1_1.png?raw=true)
![template2](../../img/SMON/HW3_img/Task1_2.png?raw=true)


---

### Задание 2-3

![Hosts](../../img/SMON/HW3_img/Task2_1.png?raw=true)

---

### Задание 4

![Dashboard](../../img/SMON/HW3_img/Task4_1.png?raw=true)

---

### Задание 5

![map1](../../img/SMON/HW3_img/Task5_1.png?raw=true)
![map2](../../img/SMON/HW3_img/Task5_2.png?raw=true)

---

### Задание 7

```python
import sys 
import os 
import re 
from datetime import date

if (sys.argv[1] == '-ping'): # Если -ping 
    result=os.popen("ping -c 1 " + sys.argv[2]).read() # Делаем пинг по заданному адресу  
    result=re.findall(r"time=(.*) ms", result) # Выдёргиваем из результата время  
    print(result[0]) # Выводим результат в консоль 
elif (sys.argv[1] == '-simple_print'): # Если simple_print  
    print(sys.argv[2]) # Выводим в консоль содержимое sys.arvg[2] 
elif (sys.argv[1] == '1'):
    print("Гущин Евгений Александрович")
elif (sys.argv[1] == '2'):
    today = date.today()
    print(today)
else: # Во всех остальных случаях 
    print(f"unknown input: {sys.argv[1]}") # Выводим непонятый запрос в консоль
```

![task7_1](../../img/SMON/HW3_img/Task7_1.png?raw=true)
![task7_2](../../img/SMON/HW3_img/Task7_2.png?raw=true)

---

### Задание 8

![discovery1](../../img/SMON/HW3_img/Task8_1.png?raw=true)
![discovery2](../../img/SMON/HW3_img/Task8_2.png?raw=true)
