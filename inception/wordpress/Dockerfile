
FROM debian:buster AS final-stage

ARG BUILD_DATE
LABEL version="1.0" \
	description="This Is a wordpress Image" \
	maintainer="ayoub@gmail.com"


RUN apt-get update \
	&& apt-get upgrade -y \
	php-cgi php-common php-fpm php-pear php-mbstring \
	php-zip php-net-socket php-gd php-xml-util \
	php-gettext php-mysql php-bcmath  vim curl unzip wget git -y \
	mariadb-client -y


RUN mkdir -p /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
RUN chmod +x ./wp-cli.phar
RUN mv ./wp-cli.phar /usr/local/bin/wp

COPY ./tools/*.sh /
RUN chmod +x /*.sh

RUN mkdir /run/php/
RUN sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

EXPOSE 9000

ENTRYPOINT sh /launch_wp_script.sh




