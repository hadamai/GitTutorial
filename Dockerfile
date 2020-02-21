FROM php:5.6-apache

RUN apt-get update \
  && apt-get install -y \
    git \
    zip

RUN apt-get update \
  && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
  && docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) \
    gd

RUN apt-get update \
  && apt-get install -y \
    mysql-client \
    mariadb-client \
    curl \
    libssl-dev \
    openssl


RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

RUN docker-php-ext-install mbstring
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install opcache
RUN docker-php-ext-install xml
RUN docker-php-ext-install zip
RUN docker-php-ext-install xmlwriter 
RUN docker-php-ext-install dom
RUN docker-php-ext-install curl
RUN docker-php-ext-install gettext
RUN docker-php-ext-install openssl     
RUN docker-php-ext-install mcrypt
RUN docker-php-ext-install phar


RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini


RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN a2enmod rewrite
RUN a2enmod headers
RUN apache2ctl -k graceful

