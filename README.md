# Description

World of Stars est un jeu de gestion par navigateur.

Le joueur aura pour but de gérer les ressources de sa planète pour construire des batiments, des unités ainsi que des vaisseaux spatiaux afin de se défendre et d'attaquer les autres joueurs grâce aux vaisseaux ou par un réseau de trous de ver entre les planètes des joueurs.

# Initialisation

## Clone the repo
```
$ git clone https://github.com/acouprie/worldofstars.git
```

## Run with Docker (recommended)

```
$ docker-compose build
$ docker-compose up
$ docker-compose run web rake db:create
$ docker-compose run web rake db:migrate
$ docker-compose run web rake db:seed
```

## Run without docker
### System dependencies
```
$ gem install bundler
$ bundle install
```

### Database creation
```
$ rails db:migrate
```

### Database initialization
```
$ rails db:seed
```

### Launch the server
Run a [redis server](https://redis.io/)
```
$ rails s
$ bundle exec rake environment resque:scheduler
$ QUEUE=* rake environment resque:work
```

Connect to localhost:3000/

### How to run the test suite
```
$ rails t
```

## Credentials
User : test@test.com

Pwd : Test1234
