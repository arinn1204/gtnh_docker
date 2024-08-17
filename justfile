# mod amazon 'amazon.justfile'
# mod graal 'graal.justfile'

set dotenv-load

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