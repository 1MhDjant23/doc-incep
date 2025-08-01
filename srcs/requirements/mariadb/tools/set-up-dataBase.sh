#!/bin/bash

set -a
source /.env
set +a

echo "starting mariadb server .."
mysqld_safe &

until mysqladmin ping --silent; do
    echo "waiting for mariadb .."
done

mysql -e "CREATE DATABASE IF NOT EXISTS \'${MYSQL_DATABASE}\';"
echo "wordpress DataBase has been created!"
mysql -e "CREATE USER IF NOT EXISTS \'${MYSQL_USER}\'@'localhost' IDENTIFIED BY \'${MYSQL_PASSWORD}\';"
mysql -e "GRANTs ALL PRIVILEGES ON \'${MYSQL_DATABASE}\'.* TO \'${MYSQL_USER}\'@'%' IDENTIFIED BY \'${MYSQL_PASSWORD}\';"
echo "new user '${MYSQL_USER}' created with All privileges!"
mysql -e "FLUSH ALL PRIVILEGES"