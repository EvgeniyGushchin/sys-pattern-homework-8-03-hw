# Домашнее задание к занятию "6.2. SQL"

## Задача 1

[docker-compose.yml](docker-compose.yml)

```bash
 mysql -u user -p test_db < /tmp/test_dump.sql


mysql> \s
--------------
mysql  Ver 8.2.0 for Linux on aarch64 (MySQL Community Server - GPL)

Connection id:22
Current database:
Current user:user@localhost
SSL:Not in use
Current pager:stdout
Using outfile:''
Using delimiter:;
Server version:8.2.0 MySQL Community Server - GPL
Protocol version:10
Connection:Localhost via UNIX socket
Server characterset:utf8mb4
Db     characterset:utf8mb4
Client characterset:latin1
Conn.  characterset:latin1
UNIX socket:/var/run/mysqld/mysqld.sock
Binary data as:Hexadecimal
Uptime:14 min 26 sec

Threads: 2  Questions: 106  Slow queries: 0  Opens: 150  Flush tables: 3  Open tables: 68  Queries per second avg: 0.122
--------------

mysql> 


mysql> use test_db;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.01 sec)

mysql> 


mysql> select count(*) from orders where price > 300;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.02 sec)

mysql> 
```

## Задача 2


```bash
mysql> CREATE USER 'test'@'%' IDENTIFIED WITH mysql_native_password BY 'test_pass' WITH MAX_QUERIES_PER_HOUR 100 PASSWORD EXPIRE INTERVAL 180 DAY FAILED_LOGIN_ATTEMPTS 3  ATTRIBUTE '{"last_name": "Pretty", "first_name": "James"}';
Query OK, 0 rows affected (0.02 sec)

mysql> grant select on test_db.* to test;
Query OK, 0 rows affected (0.01 sec)

mysql> select * from information_schema.user_attributes where user = 'test';
+------+------+------------------------------------------------+
| USER | HOST | ATTRIBUTE                                      |
+------+------+------------------------------------------------+
| test | %    | {"last_name": "Pretty", "first_name": "James"} |
+------+------+------------------------------------------------+
1 row in set (0.01 sec)

mysql> 
```

## Задача 3



```bash
mysql> SELECT table_schema,table_name,engine FROM information_schema.tables WHERE table_schema = 'test_db';
+--------------+------------+--------+
| TABLE_SCHEMA | TABLE_NAME | ENGINE |
+--------------+------------+--------+
| test_db      | orders     | InnoDB |
+--------------+------------+--------+
1 row in set (0.01 sec)

mysql> set profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> alter table orders engine = MyIsam;
Query OK, 5 rows affected (0.05 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> alter table orders engine = InnoDB;
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> show profiles;
+----------+------------+------------------------------------+
| Query_ID | Duration   | Query                              |
+----------+------------+------------------------------------+
|        1 | 0.00233475 | alter table orders engine = MyIsam |
|        2 | 0.00325000 | SELECT DATABASE()                  |
|        3 | 0.00704225 | show databases                     |
|        4 | 0.00252150 | show tables                        |
|        5 | 0.04738375 | alter table orders engine = MyIsam |
|        6 | 0.02639575 | alter table orders engine = InnoDB |
+----------+------------+------------------------------------+
6 rows in set, 1 warning (0.00 sec)

mysql> 

```

## Задача 4


```bash
# For advice on how to change settings please see
# http://dev.mysql.com/doc/refman/8.2/en/server-configuration-defaults.html

[mysqld]
#
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
#
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M

# Remove leading # to revert to previous value for default_authentication_plugin,
# this will increase compatibility with older clients. For background, see:
# https://dev.mysql.com/doc/refman/8.2/en/server-system-variables.html#sysvar_default_authentication_plugin
# default-authentication-plugin=mysql_native_password
skip-host-cache
skip-name-resolve
datadir=/var/lib/mysql
socket=/var/run/mysqld/mysqld.sock
secure-file-priv=/var/lib/mysql-files
user=mysql

pid-file=/var/run/mysqld/mysqld.pid

innodb_flush_log_at_trx_commit = 0

innodb_file_format=Barracuda

#Set buffer
innodb_log_buffer_size  = 1M

#Set Cache size
key_buffer_size = 307М

#Set log size
max_binlog_size = 100M

[client]
socket=/var/run/mysqld/mysqld.sock

!includedir /etc/mysql/conf.d/
```

