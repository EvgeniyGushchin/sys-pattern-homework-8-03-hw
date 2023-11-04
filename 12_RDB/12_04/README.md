# Домашнее задание к занятию "`SQL. Часть 1`" - `Гущин Евгений`

### Задание 1

![task1](../../img/12_RDB/HW4/Task1.png)

---

### Задание 2

![task1](../../img/12_RDB/HW4/Task2.png)

---

### Задание 3

![task1](../../img/12_RDB/HW4/Task3.png)

---

### Задание 4

![task1](../../img/12_RDB/HW4/Task4.png)

---

### Задание 5

```sql
select f.film_id, f.title from film f
left join inventory i on f.film_id = i.film_id
left join rental r on i.inventory_id = r.inventory_id
where r.rental_id is null;
```

![task1](../../img/12_RDB/HW4/Task5.png)
