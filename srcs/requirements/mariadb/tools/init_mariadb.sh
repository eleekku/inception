#!/bin/sh

# Prepare directories and rights
mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/log/mysql
chown -R mysql:mysql /var/lib/mysql

# init database
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Enforce root pw, create db, add user, give rights
mysqld --user=mysql --bootstrap << lim
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test; 
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';

# Check if the database exists before creating it
CREATE DATABASE IF NOT EXISTS $WP_DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;

# Drop the user if it exists before creating it
DROP USER IF EXISTS '$WP_DB_USER'@'%';
CREATE USER '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PWD';
GRANT ALL PRIVILEGES ON $WP_DB_NAME.* TO '$WP_DB_USER'@'%';
GRANT ALL PRIVILEGES ON *.* TO '$WP_DB_USER'@'%' IDENTIFIED BY '$WP_DB_PWD' WITH GRANT OPTION;
GRANT SELECT ON mysql.* TO '$WP_DB_USER'@'%';
FLUSH PRIVILEGES;
lim

exec mysqld --defaults-file=/etc/my.cnf.d/mariadb-server.cnf
