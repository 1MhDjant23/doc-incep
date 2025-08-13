FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/set-up-db.sh /

RUN chmod 644 /etc/mysql/mariadb.conf.d/my.cnf && \
    chmod +x /set-up-db.sh

EXPOSE 3306

ENTRYPOINT [ "/set-up-db.sh" ]