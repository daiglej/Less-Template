FROM composer:2.0 as source
WORKDIR /app
COPY ./composer.* /app/
# Install packages without sources to optimize docker caching
ARG dev=0
RUN set -e; \
    no_dev=; \
    if [ "$dev" != "1" ]; then no_dev=--no-dev; fi; \
    composer install --ignore-platform-reqs --no-cache ${no_dev} --prefer-dist --no-interaction --no-suggest --no-progress --quiet; \
    composer clear-cache --quiet --no-interaction;
COPY ./lib /app/lib
COPY ./src /app/src
RUN set -e; \
    composer install --ignore-platform-reqs --no-cache ${no_dev} --prefer-dist --no-interaction --no-suggest --no-progress --quiet --optimize-autoloader --classmap-authoritative; \
    composer clear-cache --quiet --no-interaction;
RUN rm composer.json composer.lock



FROM php:8.0-fpm-alpine3.12
RUN set -e; \
    mkdir /app; \
    mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini; \
    export PATH=$PATH:/app/vendor/bin; \
    docker-php-ext-enable opcache; # Is this necessary?

WORKDIR /app

# Install development extensions in a layer of there own, to optimize cache hist with switching environments.
ARG dev=0
RUN set -e; \
    if [ "$dev" == "1" ]; then \
        mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini; \
        apk add --no-cache --virtual .dev-deps \
            $PHPIZE_DEPS; \
        pecl install xdebug oap-beta; \
        docker-php-ext-enable xdebug; \
        apk del .dev-deps; \
        ln -s /app/vendor/bin/phpcs /usr/bin/phpcs; \
    else \
        rm /usr/local/etc/php/php.ini-development; \
    fi;

# Ensure platform meats our packages requirements
COPY --from=source /usr/bin/composer /usr/bin/composer
COPY ./composer.* ./craftman /app/
RUN set -e; \
    ln -s /app/craftman /usr/bin/craftman; \
    if [ "$dev" == "1" ]; then \
      composer check-platform-reqs --lock --no-interaction; \
    else \
      composer check-platform-reqs --lock --no-interaction --no-dev; \
      rm /usr/bin/composer; \
    fi; \
    rm composer.*;

# Add source files
COPY --from=source /app/ /app

