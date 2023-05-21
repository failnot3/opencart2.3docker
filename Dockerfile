FROM debian:buster-slim

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    unzip \
    apache2 \
    libapache2-mod-php \
    php \
    php-gd \
    php-zip \
    php-imap \
    php-bcmath \
    php-opcache \
    php-exif \
    php-mysqli \
    php-curl \
    php-pear \
    php-dev \
    libmcrypt-dev \
    wget \
    zlib1g-dev \
    libpng-dev \
    libzip-dev \
    libc-client-dev \
    libkrb5-dev \
    ghostscript \
    build-essential

# Set the maintainer, version, and description labels
LABEL maintainer="d.g.ivanov@protonmail.com"
LABEL version="2.3.0.2"
LABEL description="OpenCart"

# Set the OpenCart version as an argument
ARG OC_VERSION='2.3.0.2'

# Set the installation directory
ENV INSTALL_DIR /var/www/html

# Define APACHE_RUN_DIR, APACHE_PID_FILE, APACHE_RUN_USER, and APACHE_RUN_GROUP
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_PID_FILE $APACHE_RUN_DIR/apache2.pid
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

# Download and extract OpenCart
RUN curl -o opencart.zip -fL "https://github.com/opencart/opencart/releases/download/2.3.0.2/2.3.0.2-compiled.zip" --insecure; \
    unzip opencart.zip -d opencart; \
    mkdir -p $INSTALL_DIR; \
    cp -r opencart/upload/. $INSTALL_DIR/; \
    rm -rf opencart.zip opencart; \
    mv $INSTALL_DIR/config-dist.php $INSTALL_DIR/config.php ; \
    mv $INSTALL_DIR/admin/config-dist.php $INSTALL_DIR/admin/config.php ; \
    chmod -R 777 $INSTALL_DIR

# Update Apache configuration
RUN echo "Options FollowSymLinks" > /etc/apache2/conf-available/opencart.conf && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    ln -s /etc/apache2/conf-available/opencart.conf /etc/apache2/conf-enabled/opencart.conf && \
    sed -i "s|${APACHE_RUN_DIR}|/var/run|g" /etc/apache2/apache2.conf && \
    sed -i "s|/var/run/apache2|$APACHE_RUN_DIR|g" /etc/apache2/apache2.conf && \
    mkdir -p $APACHE_RUN_DIR && \
    mkdir -p $APACHE_LOG_DIR

# Copy the PHP configuration file
COPY php.ini /etc/php/7.3/apache2/php.ini

# Download and install mcrypt extension
RUN wget --no-check-certificate -O /tmp/mcrypt-1.0.4.tgz "https://pecl.php.net/get/mcrypt-1.0.4.tgz" && \
    tar -xf /tmp/mcrypt-1.0.4.tgz -C /tmp && \
    rm /tmp/mcrypt-1.0.4.tgz && \
    cd /tmp/mcrypt-1.0.4 && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    echo "extension=mcrypt.so" > /etc/php/7.3/apache2/conf.d/20-mcrypt.ini && \
    ln -s /etc/php/7.3/apache2/conf.d/20-mcrypt.ini /etc/php/7.3/cli/conf.d/20-mcrypt.ini && \
    rm -rf /tmp/mcrypt-1.0.4

# Enable necessary Apache modules
RUN a2enmod rewrite

# Set the volume for the OpenCart installation directory
VOLUME ["$INSTALL_DIR"]

# Set the working directory to the OpenCart installation directory
WORKDIR $INSTALL_DIR

# Expose port 80 for Apache
EXPOSE 80

# Start Apache service
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
