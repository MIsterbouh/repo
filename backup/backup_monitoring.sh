#!/bin/bash
# Monitoring Stack Backup Script
source ./maintenance/backup_lib.sh

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
PROJ="kactus_docker"

echo "Backing up Monitoring Stack (Prometheus, Grafana, Loki)..."
docker compose stop prometheus grafana loki

./maintenance/backup_lib.sh "${PROJ}_prometheus_data" "prometheus_data_$TIMESTAMP.tar.gz"
./maintenance/backup_lib.sh "${PROJ}_grafana_data" "grafana_data_$TIMESTAMP.tar.gz"
./maintenance/backup_lib.sh "${PROJ}_loki_data" "loki_data_$TIMESTAMP.tar.gz"

docker compose start prometheus grafana loki
echo "Monitoring Stack Backup Completed."
