DOCKER_COMPOSE := docker-compose
FILE_COMPOSE := docker-compose.yaml

.PHONY: db_ecommerce
db_ecommerce:
	$(DOCKER_COMPOSE) -f $(FILE_COMPOSE) up -d django_postgres_db
