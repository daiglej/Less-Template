.PHONY: up down build .up shell

up: .env vendor build
	docker-compose up --detach --force-recreate --remove-orphans && \
	docker-compose ps --all;

down:
	docker-compose down --volume --remove-orphans && \
	docker-compose ps --all;

build: .env
	docker-compose build --pull --no-rm --parallel; \
	docker-compose images;

vendor: composer.json composer.lock
	docker run -v $(PWD):/app composer:2.0 install && \
	touch vendor

shell: .up
	docker-compose exec php sh;

# Similar to shell, but starts a new container instead of using the running one. Useful to de bug the entrypoint.
new-shell:
	docker-compose run --rm --no-deps --entrypoint=docker-php-entrypoint php sh;

.env: .env.template
	@if [ ! -f .env ]; then \
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

# Similar to up, but does nothing if containers are already running
.up:
	@if ! docker-compose exec php echo '' 2> /dev/null; then \
		$(MAKE) up; \
	fi;

phpcs phpcbf phpunit: .up
	docker-compose exec ./vendonr/bin/$@
