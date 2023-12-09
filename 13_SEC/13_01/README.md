# Домашнее задание к занятию "`Уязвимости и атаки на информационные системы`" - `Гущин Евгений`

### Задание 1

Установить Metasploitable2 на ARM процессоре не получилось
Установить Metasploitable2 на ВМ в Яндекс облаке тоже не получается
Поэто сканировал обычную ВМ с Ubuntu


![task1](../../img/13_SEC/HW1/Task1_1.png)

Уязвимость нашел только одну
https://www.exploit-db.com/exploits/46024

---

### Задание 2

![task2](../../img/13_SEC/HW2/Task1_2.png)
![task2](../../img/13_SEC/HW2/Task1_3.png)
![task2](../../img/13_SEC/HW2/Task1_4.png)

При сканировании используется разный набор протоколов

-sv: TCP, ICMPv6, SIP, HTTP, SSLv3
-sS: TCP, ARP
-sf, -sX: ARP
-sU: ARP, UDP, ICMP
