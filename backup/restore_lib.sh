#!/bin/bash
# Helper function to restore a volume
# Usage: restore_volume <volume_name> <backup_file_name>

VOLUME_NAME=$1
BACKUP_NAME=$2
BACKUP_DIR=$(pwd)/backups_data

if [ ! -f "$BACKUP_DIR/$BACKUP_NAME" ]; then
    echo "Error: Backup file $BACKUP_DIR/$BACKUP_NAME not found."
    exit 1
fi

echo "Restoring volume $VOLUME_NAME from $BACKUP_NAME..."
# Create volume if it doesn't exist
docker volume create "$VOLUME_NAME" > /dev/null

# Restore data
docker run --rm -v "$VOLUME_NAME":/data -v "$BACKUP_DIR":/backup alpine sh -c "cd /data && rm -rf * && tar -xzf /backup/$BACKUP_NAME"
echo "Restore of $VOLUME_NAME completed."
