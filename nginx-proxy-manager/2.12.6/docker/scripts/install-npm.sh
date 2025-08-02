#!/bin/bash
# install-npm.sh – Install Nginx Proxy Manager (latest) in Docker

set -e

echo "[INFO] Installing dependencies..."
apt update
apt install -y docker.io docker-compose

echo "[INFO] Creating working directory..."
mkdir -p /opt/npm-docker
cd /opt/npm-docker

echo "[INFO] Writing docker-compose.yml..."
cat <<EOF > docker-compose.yml
version: '3'
services:
  npm:
    container_name: npm
    image: jc21/nginx-proxy-manager:latest
    restart: unless-stopped
    ports:
      - 80:80
      - 81:81
      - 443:443
    volumes:
      - npm-data:/data
      - npm-letsencrypt:/etc/letsencrypt

volumes:
  npm-data:
  npm-letsencrypt:
EOF

echo "[INFO] Starting Nginx Proxy Manager container..."
docker-compose up -d

echo "[DONE] Nginx Proxy Manager should be accessible at http://<host-ip>:81"
echo "Default login: admin@example.com / changeme"
