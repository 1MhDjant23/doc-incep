FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/private.key \
    -out /etc/nginx/ssl/certificate.crt \
    -subj "/C=MA/ST=Tanger-Tetouan-Al Hoceima/L=Martil/O=1337/CN=mait-taj.42.fr"

EXPOSE 443

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]