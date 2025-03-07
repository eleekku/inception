FROM alpine:3.20.6

RUN addgroup -S nginx && \
    adduser -S -G nginx nginx

RUN apk update && apk add --no-cache \
	php83 \
	php83-phar \
	php83-curl \
	php83-fpm \
	php83-mysqli \
	php83-mbstring \
	php83-mbstring \
	php83-tokenizer \
	mariadb-client

EXPOSE 9000

RUN ln -sf /usr/bin/php83 /usr/bin/php

RUN mkdir -p /run/php /var/www/html

COPY ./requirements/wordpress/conf/www.conf /etc/php83/php-fpm.d/www.conf

COPY ./requirements/wordpress/tools/wpscript.sh /tmp/wpscript.sh

RUN chmod +x /tmp/wpscript.sh

ENTRYPOINT ["sh", "/tmp/wpscript.sh"]
