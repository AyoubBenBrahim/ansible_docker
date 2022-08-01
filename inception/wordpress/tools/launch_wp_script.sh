#!/bin/sh

until mariadb -h mariadb -P$DB_PORT -u$DB_USER -p$DB_PASSWORD -e '\c'; do
  echo >&2 "\033[41mWordpress is Waiting for mariadb - sleeping.....\033[0m"
  sleep 2
done

# sed -i "s/database_name_here/$DB_NAME/g" /var/www/wordpress/wp-config.php
# sed -i "s/username_here/$DB_USER/g" /var/www/wordpress/wp-config.php
# sed -i "s/password_here/$DB_PASSWORD/g" /var/www/wordpress/wp-config.php
# sed -i "s/localhost/$DB_HOST/g" /var/www/wordpress/wp-config.php

sleep 5

if ! wp core is-installed; then

# ****************
wp core download --path=/var/www/wordpress --version=6.0 --allow-root
wp core config --path=/var/www/wordpress --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --skip-check --allow-root --extra-php <<PHP
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DATABASE', 0 );
PHP
# ***************

# wp core install --url=https://localhost/ --title='inception' --admin_user=$WP_ADMIN_USER --admin_email=1337@1337.ma --admin_password=$WP_ADMIN_USER_PASSWORD --path=/var/www/wordpress --allow-root 
wp core install --url=https://aybouras.42.fr/ --title='inception' --admin_user=$WP_ADMIN_USER --admin_email=1337@1337.ma --admin_password=$WP_ADMIN_USER_PASSWORD --path=/var/www/wordpress --allow-root 

wp user create $WP_USER inception123@gmail.com --role=subscriber  --user_pass=$WP_USER_PASSWORD  --path=/var/www/wordpress  --allow-root 

wp theme install twentytwenty --path=/var/www/wordpress  --allow-root  --activate 

wp plugin install redis-cache --path=/var/www/wordpress --allow-root  --activate
wp redis update-dropin --path=/var/www/wordpress  --allow-root 
wp redis enable 

wp user create user_1337 --role=author --user_pass=1337 --path=/var/www/wordpress  --allow-root 
wp post create --post_title="Hi Coders!" --post_content="Hi from 1337 , coding school from Morocco" --post_status=publish --post_author="user_1337" --path=/var/www/wordpress  --allow-root 

fi

php-fpm7.3 --nodaemonize
