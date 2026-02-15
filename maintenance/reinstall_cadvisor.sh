#!/bin/bash
# Reinstalls cAdvisor container
echo "Reinstalling cAdvisor..."
docker compose stop cadvisor
docker compose rm -f cadvisor
docker compose up -d --force-recreate --build cadvisor
echo "Done."
