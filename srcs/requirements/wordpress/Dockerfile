FROM ubuntu:plucky-20250714

RUN apt-get update && \
    apt-get -y install php-fpm wget && \
    apt-get clean

RUN mkdir -p /var/www/wordpress

RUN wget https://wordpress.org/latest.tar.gz

RUN tar -xzf latest.tar.gz

RUN mv wordpress /var/www/wordpress

RUN rm -rf latest.tar.gz

WORKDIR /var/www/wordpress

# RUN cp wp-config-sample.php

CMD [ "php-fpm8.4", "-F" ]