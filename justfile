build:
    docker compose build

down:
    docker compose down

restart: build down
    docker compose up -d


attach:
    docker compose attach gtnh
