build:
    docker compose -f docker-compose-amazon.yaml build

down:
    docker compose -f docker-compose-amazon.yaml down

copy source dest filename:
    docker compose -f docker-compose-amazon.yaml cp gtnh:{{source}}/{{filename}} {{dest}}/{{filename}}

restart: build down
    docker compose -f docker-compose-amazon.yaml up -d

attach:
    docker compose -f docker-compose-amazon.yaml attach gtnh

base:
    docker run --rm -it amazoncorretto:21-al2-jdk bash