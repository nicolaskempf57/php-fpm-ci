FROM registry.dev.nicolaskempf.fr/nicolaskempf57/php-fpm
USER "root"
RUN apk update \
    && apk add --no-cache openssh \
    && apk add --no-cache sshpass
USER "www-data"