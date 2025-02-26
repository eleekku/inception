#!/bin/sh

attempts=0
while [ $attempts -lt 5 ]; do
	if mysqladmin ping -h mysql -u root -p$MYSQL_ROOT_PASSWORD > /dev/null 2>&1; then
		break
	fi
	attempts=$((attempts + 1))
	sleep 5
done
echo "MariaDB is up"

echo "Listing databases"
mariadb -h mysql -u $WP_DB_USER -p $WP_DB_PWD -e "show databases;"
EOF

cd /var/www/html/

wget -g https://wordpress.org/latest.tar.gz

chmod +x /usr/local/bin/wp

echo "Downloading and installing WordPress"

wp core download --allow-root

echo "Creating wp-config.php"

wp config create \
	--dbname=$WP_DB_NAME \
	--dbuser=$WP_DB_USER \
	--dbpass=$WP_DB_PWD \
	--dbhost=$MYSQL_HOST \
	--path=/var/www/html \
	--force

wp core install \
	--url=$DOMAIN_NAME \
	--title=$WP_TITLE \
	--admin_user=$WP_ADMIN \
	--admin_password=$WP_ADMIN_PWD \
	--admin_email=$WP_ADMIN_EMAIL \
	--path=/var/www/html \
	--allow-root \
	--skip-email

wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PWD --path=/var/www/html --allow-root

wp theme install neve \
	--activate \
	--allow-root

wp plhugin update --all

wp option update siteurl "http://$DOMAIN_NAME" --allow-root
wp option update home "http://$DOMAIN_NAME" --allow-root

chown -R nginx:nginx /var/www/html

chmod -R 755 /var/www/html

php-fpm7




