FROM alpine:3.20.6

RUN addgroup -S nginx && \
	adduser -S -G nginx nginx

RUN apk update && apk add --no-cache \
        php8 \
		php8-fpm \
		php8-mysqli \
		php8-mbstring \
		php8-json \
		php8-session \
		php8-common \
		php8-iconv \
		php8-xml \
		php8-xmlreader \
		php8-xmlwriter \
		php8-simplexml \
		php8-tokenizer \
		php8-ctype \
		php8-dom \
		php8-filter \
		php8-hash \
		php8-pdo \
		php8-pdo_mysql \
		php8-pdo_sqlite \
		php8-phar \
		php8-posix \
		php8-openssl \
		php8-session \
		mariadb-client

EXPOSE 9000

RUN ln -s /usr/bin/php8 /usr/bin/php

RUN mkdir -p /run/php /var/www/html

COPY ./requirements/wordpress/conf/www.conf /etc/php8/php-fpm.d/www.conf

COPY ./requirements/wordpress/tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

ENTRYPOINT ["sh", "/tmp/script.sh"]




