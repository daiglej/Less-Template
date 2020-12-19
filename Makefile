
.PHONY: help up down build .up shell new-shell phpcs phpcbf phpunit vendor

##
# help             - Displays this help message (See also "make --help" for help for Make itself.)
##
help:
	@printf "\nUsage: \"make [OPTIONS] [TARGET]\"\n\n"; \
	printf "TARGETS:\n\n"; \
	grep -e "^# " $(MAKEFILE_LIST) 2>/dev/null | cut -c2-; \
	printf "\n";

##
# up               - Start the application, (Start all docker containers)
##
up: .valid-env build php/vendor
	docker-compose up --detach --force-recreate --remove-orphans && \
	docker-compose ps --all;

##
# down             - Stop the application, (Shut down all docker containers)
##
down:
	docker-compose down --volume --remove-orphans;

##
# build            - Build docker images.
##
build: .valid-env
	docker-compose build --pull --no-rm --parallel && \
	docker-compose images;

##
# composer-install - runs composer install (install / update composer package)
##
composer-install php/vendor: .valid-env php/composer.json php/composer.lock .volumes/composer
	@mkdir -p .volumes/composer; \
	docker run \
		--rm \
		--user $(id -u):$$(id -g) \
		--volume $$COMPOSER_HOME:/tmp \
		--volume $(PWD)/php:/app \
		composer:2.0 install \
			--optimize-autoloader \
			--apcu-autoloader \
			--ignore-platform-reqs \
		&& \
	touch php/vendor;

##
# shell            - Opens a shell in the existing php container. Where you can run composer, craftsman, phpcs, phpunit, ect.
##
shell: .up
	docker-compose exec php sh;

##
# new-shell        - Similar to shell, but starts a NEW php container. Useful when "make up" fails to start the php container.
##
new-shell:
	docker-compose run --rm --no-deps --entrypoint=docker-php-entrypoint php sh;

##
# psysh            - Open a PsySH REPL shell. See https://psysh.org
# phpunit          - Runs "phpunit" inside the php image. (runs the unit test suite).
# phpcs            - Runs "phpcs" inside the php image. (reports code styling violations, defined by phpcs.xml)
# phpcbf           - Runs "phpcbf" inside the php image.
#                        ("beautifies" the php source code, according to automatically fixable rules of phpcs.xml)
##
phpcbf phpcs phpunit psysh: .up
	@docker-compose run --rm --no-deps php $@

##
# .env             - Create/Update the .env file.
##
.env: .env.template
	@mkdir -p .volumes; \
	if [ ! -f .env ]; then cp .env.template .env; fi; \
	if [ ! -f .volumes/.env.template-previous ]; then  cp .env.template .volumes/.env.template-previous; fi; \
	cp -f .env .volumes/.env.back; \
	if /usr/bin/diff3 -m .env .volumes/.env.template-previous .env.template > .env; then \
		cp -f .env.template .volumes/.env.template-previous;\
	else \
	  	cp -f .env.template .volumes/.env.template-previous;\
	  	printf "\n\nPLEASE RESOLVE THE MERGE CONFLICT(S) IN THE .env FILE AND TRY AGAIN\n\n"; \
	  	exit 1; \
	fi;

## Ensure there is no merge conflict in the .enn file
.valid-env: .env
	@if grep -e "^>>>>>>> .env" -e "^<<<<<<< .env" .env > /dev/null ; then \
  		printf "\n\nPLEASE RESOLVE THE MERGE CONFLICT(S) IN THE .env FILE AND TRY AGAIN\n\n"; \
		exit 1; \
  	fi;

## Similar to up, but does nothing if containers are already running
.up: .valid-env build php/vendor
	@set -e; \
	if ! docker-compose exec php echo '' 2> /dev/null; then \
		docker-compose build --pull --no-rm --parallel && \
		docker-compose images;
	fi;
