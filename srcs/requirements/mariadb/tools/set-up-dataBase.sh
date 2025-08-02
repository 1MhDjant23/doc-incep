#!/bin/bash

set -a
source /.env
set +a

mysqld_safe &

echo "starting mariadb server .."

until mysqladmin ping --silent; do
    echo "waiting.." > /dev/null
done

mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

echo "wordpress DataBase has been created!"

mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

echo "new user '${MYSQL_USER}' created with All privileges!"

mysql -e "FLUSH PRIVILEGES;"

mysqladmin shutdown

exec mysqld_safe
