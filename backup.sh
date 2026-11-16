#!/bin/bash
set -euo pipefail
BACKUP_DIR="/opt/backup"
ENV_FILE="/opt/dz56_practic_Docker/.env"
mkdir -p "$BACKUP_DIR"
source "$ENV_FILE"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
docker run --rm --entrypoint "" \
  --network dz56_practic_docker_backend \
  -v "$BACKUP_DIR:/backup" \
  schnitzler/mysqldump \
  mysqldump --opt -h db -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" > "$BACKUP_DIR/backup_$TIMESTAMP.sql"
