#!/bin/bash

# Create php-network
docker network create php-network

# Create php-fpm image
docker build -t php-fpm8.2:1.0 .

# Create php-fpm container
docker run -p 9000:9000 -d --name php-fpm8.2-container --network php-network -v ~/Sites/docker-nginx-phpfpm-mysql/src:/usr/share/nginx/html -it php-fpm8.2:1.0

# Create nginx image
docker build -t nginx-phpfpm8.2:1.0 nginx

# Create nginx container
docker run -d --name nginx-phpfpm8.2-container --network php-network -v ~/Sites/docker-nginx-phpfpm-mysql/src:/usr/share/nginx/html -p 8080:80 nginx-phpfpm8.2:1.0

# Create composer container
docker run --rm --interactive --tty composer --version

# Create mysql container
docker run --network php-network -p 3306:3306 --name mysql8-container -v /Users/petritmekuli/mysql-volumes/mysql8:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password -d mysql:8
