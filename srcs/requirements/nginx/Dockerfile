FROM alpine:3.20.6

RUN apk update && \
	apk add --no-cache \
	nginx \
	openssl

EXPOSE 443

RUN mkdir -p /run/nginx /etc/nginx/ssl

RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes -out \
/etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj \
"/C=FI/ST=Helsinki/L=Helsinki/O=42/OU=Hive/CN=esalmela.42.fr"

RUN adduser -D -H -s /sbin/nologin -G www-data -g www-data www-data

COPY ./requirements/nginx/conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/nginx.conf

CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]