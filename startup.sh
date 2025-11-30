#!/bin/bash

SERVICES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Using services root: $SERVICES_DIR"

for SERVICE_PATH in "$SERVICES_DIR"/*/; do
    if [ -f "${SERVICE_PATH}docker-compose.yaml" ]; then
        COMPOSE_FILE="docker-compose.yaml"
    elif [ -f "${SERVICE_PATH}docker-compose.yml" ]; then
        COMPOSE_FILE="docker-compose.yml"
    else
        echo "No compose file found in $(basename $SERVICE_PATH), skipping."
        continue
    fi

    echo "Starting service in $(basename $SERVICE_PATH)..."
    sudo -E docker compose -f "$SERVICE_PATH/$COMPOSE_FILE" up -d
done

echo "All services processed!"

