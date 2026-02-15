#!/bin/bash
# Global Restore Script
# Usage: ./restore_all.sh <timestamp>
# Example: ./restore_all.sh 20260215_120000

if [ -z "$1" ]; then
    echo "Usage: $0 <timestamp>"
    echo "Available backups:"
    ls maintenance/backups_data/*db_data* | sed 's/.*db_data_//;s/.tar.gz//'
    exit 1
fi

TIMESTAMP=$1
PROJ="kactus_docker"

echo "Starting Global System Restore for timestamp $TIMESTAMP..."
read -p "WARNING: This will overwrite current data. Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

echo "Stopping services..."
docker compose stop

./maintenance/restore_lib.sh "${PROJ}_db_data" "db_data_$TIMESTAMP.tar.gz"
./maintenance/restore_lib.sh "${PROJ}_wp_data" "wp_data_$TIMESTAMP.tar.gz"
./maintenance/restore_lib.sh "${PROJ}_phpipam_data" "phpipam_data_$TIMESTAMP.tar.gz"
./maintenance/restore_lib.sh "${PROJ}_portainer_data" "portainer_data_$TIMESTAMP.tar.gz"
./maintenance/restore_lib.sh "${PROJ}_prometheus_data" "prometheus_data_$TIMESTAMP.tar.gz"
./maintenance/restore_lib.sh "${PROJ}_grafana_data" "grafana_data_$TIMESTAMP.tar.gz"
./maintenance/restore_lib.sh "${PROJ}_loki_data" "loki_data_$TIMESTAMP.tar.gz"

echo "Restarting services..."
docker compose start

echo "Global Restore Completed."
