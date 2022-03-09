DOCKER_COMPOSE := docker-compose

.PHONY: build
build:
	$(DOCKER_COMPOSE) up --build

.PHONY: run
run:
	$(DOCKER_COMPOSE) up

.PHONY: create_pytest_cov
create_pytest_cov:
	$(DOCKER_COMPOSE) exec web pytest --cov --cov-report=html

.PHONY: pytest
pytest:
	$(DOCKER_COMPOSE) exec web pytest -x -v --cov

.PHONY: makemigrations
makemigrations:
	$(DOCKER_COMPOSE) exec web python manage.py makemigrations

.PHONY: migrate
migrate:
	$(DOCKER_COMPOSE) exec web python manage.py migrate

.PHONY: superuser
superuser:
	$(DOCKER_COMPOSE) exec web python manage.py createsuperuser
