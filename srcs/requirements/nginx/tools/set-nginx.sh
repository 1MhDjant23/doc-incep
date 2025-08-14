#!/bin/bash

if [ -f /etc/nginx/nginx.conf.backup ]; then
    cp /etc/nginx/nginx.conf.backup /etc/nginx/nginx.conf
else
    cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
fi

# Add your server block to the existing nginx.conf
sed -i '/http {/a \
    server {\
        listen 443 ssl;\
        ssl_protocols TLSv1.2 TLSv1.3;\
        server_name '${DOMAIN_NAME}';\
        ssl_certificate /etc/nginx/ssl/certificate.crt;\
        ssl_certificate_key /etc/nginx/ssl/private.key;\
        root /var/www/wordpress;\
        index index.php index.html;\
        \
        location / {\
            try_files $uri $uri/ /index.php?$args;\
        }\
        \
        location ~ \.php$ {\
            include fastcgi_params;\
            fastcgi_pass wordpress:9000;\
            fastcgi_index index.php;\
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;\
        }\
    }' /etc/nginx/nginx.conf

# Test configuration
nginx -t

# Start nginx
nginx -g "daemon off;"