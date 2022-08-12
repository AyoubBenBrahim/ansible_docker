
FROM debian:buster

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install vim curl openssl nginx -y 

RUN openssl req  -nodes -new -x509 -days 3650 -keyout /etc/ssl/inception.key -out /etc/ssl/inception.crt -subj "/C=MA/ST=KH/L=khouribga/O=1337/OU=Org/CN=www.1337.ma"
COPY ./conf/default /etc/nginx/sites-available/
# COPY ./conf/index.html /var/www/html

RUN rm -rf /var/www/html  
RUN mkdir -p /var/www/wordpress
RUN mkdir -p /var/www/phpmyadmin

ENTRYPOINT ["nginx", "-g", "daemon off;"]

