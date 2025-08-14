#!/bin/bash

mysqld_safe&

echo "running [ mariadb ] ..."

until mysqladmin ping --silent; do
    echo "waiting for mariadb..." 2>/dev/null
    # sleep 2
done
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

echo "[ wordpress-db ] success."
mysql -e "CREATE USER IF NOT EXISTS '${WP_ADMIN_USER}'@'%' IDENTIFIED BY '${WP_ADMIN_PASS}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${WP_ADMIN_USER}'@'%';"

echo -e "user [ ${WP_ADMIN_USER} ] for wordpress created with all privileges!"

mysql -e "FLUSH PRIVILEGES;"
mysqladmin shutdown

exec mysqld_safe
# wait