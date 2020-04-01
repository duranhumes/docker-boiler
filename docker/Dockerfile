FROM php:7.3.14-fpm-stretch

ARG BASE_DIR=/srv/app
ENV PHP_OPCACHE_VALIDATE_TIMESTAMPS="0" \
    PHP_OPCACHE_MAX_ACCELERATED_FILES="10000" \
    PHP_OPCACHE_MAX_WASTED_PERCENTAGE="10" \
    PHP_OPCACHE_MEMORY_CONSUMPTION="256" \
    USER=Duran

RUN groupadd --gid 1000 ${USER} \
    && useradd --uid 1000 --gid ${USER} --shell /bin/bash --create-home ${USER}

RUN touch /home/${USER}/.bashrc

RUN apt-get update -yqq --fix-missing \
    && apt-get install -yqq --no-install-recommends \
    zip \
    g++ \
    git \
    gcc \
    vim \
    wget \
    make \
    gnupg \
    nginx \
    unzip \
    procps \
    libaio1 \
    supervisor \
    libssl-dev \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libzip-dev \
    nginx-extras \
    libmcrypt-dev \
    libsodium-dev \
    build-essential \
    libfreetype6-dev

RUN docker-php-ext-configure \
    zip --with-libzip \
    && docker-php-ext-configure \
    gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
    gd \
    zip \
    iconv \
    sodium \
    pdo_mysql \
    && pecl install \
    mcrypt-1.0.3 \
    && docker-php-ext-enable \
    mcrypt \
    opcache \
    && mkdir -p /run/php

WORKDIR ${BASE_DIR}

# Web App
COPY . ${BASE_DIR}

COPY --from=composer:1.9 /usr/bin/composer /usr/bin/composer
RUN chmod +x /usr/bin/composer

# PHP
COPY docker/php/php.ini /usr/local/etc/php/php.ini
COPY docker/php/conf.d/*.ini /usr/local/etc/php/conf.d/
COPY docker/php/php-fpm.d/docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf

# Supervisor
COPY docker/supervisor/supervisord.conf /etc/supervisor/supervisord.conf

# Nginx
COPY docker/nginx/keys/ /etc/nginx/keys/
COPY docker/nginx/partials/ /etc/nginx/partials/
COPY docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY docker/nginx/webapp.conf /etc/nginx/conf.d/webapp.conf

RUN rm /etc/nginx/sites-enabled/default
RUN nginx -t && service nginx restart

# Setup nginx logs for docker output
RUN ln -sf /dev/stdout /tmp/access.log \
    && ln -sf /dev/stderr /tmp/error.log

RUN chown -R ${USER}:www-data .
