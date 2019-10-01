FROM registry.dev.nicolaskempf.fr/nicolaskempf57/php-fpm
USER "root"
COPY get-sentry-cli.sh /usr/local/bin/get-sentry-cli
RUN apk update \
    && apk add --no-cache openssh sshpass curl\
    && /usr/local/bin/get-sentry-cli
USER "www-data"
