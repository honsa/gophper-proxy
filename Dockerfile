#FROM php:7.2.2-fpm
FROM php:7.2-apache

RUN apt-get update && \
    apt-get install -y git sqlite3 zlib1g-dev mysql-client libssl-dev --no-install-recommends \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && docker-php-ext-install pdo_mysql mysqli zip \
    && a2enmod rewrite

WORKDIR /var/www/html
COPY ./ /var/www/html/

COPY php-debugging.ini $PHP_INI_DIR/conf.d/

RUN composer install --prefer-source --no-interaction
#php composer.phar install

#RUN pecl install swoole
#RUN docker-php-ext-enable swoole
