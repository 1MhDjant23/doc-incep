FROM ubuntu:plucky-20250714

RUN apt-get update && \
    apt-get -y install php-fpm wget && \
    apt-get clean

RUN mkdir -p /var/www/wordpress

RUN wget https://wordpress.org/latest.tar.gz

RUN tar -xzf latest.tar.gz

RUN mv wordpress /var/www/wordpress

RUN rm -rf latest.tar.gz

COPY ./conf/wordPress-config.sh / 

RUN chmod +x /wordPress-config.sh

# WORKDIR /var/www/wordpress

ENTRYPOINT [ "/wordPress-config.sh" ]
# RUN cd wordpress && cp wp-config-sample.php wp-config.php && \
#     sed -i 's/database_name_here/word_djant/' wp-config.php

# CMD [ "php-fpm8.4", "-F" ]