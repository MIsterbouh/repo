#!/bin/bash
# Global Backup Script
source ./maintenance/backup_lib.sh

echo "Starting Global System Backup..."
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Stop services to ensure consistency
echo "Stopping services..."
docker compose stop

# Backup Volumes
# Syntax: backup_volume <volume_name_in_docker> <backup_filename>
# Note: Volume names usually prefixed by project name (kactus_docker_)
# We assume project name 'kactus_docker' based on folder name usually, 
# but defined in docker-compose as top level volumes. 
# Docker Compose prefixes volumes with project name. 
# If project name is 'kactus_docker', volume is 'kactus_docker_db_data'

PROJ="kactus_docker"

./maintenance/backup_lib.sh "${PROJ}_db_data" "db_data_$TIMESTAMP.tar.gz"
./maintenance/backup_lib.sh "${PROJ}_wp_data" "wp_data_$TIMESTAMP.tar.gz"
./maintenance/backup_lib.sh "${PROJ}_phpipam_data" "phpipam_data_$TIMESTAMP.tar.gz"
./maintenance/backup_lib.sh "${PROJ}_portainer_data" "portainer_data_$TIMESTAMP.tar.gz"
./maintenance/backup_lib.sh "${PROJ}_prometheus_data" "prometheus_data_$TIMESTAMP.tar.gz"
./maintenance/backup_lib.sh "${PROJ}_grafana_data" "grafana_data_$TIMESTAMP.tar.gz"
./maintenance/backup_lib.sh "${PROJ}_loki_data" "loki_data_$TIMESTAMP.tar.gz"

echo "Restarting services..."
docker compose start

echo "Global Backup Completed. Files are in maintenance/backups_data/"
