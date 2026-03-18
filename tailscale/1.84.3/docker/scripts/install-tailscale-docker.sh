#!/bin/bash
# install-tailscale-docker.sh
# Automated setup for Tailscale container with subnet routing on Debian/Ubuntu

set -e

echo "Updating packages..."
apt update && apt install -y docker.io docker-compose

echo "Creating working directory..."
mkdir -p /opt/tailscale-docker && cd /opt/tailscale-docker

echo "Generating docker-compose.yml..."
cat <<EOF > docker-compose.yml
version: '3.8'
services:
  tailscale:
    container_name: tailscale
    image: tailscale/tailscale:latest
    network_mode: "host"
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    volumes:
      - tailscale-lib:/var/lib/tailscale
      - /dev/net/tun:/dev/net/tun
    environment:
      - TS_AUTHKEY=tskey-xxxxxxxxxxxxxxxx
      - TS_EXTRA_ARGS=--hostname=dock1 --advertise-routes=10.0.0.0/24,10.10.0.0/24,10.20.0.0/24,10.30.0.0/24,10.40.0.0/24,10.50.0.0/24,10.60.0.0/24
    restart: unless-stopped

volumes:
  tailscale-lib:
EOF

echo "Starting container..."
docker-compose up -d

echo "Tailscale container is running."
echo "Visit https://login.tailscale.com/admin/machines to verify."
