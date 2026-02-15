#!/bin/bash
# Reinstalls Prometheus container
echo "Reinstalling Prometheus..."
docker compose stop prometheus
docker compose rm -f prometheus
docker compose up -d --force-recreate --build prometheus
echo "Done."
