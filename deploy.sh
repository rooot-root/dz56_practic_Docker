#!/bin/bash
set -euo pipefail

REPO_URL="https://github.com/rooot-root/dz56_practic_Docker.git"
TARGET_DIR="/opt/dz56_practic_Docker"

if ! command -v git >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y git
fi

if [ ! -d "$TARGET_DIR/.git" ]; then
    sudo mkdir -p /opt
    sudo git clone "$REPO_URL" "$TARGET_DIR"
    sudo chown -R "$USER":"$USER" "$TARGET_DIR"
else
    cd "$TARGET_DIR"
    git pull origin main
fi

cd "$TARGET_DIR"
docker compose up -d --build
echo "Project started. Check: curl -L http://127.0.0.1:8090"
