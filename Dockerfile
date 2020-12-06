FROM composer:2.0 as source
COPY composer.* ./
# Install packages without sources to optimize docker caching
ARG dev=0
RUN set -e; \
    no_dev=; \
    if [ "$dev" != "1" ]; then no_dev=--no-dev; fi; \
    composer install --ignore-platform-reqs --no-cache ${no_dev} --prefer-dist --no-interaction --no-suggest --no-progress --quiet; \
    composer clear-cache --quiet --no-interaction;
COPY config ./config
COPY src ./src
RUN set -e; \
    composer install --ignore-platform-reqs --no-cache ${no_dev} --prefer-dist --no-interaction --no-suggest --no-progress --quiet --optimize-autoloader --classmap-authoritative; \
    composer clear-cache --quiet --no-interaction;
RUN rm composer.json composer.lock



FROM php:8.0-fpm-alpine3.12
RUN mkdir /app
WORKDIR /app

RUN set -e; \
    docker-php-ext-enable opcache; # Is this necessary?

# Install dev packages in a layer of there own, to optimix=za cache hist with switching environments.
ARG dev=0
RUN set -e; \
    if [ "$dev" == "1" ]; then \
        apk add --no-cache --virtual .dev-deps \
            $PHPIZE_DEPS; \
        pecl install xdebug oap-beta; \
        docker-php-ext-enable xdebug; \
        apk del .dev-deps;\
    fi;

COPY --from=composer:2.0 /usr/bin/composer /usr/bin
COPY composer.* ./
RUN set -e; \
    if [ "$dev" == "1" ]; then \
      composer check-platform-reqs --no-interaction; \
    else \
      composer check-platform-reqs --no-interaction --no-dev; \
      rm /usr/bin/composer; \
    fi; \
    rm composer.*;


COPY --from=source app/ /app

