#!/bin/bash

echo "[ nginx ] generating ssl certificate..."

mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/private.key \
    -out /etc/nginx/ssl/certificate.crt \
    -subj "/C=MA/ST=Tetouan/L=Martile/O=42/CN=mait-taj.1337.ma"

echo "[ nginx ] private key and certificate generated with success."

echo "starting nginx in the foreground..."

exec nginx -g 'daemon off;'
