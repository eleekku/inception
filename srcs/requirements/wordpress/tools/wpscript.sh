#!/bin/sh

echo "memory_limit = 512M" >> /etc/php8/php.ini

# Wait for MariaDB to be ready
attempts=0
while ! mariadb -h$MYSQL_HOST -u$WP_DB_USER -p$WP_DB_PWD $WP_DB_NAME &>/dev/null; do
    attempts=$((attempts + 1))
    echo "MariaDB unavailable. Attempt $attempts: Trying again in 5 sec."
    if [ $attempts -ge 12 ]; then
        echo "Max attempts reached. MariaDB connection could not be established."
        exit 1
    fi
    sleep 5
done
echo "MariaDB connection established!"

echo "Listing databases:"
mariadb -h$MYSQL_HOST -u$WP_DB_USER -p$WP_DB_PWD $WP_DB_NAME <<EOF
SHOW DATABASES;
EOF

# Set working dir
cd /var/www/html/

# Download WP CLI
wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp

# Make it executable
chmod +x /usr/local/bin/wp

# Download WordPress core
echo "Downloading WordPress core..."
wp core download --allow-root

# Create WordPress database config
echo "Creating WordPress database config..."
wp config create \
    --dbname=$WP_DB_NAME \
    --dbuser=$WP_DB_USER \
    --dbpass=$WP_DB_PWD \
    --dbhost=$MYSQL_HOST \
    --path=/var/www/html/ \
    --force

# Install WordPress and feed db config
wp core install \
    --url=$DOMAIN_NAME \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_USR \
    --admin_password=$WP_ADMIN_PWD \
    --admin_email=$WP_ADMIN_EMAIL \
    --allow-root \
    --skip-email \
    --path=/var/www/html/

# Create WordPress user
wp user create \
    $WP_USR \
    $WP_EMAIL \
    --role=author \
    --user_pass=$WP_PWD \
    --allow-root

# Install theme for WordPress
wp theme install neve  \
    --activate \
    --allow-root

# Update plugins
wp plugin update --all

# Update WP address and site address to match our domain
wp option update siteurl "https://$DOMAIN_NAME" --allow-root
wp option update home "https://$DOMAIN_NAME" --allow-root

# Transfer ownership to the user
chown -R nginx:nginx /var/www/html/

# Full permissions for owner, read/exec to others
chmod -R 755 /var/www/html/

# Fire up PHP-FPM (-F to keep in foreground and avoid recalling script)
php-fpm82 -F
