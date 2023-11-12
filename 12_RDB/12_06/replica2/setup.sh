#!/bin/bash
sql_replica_user='CREATE USER "replication"@"%"; GRANT REPLICATION SLAVE ON *.* TO "replication"@"%"; FLUSH PRIVILEGES;'
docker exec mysql-master1 sh -c "mysql -u root -p12345 -e '$sql_replica_user'"
docker exec mysql-master2 sh -c "mysql -u root -p12345 -e '$sql_replica_user'"

for mysql_host in 'mysql-master1' 'mysql-master2'
do
    MS_STATUS=`docker exec $mysql_host sh -c 'mysql -u root -p12345 -e "SHOW MASTER STATUS"'`
    CURRENT_LOG=`echo $MS_STATUS | awk '{print $6}'`
    CURRENT_POS=`echo $MS_STATUS | awk '{print $7}'`
    host='mysql-master1'
    if [[ "$mysql_host" == "mysql-master1" ]]; then
        host='mysql-master2'
    fi
    sql_set_master="CHANGE MASTER TO MASTER_HOST='$host',MASTER_USER='replication',MASTER_LOG_FILE='$CURRENT_LOG',MASTER_LOG_POS=$CURRENT_POS; START SLAVE;"
    start_slave_cmd='mysql -u root -p12345 -e "'
    start_slave_cmd+="$sql_set_master"
    start_slave_cmd+='"'
    docker exec $mysql_host sh -c "$start_slave_cmd"
done

# MS_STATUS=`docker exec mysql-master sh -c 'mysql -u root -p12345 -e "SHOW MASTER STATUS"'`
# CURRENT_LOG=`echo $MS_STATUS | awk '{print $6}'`
# CURRENT_POS=`echo $MS_STATUS | awk '{print $7}'`
# sql_set_master="CHANGE MASTER TO MASTER_HOST='mysql-master',MASTER_USER='replication',MASTER_LOG_FILE='$CURRENT_LOG',MASTER_LOG_POS=$CURRENT_POS; START SLAVE;"
# start_slave_cmd='mysql -u root -p12345 -e "'
# start_slave_cmd+="$sql_set_master"
# start_slave_cmd+='"'
# docker exec mysql-slave sh -c "$start_slave_cmd"
# docker exec mysql-slave sh -c "mysql -u root -p12345 -e 'SHOW SLAVE STATUS \G'"