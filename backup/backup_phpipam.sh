#!/bin/bash
# phpIPAM Backup Script
source ./maintenance/backup_lib.sh

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
PROJ="kactus_docker"

echo "Backing up phpIPAM..."
docker compose stop phpipam-web db

./maintenance/backup_lib.sh "${PROJ}_db_data" "db_data_$TIMESTAMP.tar.gz"
./maintenance/backup_lib.sh "${PROJ}_phpipam_data" "phpipam_data_$TIMESTAMP.tar.gz"

docker compose start db phpipam-web
echo "phpIPAM Backup Completed."
