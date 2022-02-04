FROM php:8.1.2-fpm

# Workaround for sockets error
ENV CFLAGS="$CFLAGS -D_GNU_SOURCE"

RUN apt-get update -y && apt-get -y install \
    curl \
    libcurl4-openssl-dev \
    unzip \
    libxml2-dev \
    zlib1g-dev \
    libicu-dev \
    g++ \
    libldb-dev \
    libldap2-dev \
    sqlite3

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN docker-php-ext-install \
    bcmath \
    curl \
    dom \
    intl \
    ldap \
    pdo \
    pdo_mysql \
    sockets \
    soap

RUN pecl install redis-5.3.6 \
    && docker-php-ext-enable redis

RUN apt-get clean

EXPOSE 9000
USER www-data
WORKDIR /var/www/html
