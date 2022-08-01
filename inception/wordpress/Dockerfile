# FROM debian:buster AS build-stage

# RUN apt-get update \
# 	&& apt-get upgrade -y \
# 	&& apt-get install vim curl unzip wget git -y 



# WORKDIR /var/www/
# RUN wget http://wordpress.org/latest.tar.gz \
# 	&& tar -xzvf latest.tar.gz && rm -rf latest.tar.gz \
# 	&& cp ./wordpress/wp-config-sample.php ./wordpress/wp-config.php \
# 	&& apt-get autoclean && apt-get autoremove

# WORKDIR  /var/www/wordpress

# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
# RUN chmod +x /var/www/wordpress/wp-cli.phar

FROM debian:buster AS final-stage

ARG BUILD_DATE
LABEL version="1.0" \
	description="This Is a wordpress Image" \
	maintainer="ayoub@gmail.com" \
	build-date=${BUILD_DATE}

RUN apt-get update \
	&& apt-get upgrade -y \
	php-cgi php-common php-fpm php-pear php-mbstring \
	php-zip php-net-socket php-gd php-xml-util \
	php-gettext php-mysql php-bcmath  vim curl unzip wget git -y \
	mariadb-client -y

# COPY --from=build-stage /var/ /var/

# RUN wget http://wordpress.org/latest.tar.gz \
# 	&& tar -xzvf latest.tar.gz && rm -rf latest.tar.gz \
# 	&& cp ./wordpress/wp-config-sample.php ./wordpress/wp-config.php \
# 	&& apt-get autoclean && apt-get autoremove
RUN mkdir -p /var/www/wordpress
# RUN cp -r /wordpress/* /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

# RUN wget http://download.redis.io/redis-stable.tar.gz \
# 	&& tar xvzf redis-stable.tar.gz && rm -rf redis-stable.tar.gz
# RUN mv redis-stable /var/www/wordpress/wp-content/plugins/

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
RUN chmod +x ./wp-cli.phar
RUN mv ./wp-cli.phar /usr/local/bin/wp

# RUN mkdir scripts
COPY ./tools/*.sh /
RUN chmod +x /*.sh

RUN mkdir /run/php/
RUN sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

EXPOSE 9000

ENTRYPOINT sh /launch_wp_script.sh




