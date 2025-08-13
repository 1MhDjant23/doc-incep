#!/bin/bash

mysqld_safe&

echo "running [ mariadb ] ..."

until mysqladmin ping --silent; do
    echo "waiting for mariadb..."
    sleep 2
done
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

echo "[ wordpress-db ] success."
mysql -e "CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';"

echo -e "user [ ${SQL_USER} ] for wordpress created with all privileges!"

mysql -e "FLUSH PRIVILEGES;"

# exec mysqld_safe
wait