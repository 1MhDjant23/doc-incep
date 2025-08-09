FROM ubuntu:plucky-20250714

RUN apt-get update && \
    apt-get -y install mariadb-client unzip less php-fpm php-cli curl php8.4-mysqli wget && \
    apt-get clean

RUN mkdir -p /var/www/wordpress

RUN wget https://wordpress.org/latest.tar.gz

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN tar -xzf latest.tar.gz

RUN mv wordpress/* /var/www/wordpress/

RUN rm -rf latest.tar.gz


COPY ./conf/wordPress-config.sh / 

RUN chmod +x /wordPress-config.sh

EXPOSE 9000:9000

WORKDIR /var/www/wordPress

ENTRYPOINT [ "/wordPress-config.sh" ]
# RUN cd wordpress && cp wp-config-sample.php wp-config.php && \
#     sed -i 's/database_name_here/word_djant/' wp-config.php

# CMD [ "php-fpm8.4", "-F" ]