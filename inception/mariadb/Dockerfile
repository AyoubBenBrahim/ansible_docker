FROM debian:buster

ARG BUILD_DATE

LABEL version="1.0" \
   description="This Is a mariadb Image" \
   maintainer="ayoub@gmail.com" \
   build-date=${BUILD_DATE}

RUN apt-get update \
   && apt-get upgrade -y \
   && apt-get install mariadb-server mariadb-client -y

#bind-address = 127.0.0.1
RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/launch_db.sh ./
RUN chmod 777 ./launch_db.sh

EXPOSE 3306

ENTRYPOINT sh ./launch_db.sh
