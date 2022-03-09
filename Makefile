DOCKER_COMPOSE := docker-compose

.PHONY: build
build:
	$(DOCKER_COMPOSE) up -d --build
