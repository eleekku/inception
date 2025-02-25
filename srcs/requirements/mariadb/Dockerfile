FROM alpine:3.20.6

RUN apk update && \
	apk add --no-cache \
	mariadb \
	mariadb-client

EXPOSE 3306

COPY ./requirements/mariadb/conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
RUN chmod 644 /etc/my.cnf.d/mariadb-server.cnf

COPY ./requirements/mariadb/tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

ENTRYPOINT ["sh", "/tmp/script.sh"]
