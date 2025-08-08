#!/bin/bash

DIR="/var/www/wordpress"

 cp ${DIR}/wp-config-sample.php ${DIR}/wp-config.php && \
    sed -i 's/password_here/1234/' ${DIR}/wp-config.php
    sed -i 's/database_name_here/wordpress/' ${DIR}/wp-config.php
    sed -i 's/username_here/mait-taj/' ${DIR}/wp-config.php
    sed -i 's/localhost/db/' ${DIR}/wp-config.php


#   start PHP-FPM ON FOREGROUND #
wp core install --url="http://localhost" --title="mait-taj Site" --admin_user="admin" --admin_password="1234" --admin_email="admin@example.com" --path=/var/www/wordpress --allow-root


# wp user create mohamed mohamed@gmail.com --role=administrator --path=/var/www/wordpress --user_pass=1234 --allow-root
# wp --info --allow-root --path=/var/www/wordpress

php-fpm8.4 -F
