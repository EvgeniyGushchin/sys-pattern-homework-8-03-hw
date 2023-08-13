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
![z_login 2](../../img/SMON/HW2_img/Task1_2.png?raw=true)


---

### Задание 2

```bash
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu22.04_all.deb
dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb
apt update

apt install zabbix-agent

sudo sed -i 's/Server=127.0.0.1/Server=10.129.0.0\/24/g' /etc/zabbix/zabbix_agentd.conf

systemctl restart zabbix-agent
systemctl enable zabbix-agent
```

![Hosts](../../img/SMON/HW2_img/Task2_1.png?raw=true)
![Log Ubuntu 1](../../img/SMON/HW2_img/Task2_2.png?raw=true)
![Log Ubuntu master](../../img/SMON/HW2_img/Task2_3.png?raw=true)
![Monitoring Master](../../img/SMON/HW2_img/Task2_4.png?raw=true)
![Monitoring Ubuntu1](../../img/SMON/HW2_img/Task2_5.png?raw=true)
