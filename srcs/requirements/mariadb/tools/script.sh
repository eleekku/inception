#!/bin/sh

# Prepare directories and rights
mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/log/mysql
chown -R mysql:mysql /var/lib/mysql

# init database
mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

# Enforce root pw, create db, add user, give rights
mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test; 
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

ALTER USER 'root'@'localhost' IDENTIFIED BY 'es';
CREATE DATABASE wordpress CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER es@'%' IDENTIFIED by 'ab';
GRANT ALL PRIVILEGES ON wordpress.* TO 'es'@'%';
GRANT ALL PRIVILEGES ON *.* TO es@'%' IDENTIFIED BY 'ab' WITH GRANT OPTION;
GRANT SELECT ON mysql.* TO es@'%';
FLUSH PRIVILEGES;
EOF

exec mysqld --defaults-file=/etc/my.cnf.d/mariadb-server.cnf
