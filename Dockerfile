FROM composer:2.0 as source
COPY composer.* ./
RUN composer install --no-dev --ignore-platform-reqs --prefer-dist && composer clear-cache
# Install packages without sources to optimize docker caching
RUN composer install --ignore-platform-reqs --no-dev --prefer-dist && composer clear-cache
COPY config ./config
COPY src ./src
RUN composer dump-autoload --ignore-platform-reqs --no-dev --optimize --classmap-authoritative

FROM php:8.0-fpm-alpine3.12

COPY --from=composer:2.0 /usr/bin/composer /usr/bin
COPY composer.* ./
ARG dev=0
RUN \
    composer check-platform-reqs && \
    if [ "$dev" != "1" ]; then \
        rm /usr/bin/composer; \
    fi;


COPY --from=source app/ .
