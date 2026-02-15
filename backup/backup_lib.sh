#!/bin/bash
# Helper function to backup a volume
# Usage: backup_volume <volume_name> <backup_file_name>

VOLUME_NAME=$1
BACKUP_NAME=$2
BACKUP_DIR=$(pwd)/backups_data

mkdir -p "$BACKUP_DIR"

echo "Backing up volume $VOLUME_NAME to $BACKUP_NAME..."
docker run --rm -v "$VOLUME_NAME":/data -v "$BACKUP_DIR":/backup alpine tar -czf "/backup/$BACKUP_NAME" -C /data .
echo "Backup of $VOLUME_NAME completed."
