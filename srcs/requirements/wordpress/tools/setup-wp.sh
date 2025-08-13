#!/bin/bash

DIR="/var/www/wordpress/"
CONF="wp-config.php"

if [ ! -f "${DIR}/wp-load.php" ]; then
    echo "downloading Wordpress core files..."
    wp core download --path="${DIR}" --allow-root
fi

if [ ! -f "${DIR}${CONF}" ]; then
    echo "creating wp-config.php..."
    cp "${DIR}wp-config-sample.php" "${DIR}wp-config.php"
fi
sed -i "s/database_name_here/${SQL_DATABASE}/" "${DIR}${CONF}"
sed -i "s/username_here/${SQL_USER}/" "${DIR}${CONF}"
sed -i "s/password_here/${SQL_PASSWORD}/" "${DIR}${CONF}"
sed -i "s/localhost/${SQL_HOST}/" "${DIR}${CONF}"
echo "wp-config.php updated with database credentials."

if [ ! wp core is-installed --path=${DIR} --allow-root 2>/dev/null ];then
    echo "installing [ wordpress ]..."
    wp core install \
    --url="https://${DOMAINE_NAME}" \
    --path="${DIR}" \
    --title="WP-TITLE" \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASS} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --allow-root
fi
echo "[ wordpress ] installed successfully!"

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
