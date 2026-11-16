#!/bin/bash
set -euo pipefail
BACKUP_DIR="/opt/backup"
ENV_FILE="/opt/dz56_practic_Docker/.env"
mkdir -p "$BACKUP_DIR"
# shellcheck disable=SC1090
source "$ENV_FILE"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
docker run --rm --network dz56_practic_docker_backend \
  -e MYSQL_HOST=db \
  -e MYSQL_USER=root \
  -e MYSQL_PASSWORD="$MYSQL_ROOT_PASSWORD" \
  -e MYSQL_DATABASE="$MYSQL_DATABASE" \
  -v "$BACKUP_DIR:/backup" \
  schnitzler/mysqldump \
  mysqldump --host=db -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" > "$BACKUP_DIR/backup_$TIMESTAMP.sql"
