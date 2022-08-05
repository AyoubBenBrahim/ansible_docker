FROM debian:buster

LABEL version="1.0" \
   description="This Is a phpmyadmin Image" \
   maintainer="ayoub@gmail.com"

RUN apt-get update \
	&& apt-get upgrade -y \
	php-cgi php-common php-fpm php-pear php-mbstring \
	php-zip php-net-socket php-gd php-xml-util \
	php-gettext php-mysql php-bcmath  vim curl unzip wget git -y \
	mariadb-client -y

RUN mkdir -p /var/www/phpmyadmin

WORKDIR /var/www/phpmyadmin/

RUN wget -q https://files.phpmyadmin.net/phpMyAdmin/5.2.0/phpMyAdmin-5.2.0-english.tar.gz
RUN tar -zxf phpMyAdmin-5.2.0-english.tar.gz \
	&& mv phpMyAdmin-5.2.0-english/* . \
	&& rm -rf phpMyAdmin-5.2.0-english*

RUN cp /var/www/phpmyadmin/config.sample.inc.php /var/www/phpmyadmin/config.inc.php

RUN sed -i 's/localhost/mariadb/g' /var/www/phpmyadmin/config.inc.php

RUN mkdir /run/php/
RUN sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 7000/g' /etc/php/7.3/fpm/pool.d/www.conf

# COPY ./tools/config.sh ./
# RUN chmod 777 ./config.sh

# # EXPOSE 3306

# ENTRYPOINT sh ./config.sh

# FROM alpine:latest

# RUN apk update
# RUN apk add phpmyadmin
# RUN mkdir -p /var/www/phpmyadmin/
# # RUN cp -r /usr/share/webapps/phpmyadmin/* /var/www/phpmyadmin/
# RUN ln -s /usr/share/webapps/phpmyadmin /var/www/phpmyadmin

ENTRYPOINT php-fpm7.3 --nodaemonize