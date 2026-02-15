#!/bin/bash
# Monitoring Stack Restore Script
# Usage: ./restore_monitoring.sh <timestamp>

if [ -z "$1" ]; then
    echo "Usage: $0 <timestamp>"
    exit 1
fi

TIMESTAMP=$1
PROJ="kactus_docker"

echo "Restoring Monitoring Stack from timestamp $TIMESTAMP..."
docker compose stop prometheus grafana loki

./maintenance/restore_lib.sh "${PROJ}_prometheus_data" "prometheus_data_$TIMESTAMP.tar.gz"
./maintenance/restore_lib.sh "${PROJ}_grafana_data" "grafana_data_$TIMESTAMP.tar.gz"
./maintenance/restore_lib.sh "${PROJ}_loki_data" "loki_data_$TIMESTAMP.tar.gz"

docker compose start prometheus grafana loki
echo "Monitoring Stack Restore Completed."
