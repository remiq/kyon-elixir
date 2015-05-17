# kyon-elixir (placebooru)

Catabooru / remiq.net / kyon.pl reborn.


Goal of this project is NOT to innovate - for this reason it will not use Elixir-specific features
like OTP (directly, Phoenix uses OTP). Just simple use of Phoenix framework to recreate 80% of functionality.

Sub-goals:
* we should use the same database and file formats to allow reimport of old data
* open-source it



## Usage

Start docker containers

    $ docker-compose up -d

Import data to database

    vm$ docker-compose run --rm db bash
    db$ psql --host=db --username=web --password web
    Password for user web: devel

    web=#


## TODO

https://github.com/route/mogrify ImageMagick for Elixir


### Delayed

Plugin / api (it probably does not work anymore)

### TO not to DO

No swf.*
Basic www (all items on same list)
No advanced tag searching



