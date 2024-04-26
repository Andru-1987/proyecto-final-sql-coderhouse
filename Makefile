#!make
include .env

COMPOSE_PROJECT_NAME=mysql

SERVICE_NAME=mysql
HOST=127.0.0.1
PORT=3306
PASSWORD=${ROOT_PASSWORD}
DATABASE=${DATABASE_NAME}

DOCKER_COMPOSE_FILE=./docker-compose.yml

DATABASE_CREATION=./structure/database_structure.sql
DATABASE_POPULATION=./structure/population.sql

FILES := $(wildcard ./objects/*.sql)


.PHONY: all up objects clean

all: up objects

up:

	@echo "Create the instance of docker"
	docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build

	@echo "Waiting for MySQL to be ready..."
	bash wait_docker.sh


	@echo "Create the import and run de script"
	docker exec -it mysql mysql -u root -p$(PASSWORD) -e "source $(DATABASE_CREATION);"
	docker exec -it mysql mysql -u root -p$(PASSWORD) --local-infile=1 -e "source $(DATABASE_POPULATION)"

objects:
	@echo "Create objects in database"
	@for file in $(FILES); do \
	    echo "Process $$file and add to the database: $(DATABASE_NAME)"; \
	docker exec -it mysql  mysql -u root -p$(PASSWORD) -e "source $$file"; \
	done

access-db:
	@echo "Access to db-client"
	docker exec -it $(SERVICE_NAME) mysql -u root -p$(PASSWORD) 

clean-db:
	@echo "Remove the Database"
	docker exec -it mysql mysql -u root -p$(PASSWORD) --host $(HOST) --port $(PORT) -e "DROP DATABASE IF EXISTS $(DATABASE_NAME);"
	@echo "Bye"
	docker compose -f $(DOCKER_COMPOSE_FILE) down
