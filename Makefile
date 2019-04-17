COMPOSE              = docker-compose
COMPOSE_RUN          = $(COMPOSE) run --rm
COMPOSE_RUN_APP = $(COMPOSE_RUN) app

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
	cp symfony/app_dev.php $(ELEFAN_APP_DIR)/web
	$(COMPOSE_RUN_APP) dockerize -wait tcp://mysql:3306 -timeout 60s
	$(COMPOSE_RUN_APP) composer install
	$(COMPOSE_RUN_APP) php bin/console doctrine:migration:migrate

.PHONY: run
run: ## Démarre tous les containers docker
	$(COMPOSE) up -d

.PHONY: stop
stop: ## Arrête tous les containers docker
	$(COMPOSE) stop

.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

