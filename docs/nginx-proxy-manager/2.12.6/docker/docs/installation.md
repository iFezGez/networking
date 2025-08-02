# Installation of Nginx Proxy Manager (latest)

## Introduction

This guide explains how to install Nginx Proxy Manager (latest version) in a Docker container on a Vesta Lab VM. It provides a web-based GUI for managing reverse proxies, SSL certificates, and domain forwarding.

## Prerequisites

- A Linux VM with Docker and Docker Compose installed (e.g., dock1)
- Open ports: 80, 81, and 443 must not be used by other services
- Internet access for pulling the container image

## Step 1 – Create working directory

```bash
mkdir -p ~/npm-docker
cd ~/npm-docker
```

## Step 2 – Create docker-compose.yml

```yaml
version: '3'

services:
  npm:
    container_name: npm
    image: jc21/nginx-proxy-manager:latest
    restart: unless-stopped
    ports:
      - 80:80        # HTTP
      - 81:81        # Admin UI
      - 443:443      # HTTPS
    volumes:
      - npm-data:/data
      - npm-letsencrypt:/etc/letsencrypt

volumes:
  npm-data:
  npm-letsencrypt:
```

## Step 3 – Start the container

```bash
docker-compose up -d
```

## Step 4 – Access the Web UI

- URL: `http://<IP_of_dock1>:81`
- Default login:
  - Email: `admin@example.com`
  - Password: `changeme`

You will be prompted to set a new admin password on first login.

## GUI Configuration (Optional)

| Section           | Action                       | Purpose                                  |
|-------------------|------------------------------|------------------------------------------|
| SSL Certificates  | Request Let's Encrypt certs  | Secure HTTPS for any domain              |
| Hosts → Proxy     | Add a new proxy host         | Reverse proxy for services               |
| Users             | Create limited accounts      | Delegate access with RBAC                |

## Validation and Tests

```bash
docker ps
docker exec -it npm nginx -t
curl -I http://localhost
```

## Common Issues

| Problem                        | Solution                                      |
|-------------------------------|-----------------------------------------------|
| Port 80/443 already in use     | Stop conflicting services like Apache/Nginx  |
| Login fails                    | Reset via `/data/nginx/logs/error.log`       |
| SSL issues                     | Ensure domain points to your public IP       |

## Next Steps

- [Configuration →](configuration.md)
- [Official documentation](https://nginxproxymanager.com/guide/)
