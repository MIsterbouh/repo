#!/bin/bash
# Reinstalls Node Exporter container
echo "Reinstalling Node Exporter..."
docker compose stop node-exporter
docker compose rm -f node-exporter
docker compose up -d --force-recreate --build node-exporter
echo "Done."
