# mod amazon 'amazon.justfile'
# mod graal 'graal.justfile'

set dotenv-load

init:
    @mkdir backups crash-reports heapdumps logs world 2>/dev/null || printf ''
    @chown -R $USER:minecraft backups crash-reports heapdumps logs world
    @chmod -R g+rwx backups
    @chmod -R g+rwx crash-reports
    @chmod -R g+rwx heapdumps 
    @chmod -R g+rwx logs 
    @chmod -R g+rwx world

build: 
    docker compose build

down:
    docker compose down

copy source dest filename:
    docker compose cp gtnh:{{source}}/{{filename}} {{dest}}/{{filename}}

restart: build down
    docker compose up -d

attach:
    docker compose attach gtnh

base:
    docker run --rm -it $BASE_IMAGE bash
