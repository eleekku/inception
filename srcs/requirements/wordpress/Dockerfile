FROM alpine:3.20.6

RUN addgroup -S nginx && \
	adduser -S -G nginx nginx

RUN apk update && apk add --no-cache \
        php81 \
		php81-fpm \
		php81-mysqli \
		php81-mbstring \
		php81-json \
		php81-session \
		php81-common \
		php81-iconv \
		php81-xml \
		php81-xmlreader \
		php81-xmlwriter \
		php81-simplexml \
		php81-tokenizer \
		php81-ctype \
		php81-dom \
		php81-filter \
		php81-hash \
		php81-pdo \
		php81-pdo_mysql \
		php81-pdo_sqlite \
		php81-phar \
		php81-posix \
		php81-openssl \
		php81-session \
		mariadb-client

EXPOSE 9000

RUN ln -s /usr/bin/php8 /usr/bin/php

RUN mkdir -p /run/php /var/www/html

COPY ./requirements/wordpress/conf/www.conf /etc/php8/php-fpm.d/www.conf

COPY ./requirements/wordpress/tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

ENTRYPOINT ["sh", "/tmp/script.sh"]




