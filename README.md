# Description

World of Stars is a browser-based game.

The player shall manage its planet's resources to build new buildings, units and spaceships in order to defend and attack the other players with the spaceships or through wormholes connecting the planets together.

This project use a set of innovative technologies such as Rails 6, Docker, Postgresql and Redis for the queuing system. Ajax calls are also made during the execution.
A dynamic HTML canvas is used for rendering the planet of the user.

# Initialisation

## Clone the repo

```
$ git clone https://github.com/acouprie/worldofstars.git
```

## Run with Docker (recommended)

```
$ docker-compose build
$ docker-compose up
$ docker-compose run web rails db:create
$ docker-compose run web rails db:migrate
$ docker-compose run web rails db:seed
```

## Tests

```
$ docker-compose run web rails db:test:prepare
$ docker-compose run web rails test
```

## Run without docker (obsolete, possibly outdated)

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
