COMPOSE              = docker-compose
COMPOSE_RUN          = $(COMPOSE) run --rm
COMPOSE_RUN_APP = $(COMPOSE_RUN) app
CONSOLE = $(COMPOSE_RUN_APP) php bin/console

ifeq ($(strip $(ELEFAN_APP)),)
	ELEFAN_APP_DIR = ../gestion-compte
else
	ELEFAN_APP_DIR = $(ELEFAN_APP)
endif

# -- Rules
default: help

.PHONY: bootstrap
bootstrap: ## installe et configure gestion-compte application
	$(COMPOSE) build
	$(COMPOSE) up -d
	cp symfony/parameters.yml $(ELEFAN_APP_DIR)/app/config/parameters.yml
	$(COMPOSE_RUN) dockerize -wait tcp://mysql:3306 -timeout 60s
	$(COMPOSE_RUN_APP) composer install
	$(CONSOLE) doctrine:migration:migrate

.PHONY: run
run: ## Démarre tous les containers docker
	$(COMPOSE) up -d

.PHONY: stop
stop: ## Arrête tous les containers docker
	$(COMPOSE) stop

.PHONY: migrate
migrate: ## Joue les migrations de la base de données
	$(COMPOSE_RUN) dockerize -wait tcp://mysql:3306 -timeout 60s
	$(CONSOLE) doctrine:migration:migrate

.PHONY: superuser
superuser: ## Crée un utilisateur admin
	$(CONSOLE) fos:user:create --super-admin

clear-cache: ## Supprime le cache de l'application symfony
	$(CONSOLE) c:c

.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

