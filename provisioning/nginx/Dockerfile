# FROM debian:buster AS build-stage

# RUN apt-get update \
#     && apt-get upgrade -y \
#     && apt-get install openssl nginx -y 

# WORKDIR /my_certs

# RUN openssl req  -nodes -new -x509 -days 3650 -keyout inception.key -out inception.crt -subj "/C=MA/ST=KH/L=khouribga/O=1337/OU=Org/CN=www.1337.ma"

# # COPY ./conf/wordpress.conf /etc/nginx/sites-available/
# COPY ./conf/default /etc/nginx/sites-available/

# # RUN ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/wordpress.conf \
# #     && unlink /etc/nginx/sites-enabled/default \
# #     && cp -p /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-available/wordpress.conf.bak


FROM debian:buster AS final-stage

ARG BUILD_DATE

LABEL version="1.0" \
    description="This Is a Nginx Image" \
    maintainer="ayoub@gmail.com" \
    build-date=${BUILD_DATE}

# RUN apt-get update \
#     && apt-get upgrade -y \
#     && apt-get install nginx -y \
#     && rm -rf /etc/nginx

# COPY --from=build-stage /my_certs/* /etc/ssl/
# COPY --from=build-stage /etc/nginx /etc/nginx/

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install openssl nginx -y 

RUN openssl req  -nodes -new -x509 -days 3650 -keyout /etc/ssl/inception.key -out /etc/ssl/inception.crt -subj "/C=MA/ST=KH/L=khouribga/O=1337/OU=Org/CN=www.1337.ma"
COPY ./conf/default /etc/nginx/sites-available/

RUN rm -rf /var/www/html  
RUN mkdir -p /var/www/wordpress
RUN mkdir -p /var/www/adminer

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]

