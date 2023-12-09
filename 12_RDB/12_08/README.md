# Домашнее задание к занятию "`Резервное копирование баз данных`" - `Гущин Евгений`

### Задание 1

варианты резервного копирования для случаев:

1. Необходимо восстанавливать данные в полном объёме за предыдущий день.
   
Если объем базы данных не очень большой, то можно делать полный бэкап на ежедневной основе. Если же размер базы слишком велик или мы хотим сэкономить место занимаемое резервными копиями, то план резервного копирования может выглядеть следующим образом:
- делаем полный бэкап в конце недели
- в начале каждого дня создаем дифференциальные бэкапы

2. Необходимо восстанавливать данные за час до предполагаемой поломки.
- делаем полный бэкап в конце недели
- в начале каждого дня создаем дифференциальные бэкапы
- каждый час в течение дня делаем инкрементальный бэкап

3. Возможен ли кейс, когда при поломке базы происходило моментальное переключение на работающую или починенную базу данных.
   
Да, возможен. Репликация нам в помощь

---

### Задание 2

`pg_dump -Fc my_db > my_backup.dump`
`pg_restore –d my_db my_backup.dump`

Автоматизировать можно. Пишием скрипт и запускаем по расписанию 

---

### Задание 3

`mysqldump --single-transaction --incremental-base=history:last_full_backup --databases my_db > backup.sql`

**В каких случаях использование реплики будет давать преимущество по сравнению с обычным резервным копированием?**

Когда простой в работе недопустим и нужно быстро переключиться на рабочую копию в случае сбоя.