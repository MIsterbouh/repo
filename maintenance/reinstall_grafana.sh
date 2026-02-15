#!/bin/bash
# Reinstalls Grafana container
echo "Reinstalling Grafana..."
docker compose stop grafana
docker compose rm -f grafana
docker compose up -d --force-recreate --build grafana
echo "Done."
