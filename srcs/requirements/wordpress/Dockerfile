FROM alpine:3.20.6

RUN addgroup -S nginx && \
    adduser -S -G nginx nginx

RUN apk update && apk add --no-cache \
	php82 \
	php82-phar \
	php82-curl \
	php82-fpm \
	php82-mysqli \
	php82-mbstring \
	php82-json \
	php82-gd \
	php82-xml \
	php82-zip \
	mariadb-client

EXPOSE 9000

RUN ln -sf /usr/bin/php82 /usr/bin/php

RUN mkdir -p /run/php /var/www/html

COPY ./requirements/wordpress/conf/www.conf /etc/php8/php-fpm.d/www.conf

COPY ./requirements/wordpress/tools/wpscript.sh /tmp/wpscript.sh

RUN chmod +x /tmp/wpscript.sh

ENTRYPOINT ["sh", "/tmp/wpscript.sh"]
