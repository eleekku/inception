FROM alpine:3.20.6

RUN addgroup -S nginx && \
    adduser -S -G nginx nginx

RUN apk update && apk add --no-cache \
        php \
        php-fpm \
        php-mysqli \
        php-mbstring \
        php-json \
        php-session \
        php-common \
        php-iconv \
        php-xml \
        php-xmlreader \
        php-xmlwriter \
        php-simplexml \
        php-tokenizer \
        php-ctype \
        php-dom \
        php-pdo \
        php-pdo_mysql \
        php-pdo_sqlite \
        php-phar \
        php-posix \
        php-openssl \
        php-session \
        mariadb-client \
        wget \
        curl \
        tar

EXPOSE 9000

RUN ln -sf /usr/bin/php8 /usr/bin/php

RUN mkdir -p /run/php /var/www/html

COPY ./requirements/wordpress/conf/www.conf /etc/php8/php-fpm.d/www.conf

COPY ./requirements/wordpress/tools/wpscript.sh /tmp/wpscript.sh

RUN chmod +x /tmp/wpscript.sh

ENTRYPOINT ["sh", "/tmp/wpscript.sh"]
