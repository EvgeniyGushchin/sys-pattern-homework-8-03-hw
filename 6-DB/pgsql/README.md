# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя Docker, поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL, используя psql.

Воспользуйтесь командой \? для вывода подсказки по имеющимся в psql управляющим командам.

Найдите и приведите управляющие команды для:

- вывода списка БД,
- подключения к БД,
- вывода списка таблиц,
- вывода описания содержимого таблиц,
- выхода из psql.


[docker-compose.yml](docker-compose.yml)


```bash
$ psql -U postgres
psql (13.14)
Type "help" for help.

postgres=# \?
General
  \q                     quit psql

Informational
  \d[S+]                 list tables, views, and sequences
  \d[S+]  NAME           describe table, view, sequence, or index
  \dt[S+] [PATTERN]      list tables
  \l[+]   [PATTERN]      list databases

Connection
  \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo}
                         connect to new database (currently "postgres")

```

## Задача 2


Используя psql, создайте БД test_database.

Изучите бэкап БД.

Восстановите бэкап БД в test_database.

Перейдите в управляющую консоль psql внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах.



```
test_database=# select tablename, attname, avg_width  from pg_stats where tablename='orders'
order by avg_width desc limit 1;
 tablename | attname | avg_width 
-----------+---------+-----------
 orders    | title   |        16
(1 row)

test_database=# 
```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время. Вам как успешному выпускнику курсов DevOps в Нетологии предложили провести разбиение таблицы на 2: шардировать на orders_1 - price>499 и orders_2 - price<=499.

Предложите SQL-транзакцию для проведения этой операции.

Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?

```
test_database=# CREATE TABLE orders_1 (CHECK (price > 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO orders_1 SELECT * FROM orders WHERE price > 499;
INSERT 0 3
test_database=# CREATE TABLE orders_2 (CHECK (price <= 499)) INHERITS (orders);
CREATE TABLE
test_database=# INSERT INTO orders_2 SELECT * FROM orders WHERE price <= 499;
INSERT 0 5
test_database=# DELETE FROM only orders ;

test_database=# CREATE RULE news_insert_to_orders_1 AS ON INSERT TO orders
test_database-# WHERE ( price > 499 )
test_database-# DO INSTEAD INSERT INTO orders_1 VALUES (NEW.*);
CREATE RULE
test_database=# CREATE RULE news_insert_to_orders_2 AS ON INSERT TO orders
test_database-# WHERE ( price <= 499 )
test_database-# DO INSTEAD INSERT INTO orders_2 VALUES (NEW.*);
CREATE RULE
test_database=# 

```


Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?


Да, можно было бы. Можно было создать партицированную таблицу или написать свой собсвтенный триггер для вставки данных, который бы делил входные данные по признаку цены и писал бы их в соответсвующие таблицы

## Задача 4

Используя утилиту pg_dump, создайте бекап БД test_database.

`pg_dump -U postgres -d test_database > /bitnami/postgresql/backups/test_database.sql`

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database?

Добавить свойство UNIQUE.
```sql
CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) UNIQUE NOT NULL,
    price integer DEFAULT 0
);

``` 


