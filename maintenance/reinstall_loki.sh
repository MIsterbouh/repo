#!/bin/bash
# Reinstalls Loki container
echo "Reinstalling Loki..."
docker compose stop loki
docker compose rm -f loki
docker compose up -d --force-recreate --build loki
echo "Done."
