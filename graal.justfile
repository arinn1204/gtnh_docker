build:
    docker compose -f graal.dockerfile build

down:
    docker compose down

restart: build down
    docker compose up -d

attach:
    docker compose attach gtnh

