FROM php:7.2-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        git \
        zip \
        wget \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-install -j$(nproc) pdo pdo_mysql

RUN wget https://getcomposer.org/download/1.10.19/composer.phar && \
    chmod +x composer.phar && \
    mv composer.phar /usr/local/bin/composer

ARG USER_UID=1000
RUN adduser -uid ${USER_UID} --gecos coop --quiet --disabled-password coop

USER coop

VOLUME /app
WORKDIR /app
