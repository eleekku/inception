FROM alpine:latest

# Install MariaDB using apk
RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-server-utils

# Create required directories
RUN mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql

# Expose the MariaDB default port
EXPOSE 3306

# Start MariaDB when the container runs
CMD ["mysqld", "--datadir=/var/lib/mysql", "--user=mysql"]
