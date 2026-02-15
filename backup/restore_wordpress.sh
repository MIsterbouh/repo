#!/bin/bash
# WordPress Restore Script
# Usage: ./restore_wordpress.sh <timestamp>

if [ -z "$1" ]; then
    echo "Usage: $0 <timestamp>"
    exit 1
fi

TIMESTAMP=$1
PROJ="kactus_docker"

echo "Restoring WordPress from timestamp $TIMESTAMP..."
docker compose stop wordpress db

./maintenance/restore_lib.sh "${PROJ}_db_data" "db_data_$TIMESTAMP.tar.gz"
./maintenance/restore_lib.sh "${PROJ}_wp_data" "wp_data_$TIMESTAMP.tar.gz"

docker compose start db wordpress
echo "WordPress Restore Completed."
