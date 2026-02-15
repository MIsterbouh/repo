#!/bin/bash
# phpIPAM Restore Script
# Usage: ./restore_phpipam.sh <timestamp>

if [ -z "$1" ]; then
    echo "Usage: $0 <timestamp>"
    exit 1
fi

TIMESTAMP=$1
PROJ="kactus_docker"

echo "Restoring phpIPAM from timestamp $TIMESTAMP..."
docker compose stop phpipam-web db

./maintenance/restore_lib.sh "${PROJ}_db_data" "db_data_$TIMESTAMP.tar.gz"
./maintenance/restore_lib.sh "${PROJ}_phpipam_data" "phpipam_data_$TIMESTAMP.tar.gz"

docker compose start db phpipam-web
echo "phpIPAM Restore Completed."
