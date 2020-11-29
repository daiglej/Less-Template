up:


vendor: composer.json composer.lock
	docker run -v $(PWD):/app composer:2.0 install
	touch vendor

.env:
	cp .env.template .env