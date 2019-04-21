# gestion-compte docker

Ce repo contient la configuration permettant de faire fonctionner [gestion-compte](https://github.com/elefan-grenoble/gestion-compte) avec docker.

[gestion-compte](https://github.com/elefan-grenoble/gestion-compte) est l'application développée par l'épicerie coopérative l'éléfan de Grenoble.
Elle permet la gestion des adhérents.

## Installation

Il vous faut dans un premier temps faire un clone de ce repo au même niveau que le répertoire `gestion-compte`. Vous aurez donc les 2 répertoires
`gestion-compte` et `gestion-compte-docker` au même niveau:

```
.
├── gestion-compte
└── gestion-compte-docker
```

Si ce n'est pas le cas, vous devrez utiliser la variable d'envrionnement `ELEFAN_APP` qui contiendra le path absolu de votre répertoire `gestion-compte`.

Pour faire le clone :

```bash
$ git clone git@github.com:coopdesdomes/gestion-compte-docker.git
```

une fois le répo installé, se mettre dedans et lancer la commande `make bootstrap`

```bash
$ cd gestion-compte-docker
$ make bootstrap
```

L'application `gestion-compte` va être installé et sera disponible à l'url `http://localhost:8080`

## Utilisation de la console symfony

L'utilisation de la console symfony doit se faire depuis le container docker qui fait tourner `php-fpm`. Elle est donc utilisable depuis la commande suivante:

```bash
$ docker-compose exec app php bin/console
```

Si je souhaite supprimer le cache, je vais exécuer la commande suivante :

```bash
$ docker-compose exec app php bin/console cache:clear
```

## Makefile

Un `Makefile` est mis à disposition avec quelques commandes qui vous faciliterons la vie.
Pour connaître les commandes disponibles:

```
$ make help
```

## Mail catcher

Un mail catcher est mis en place et disponible à l'adresse http://localhost:8025
Tous les mails qui partent de l'application sont enregistrés dans ce mail catcher et consultable soit pour debug soit pour éviter un envoie non voulu à de vrais utilisateurs.
