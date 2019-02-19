FROM php:7.2-cli-stretch
RUN docker-php-source extract \
    && apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libbz2-dev \
        libzip-dev \
        curl \
        wget \
        gnupg \
        apt-transport-https \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) bz2 \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-source delete \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" >> /etc/apt/sources.list.d/yarn.list \
    && curl -sL https://deb.nodesource.com/setup_9.x | bash - \
    && apt-get update \
    && apt-get install -y yarn nodejs
