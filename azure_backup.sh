#!/bin/bash

# ============================
# Azure Backup Script (Simple)
# ============================

SOURCE_DIR=$1
CONTAINER_NAME=$2
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="/tmp/backup_$TIMESTAMP.tar.gz"
LOG_FILE="$HOME/azure_backup.log"

# Step 1: Validate Inputs
if [ -z "$SOURCE_DIR" ] || [ -z "$CONTAINER_NAME" ]; then
  echo "Usage: $0 <source_directory> <container_name>"
  exit 1
fi

# Step 2: Create backup archive
echo "[INFO] Creating backup archive..." | tee -a $LOG_FILE
tar -czf "$BACKUP_FILE" "$SOURCE_DIR"
if [ $? -ne 0 ]; then
  echo "[ERROR] Failed to create backup archive." | tee -a $LOG_FILE
  exit 2
fi

# Step 3: Upload to Azure Blob Storage
echo "[INFO] Uploading to Azure Storage..." | tee -a $LOG_FILE
az storage blob upload \
  --connection-string "$AZURE_STORAGE_CONNECTION_STRING" \
  --container-name "$CONTAINER_NAME" \
  --file "$BACKUP_FILE" \
  --name "backup_$TIMESTAMP.tar.gz" \
  --output none

if [ $? -eq 0 ]; then
  echo "[SUCCESS] Backup uploaded successfully at $TIMESTAMP" | tee -a $LOG_FILE
else
  echo "[ERROR] Upload failed." | tee -a $LOG_FILE
  exit 3
fi

# Step 4: Clean up
rm "$BACKUP_FILE"
echo "[INFO] Local backup file deleted." | tee -a $LOG_FILE
