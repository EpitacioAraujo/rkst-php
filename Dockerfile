# Base image
FROM php:8.2-fpm

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    nginx \
    git \
    unzip \
    zip \
    supervisor && \
    rm -rf /var/lib/apt/lists/*

# Install and enable Xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy configuration files
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./config/10-php.ini /usr/local/etc/php/conf.d/
COPY ./config/90-xdebug.ini /usr/local/etc/php/conf.d/
COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy application code
COPY ./src /app

# Set working directory
WORKDIR /app

# Expose ports for Nginx
EXPOSE 80

# Start Supervisor to manage Nginx and PHP-FPM
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
