# Домашнее задание к занятию "`Система мониторинга Zabbix`" - `Гущин Евгений`

### Задание 1

```bash
apt update
apt install postgresql

wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu22.04_all.deb
dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb
apt update

apt install zabbix-server-pgsql zabbix-frontend-php php8.1-pgsql zabbix-apache-conf zabbix-sql-scripts

su - postgres -c 'psql --command "CREATE USER zabbix WITH PASSWORD '\'MY_PASSWORD\'';"'
su - postgres -c 'psql --command "CREATE DATABASE zabbix OWNER zabbix;"'

sed -i 's/# DBPassword=/DBPassword=MY_PASSWORD/g' /etc/zabbix/zabbix_server.conf

systemctl restart zabbix-server apache2
systemctl enable zabbix-server apache2
```

![z_login](../../img/SMON/HW2_img/Task1_1.png?raw=true)
![CPU monitoring 2](../../img/SMON/HW2_img/Task1_2.png?raw=true)


---

### Задание 2

![CPU alert 1](../../img/SMON/Task2_1.png?raw=true)
![CPU alert 2](../../img/SMON/Task2_2.png?raw=true)
