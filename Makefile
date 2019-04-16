COMPOSE              = docker-compose
COMPOSE_RUN          = $(COMPOSE) run --rm
COMPOSE_RUN_APP = $(COMPOSE_RUN) app

ifeq ($(strip $(ELEFAN_APP)),)
	ELEFAN_APP_DIR = ../gestion-compte
else
	ELEFAN_APP_DIR = $(ELEFAN_APP)
endif

bootstrap:
	$(COMPOSE) build
	$(COMPOSE) up -d
	cp symfony/parameters.yml $(ELEFAN_APP_DIR)/app/config/parameters.yml
	cp symfony/app_dev.php $(ELEFAN_APP_DIR)/web
	$(COMPOSE_RUN_APP) composer install
	$(COMPOSE_RUN_APP) php bin/console doctrine:migration:migrate



