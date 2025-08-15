FROM debian:bookworm AS builder
RUN apt-get update && apt-get install -y \
    curl && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar && mv wp-cli.phar wp

FROM debian:bookworm
COPY --from=builder /wp /usr/local/bin/wp
RUN apt-get update && apt-get install -y \
    php php-mysql php-fpm sendmail default-mysql-client ca-certificates && \
    apt-get clean
COPY ./tools/setup-wp.sh / 

COPY ./tools/set-pro-them.sh /

RUN chmod +x /setup-wp.sh && \
    chmod +x /set-pro-them.sh

EXPOSE 9000

ENTRYPOINT [ "/setup-wp.sh" ]