.PHONY: build install require start stop version

compose := docker-compose
container := docker-php-1

build:
	$(compose) build

check-container:
	@docker ps --filter "name=$(container)" --filter "status=running" | grep $(container) > /dev/null || (echo "Le conteneur $(container) n'est pas lancé. Lancer la commande 'make start'."; exit 1)

install: check-container
	docker exec -it $(container) composer install

list-docker:
	docker ps

require: check-container
	docker exec -it $(container) composer $(dev) require $(lib)

start:
	$(compose) up

stop:
	$(compose) stop

version:
	php --version
	composer --version