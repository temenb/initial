FROM php:8.2-fpm

## Main
#RUN apt-get update && \
#    apt-get install --no-install-recommends -y \
#        imagemagick \
#        nano \
#        mc \
#        memcached \
#        sudo \
#        git \
#        zip \
#        unzip \
#        libicu-dev \
#        zlib1g-dev \
#        libzip-dev \
#        libxml2-dev && \
#        docker-php-ext-install zip mbstring intl pcntl exif iconv && \
#    rm -r /var/lib/apt/lists/*
#
## Mcrypt
#RUN apt-get update && \
#    apt-get install --no-install-recommends -y \
#        libmcrypt-dev && \
#        pecl install mcrypt-1.0.2 && \
#    rm -r /var/lib/apt/lists/*
#
## GD
#RUN apt-get update && \
#    apt-get install --no-install-recommends -y \
#        libpng-dev \
#        libjpeg-dev \
#        libfreetype6-dev && \
#        docker-php-ext-configure gd --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-freetype-dir=/usr/include/ && \
#        docker-php-ext-install gd && \
#    rm -r /var/lib/apt/lists/*

# Postgres
RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo pdo_pgsql

#composer 
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'edb40769019ccf227279e3bdd1f5b2e9950eb000c3233ee85148944e555d97be3ea4f40c3c2fe73b22f875385f6a5155') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN apt install git -y


# Supervisor
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        supervisor && \
    rm -r /var/lib/apt/lists/*
COPY ./config/laravel-worker.conf /etc/supervisor/conf.d

#Xdebug
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions xdebug
# ENV PHP_IDE_CONFIG 'serverName=old.???'
RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
# RUN echo "xdebug.start_with_request = yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
# RUN echo "xdebug.client_host=docker.for.mac.localhost" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
# RUN echo "xdebug.client_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
# RUN echo "xdebug.log=/var/log/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
# RUN echo "xdebug.idekey = PHPSTORM" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.mode=develop,debug,coverage" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

WORKDIR /project
