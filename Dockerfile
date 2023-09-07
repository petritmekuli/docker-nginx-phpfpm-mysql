FROM php:8.2-fpm-alpine

WORKDIR /usr/share/nginx/html

RUN docker-php-ext-install pdo pdo_mysql

CMD ["php-fpm"]
