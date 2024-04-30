DOCKER_COMPOSE := docker-compose
FILE_NAME := products


.PHONY: run_services
run_services:
	$(DOCKER_COMPOSE) up -d --build

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

.PHONY: loaddata
loaddata:
	$(DOCKER_COMPOSE) exec web python manage.py loaddata $(FILE_NAME)


########## Starting the background

.PHONY:start
start: run_services makemigrations migrate superuser loaddata pytest
	$(DOCKER_COMPOSE) up

########## Clean the background

.PHONY: clean_local
clean_local:
	$(DOCKER_COMPOSE) down -v --remove-orphans
	$(DOCKER) system prune -af

.PHONY: clean
clean:
	@echo "Cleaning up containers, images, volumes..."
	$(DOCKER) rm -f $(shell $(DOCKER) ps -aq)    	# Remove all containers
	$(DOCKER) rmi -f $(shell $(DOCKER) images -aq)	# Remove all images
	$(DOCKER) volume prune -f						# Remove all volumes
	$(DOCKER) system prune -f						# Cleaner the cache in system
