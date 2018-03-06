FROM php:7.2-fpm

RUN apt-get update && apt-get upgrade -y \
    g++ \
    libc-client-dev \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libkrb5-dev \
    libmagickwand-dev \
    libmcrypt-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libpng12-dev \
    libpq-dev \
    libssl-dev \
    libssl-doc \
    libsasl2-dev \
    zlib1g-dev \
    && docker-php-ext-install \
    bz2 \
    iconv \
    mbstring \
    mcrypt \
    mysqli \
    pgsql \
    pdo_mysql \
    pdo_pgsql \
    soap \
    zip \
    && docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && yes '' | pecl install imagick && docker-php-ext-enable imagick \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && docker-php-ext-configure intl  \
    && docker-php-ext-install intl \
    && docker-php-ext-configure opcache  \
    && docker-php-ext-install opcache \
    && pecl install mongodb && docker-php-ext-enable mongodb \
    && pecl install redis && docker-php-ext-enable redis \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -Rf /tmp/*