#!/bin/bash

DIR="/var/www/wordpress/"
CONF="wp-config.php"

until mysql -h"$SQL_HOST" -P"3306" -u"$WP_ADMIN_USER" -p"$WP_ADMIN_PASS" -e "USE $SQL_DATABASE;" 2>/dev/null; do
    echo "waiting for mariadb..." 
    sleep 0.5
done

if [ ! -f "${DIR}/wp-load.php" ]; then
    echo "downloading Wordpress core files..."
    wp core download --path="${DIR}" --allow-root
fi

if [ ! -f "${DIR}${CONF}" ]; then
    echo "creating wp-config.php..."
    cp "${DIR}wp-config-sample.php" "${DIR}wp-config.php"
fi
sed -i "s/database_name_here/${SQL_DATABASE}/" "${DIR}${CONF}"
sed -i "s/username_here/${WP_ADMIN_USER}/" "${DIR}${CONF}"
sed -i "s/password_here/${WP_ADMIN_PASS}/" "${DIR}${CONF}"
sed -i "s/localhost/${SQL_HOST}/" "${DIR}${CONF}"
echo "wp-config.php updated with database credentials."

sed -i 's|listen = /run/php/php8.2-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf

if ! wp core is-installed --path="${DIR}" --allow-root 2>/dev/null; then
    echo "installing [ wordpress ]..."
    wp core install \
    --url="$DOMAIN_NAME" \
    --path="${DIR}" \
    --title="$WP_TITLE" \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASS} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --allow-root
    echo "[ wordpress ] installed successfully!"
    else
        echo "[ wordpress ] already installed!"
fi

if ! wp user get "${WP_USER}" --path="${DIR}" --allow-root >/dev/null 2>&1; then
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --path="${DIR}" \
        --role="${WP_USER_ROLE}" \
        --user_pass="${WP_USER_PASS}" \
        --allow-root
echo "[ wordpress ] creating an ${WP_USER_ROLE} user '${WP_USER}'"
fi

echo "running php-fpm on foreground..."

php-fpm8.2 -F
