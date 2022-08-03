FROM debian:buster

LABEL version="1.0" \
   description="This Is a mariadb Image" \
   maintainer="ayoub@gmail.com"

RUN apt-get update \
   && apt-get upgrade -y \
   && apt-get install mariadb-server -y

#bind-address = 127.0.0.1
RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/launch_db.sh ./
RUN chmod 777 ./launch_db.sh

ENTRYPOINT sh ./launch_db.sh


# FROM alpine:3.14
# RUN apk update && apk add --no-cache mysql-server

# COPY ./tools/launch_db.sh ./
# RUN chmod 777 ./launch_db.sh

# ENTRYPOINT sh ./launch_db.sh

