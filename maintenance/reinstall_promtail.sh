#!/bin/bash
# Reinstalls Promtail container
echo "Reinstalling Promtail..."
docker compose stop promtail
docker compose rm -f promtail
docker compose up -d --force-recreate --build promtail
echo "Done."
