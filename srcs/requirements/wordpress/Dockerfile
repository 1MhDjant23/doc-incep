FROM ubuntu:plucky-20250714

RUN apt-get update && apt-get upgrade && \
    apt-get -y install wget && \
    apt-get clean

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress /var/www/wordpress && \
    rm -rf latest.tar.gz

WORKDIR /var/www/html