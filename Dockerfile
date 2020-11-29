FROM composer:2.0 as source
COPY composer.* ./
RUN composer install --no-dev --ignore-platform-reqs --prefer-dist && composer clear-cache
# Install packages without sources to optimize docker caching
RUN composer install --ignore-platform-reqs --no-dev --prefer-dist && composer clear-cache
COPY config ./config
COPY src ./src
RUN composer dump-autoload --ignore-platform-reqs --no-dev --optimize --classmap-authoritative

FROM php:8.0.0RC5-fpm-alpine
COPY --from=source /usr/bin/composer /usr/bin
COPY --from=source app/ .
RUN composer check-platform-reqs

