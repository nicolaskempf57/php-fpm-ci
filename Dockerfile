FROM registry.dev.nicolaskempf.fr/nicolaskempf57/php-fpm
USER "root"
RUN apk update \
    && apk add --no-cache openssh sshpass curl\
    && curl -sL https://sentry.io/get-cli/ | ash
USER "www-data"
