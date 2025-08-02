# Networking for Nginx Proxy Manager

## Introduction

This document outlines the network design and requirements for deploying Nginx Proxy Manager in a Docker container, including ports, DNS, and integration with local VLANs.

## Required Ports

| Port | Protocol | Purpose              |
|------|----------|----------------------|
| 80   | TCP      | HTTP traffic         |
| 443  | TCP      | HTTPS traffic        |
| 81   | TCP      | Web admin UI         |

## Docker Network Mode

NPM runs in Docker bridge mode, publishing ports to the host interface. No special networking is needed unless you run services on custom bridges.

## VLANs and Host Interfaces

| Subnet         | Interface       | Purpose                        |
|----------------|------------------|--------------------------------|
| `10.10.0.0/24` | `vlan10-mgmt`    | Internal management traffic    |
| `10.20.0.0/24` | `vlan20-svc`     | Containers and services        |
| `10.30.0.0/24` | `vlan30-stor`    | NAS and backups                |
| `10.60.0.0/24` | `vlan60-dmz`     | External-facing services       |

## DNS and Domains

You can use:

- Internal DNS records (e.g. `grafana.lab.local`)
- Public DNS with wildcard (e.g. `*.vestasec.com`)

For SSL with Cloudflare, domain must resolve correctly and match the certificate.

## Testing Tools

```bash
curl -IL http://grafana.lab.local
curl -IL https://grafana.lab.local --insecure
docker logs -f npm
```

## Next Steps

- [Features →](features.md)
