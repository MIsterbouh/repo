#!/bin/bash
# WordPress Backup Script
source ./maintenance/backup_lib.sh

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
PROJ="kactus_docker"

echo "Backing up WordPress..."
docker compose stop wordpress db

./maintenance/backup_lib.sh "${PROJ}_db_data" "db_data_$TIMESTAMP.tar.gz"
./maintenance/backup_lib.sh "${PROJ}_wp_data" "wp_data_$TIMESTAMP.tar.gz"

docker compose start db wordpress
echo "WordPress Backup Completed."
