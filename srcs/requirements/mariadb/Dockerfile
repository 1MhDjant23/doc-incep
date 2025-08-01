FROM ubuntu:plucky-20250714

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y mariadb-server &&\
    apt-get clean

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/set-up-dataBase.sh /set-up-dataBase.sh

COPY .env /.env

RUN chmod 644 /etc/mysql/mariadb.conf.d/my.cnf && \
    chmod +x /set-up-dataBase.sh

ENTRYPOINT [ "/set-up-dataBase.sh" ]