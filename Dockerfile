FROM composer:2.0 as source
COPY composer.* ./
RUN composer install --no-dev --ignore-platform-reqs --prefer-dist && composer clear-cache
# Install dev package in a layer of their own to optimize docker caching (To avoid re-downloading base package when environment changes)
ARG with_dev_package=0
RUN composer install --ignore-platform-reqs --prefer-dist && composer clear-cache
# Run autoloading dumping in a layer of its own to optimize docker caching (To avoid re-downloading package when code change).
COPY config ./config
RUN ls -hal
COPY src ./src
RUN composer dump-autoload --ignore-platform-reqs --optimize --classmap-authoritative

FROM php:8.0.0RC5-fpm-alpine
COPY --from=source /usr/bin/composer /usr/bin
COPY --from=source app/ .
RUN composer check-platform-reqs

