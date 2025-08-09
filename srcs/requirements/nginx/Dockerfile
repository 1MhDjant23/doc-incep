FROM ubuntu:plucky-20250714

RUN apt-get update && apt-get install -y nginx openssl &&\
    apt-get clean
    
RUN mkdir -p /etc/nginx/ssl

COPY ./tools/set-nginx.sh /

COPY ./conf/nginx-conf /etc/nginx

RUN chmod +x /set-nginx.sh

EXPOSE 443

ENTRYPOINT [ "./set-nginx.sh" ]
