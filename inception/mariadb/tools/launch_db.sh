#!/bin/sh

if [ ! -d /var/lib/mysql/$DB_NAME ]; then

    service mysql start
    
    echo "-----------\033[0;32mMySQL CREATE USER------------------\033[0m"
    
    echo "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}'" | mysql -u root
    echo "GRANT ALL PRIVILEGES ON * . * TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}'" | mysql -u root
    echo "FLUSH PRIVILEGES" | mysql -u root
    
    echo "-----------\033[0;32mMySQL CREATE DATABASE------------------\033[0m"
    
    echo "CREATE DATABASE $DB_NAME;" | mysql -u root
    echo "FLUSH PRIVILEGES" | mysql -u root
    
    echo "-----------\033[0;32mMySQL UPDATE ROOT PASSWORD USER------------------\033[0m"
    
    echo "ALTER USER 'root'@localhost IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" | mysql -u root
    echo "FLUSH PRIVILEGES;" | mysql -u root
    
    echo "\033[0;32m--------------------------------\033[0m"

fi 

kill `cat /var/run/mysqld/mysqld.pid`

mysqld_safe