#!/bin/bash

cd /var/www/wordpress/ && cp wp-config-sample.php wp-config.php && \
    sed -i 's/password_here/niki_simo/' wp-config.php

#   start PHP-FPM ON FOREGROUND #

php-fpm8.4 -F