
.PHONY: help up down build .up shell new-shell phpcs phpcbf phpunit vendor

##
# help             - Displays this help message (See also "make --help" for help for Make itself.)
##
help:
	@printf "\nUsage: \"make [OPTIONS] [TARGET]\"\n\n"; \
	printf "TARGETS:\n\n"; \
	grep -e "^# " $(MAKEFILE_LIST) | cut -c2-; \
	printf "\n";

##
# up               - Start the application, (Start all docker containers)
##
up: .env php/vendor build
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
build: .env
	docker-compose build --pull --no-rm --parallel && \
	docker-compose images;

##
# composer-install - runs composer install (install / update composer package)
##
composer-install php/vendor: php/composer.json php/composer.lock .env
	@set -a && \
 	. ./.env && \
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
# .env             - Create/Replace the .env file. By copying the .env.template template file.
##
.env: .env.template
	@set -e; \
	mkdir -p .volumes/composer; \
	if [ ! -f .env ]; then \
		cp .env.template .env; \
	elif diff .env.template .env; then \
		touch .env; \
		exit 0; \
  	else \
		echo "Some new changes where made to .env.template, since the last time you edited the .env file (see diff above)."; \
		read -e -p "Do you want to replace tour .env, by .env.template?" choice; \
		if [[ "$$choice" == [Yy]* ]]; then \
			cp .env .env.back; \
			cp -f .env.template .env; \
			echo "Your old file was backup to .env.back"; \
			exit 0; \
		else \
			echo "Please updadte the .env file and try again."; \
			echo "Alternately you can \"touch .env\" to make this error go away."; \
			exit 1; \
		fi; \
	fi;

## Similar to up, but does nothing if containers are already running
.up: .env php/vendor build
	@set -e; \
	if ! docker-compose exec php echo '' 2> /dev/null; then \
		docker-compose build --pull --no-rm --parallel && \
		docker-compose images;
	fi;
