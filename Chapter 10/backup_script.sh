#!/bin/bash
# PostgreSQL backup script
# Variables
PG_USER="postgres"
PG_DB="postgres"
BACKUP_DIR="/pg_backup/Daily_backup"
BACKUP_FILE="$BACKUP_DIR/backup_$(date +%Y%m%d%H%M%S).sql"
# Perform the backup
pg_dump -U $PG_USER -d $PG_DB -F p -f $BACKUP_FILE
# Optional: Compress the backup file
gzip $BACKUP_FILE
# Optional: Remove backups older than X days
find $BACKUP_DIR -name "*.gz" -mtime +7 -delete