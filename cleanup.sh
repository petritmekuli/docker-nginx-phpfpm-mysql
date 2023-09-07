#!/bin/bash

# Delete all the containers
docker container rm -f php-fpm8.2-container nginx-phpfpm8.2-container mysql8-container

# Delete the php-network
docker network rm php-network

# Delete all the images
docker image rm -f php-fpm8.2:1.0 nginx-phpfpm8.2:1.0
