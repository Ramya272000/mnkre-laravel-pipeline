# Builder Stage
FROM php:8.1-fpm AS builder
WORKDIR /var/www

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libonig-dev \
    libzip-dev \
    curl \
    npm

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl

# Install Composer
COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer

# Copy app files
COPY . .
RUN composer install --no-dev --optimize-autoloader
RUN npm install && npm run production

# Final Stage
FROM nginx:latest
WORKDIR /var/www

COPY --from=builder /var/www /var/www
COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
