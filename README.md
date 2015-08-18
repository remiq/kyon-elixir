# kyon-elixir (placebooru)

Catabooru / remiq.net / kyon.pl reborn.


Goal of this project is NOT to innovate - for this reason it will not use Elixir-specific features
like OTP (directly, Phoenix uses OTP). Just simple use of Phoenix framework to recreate 80% of functionality.

Sub-goals:
* we should use the same database and file formats to allow reimport of old data
* open-source it





## Usage

### Setup

Copy `.env_example` file as `.env`

    $ cp .env_example .env

Change passwords, salts, etc. Save them somewhere.

    $ vim .env

Copy `web/config/dev.exs` to `web/config/prod.exs` and change default settings.

Start docker containers

    $ docker-compose up -d

Import data to database

    vm$ docker-compose run --rm db psql --host=db --username=web web
    web=# \i ./0.initial.sql
    web=# \i ./10000.example.sql

### Normal usage

Change `MIX_PROD` to `prod` in `.env`

    $ vim .env
    MIX_PROD=prod

## Delayed

Plugin / api (it probably does not work anymore)

## TO not to DO

Basic www (all items on same list)
No advanced tag searching



