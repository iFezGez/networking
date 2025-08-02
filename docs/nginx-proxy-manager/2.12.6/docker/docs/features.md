# Nginx Proxy Manager – Feature Overview

## Introduction

Nginx Proxy Manager is a web-based GUI for managing Nginx reverse proxies with SSL. Ideal for homelabs, SMBs, and production gateways.

## Core Features

| Feature              | Description                                              |
|----------------------|----------------------------------------------------------|
| Proxy hosts          | Route domains to internal services                       |
| SSL certificates     | Let's Encrypt, self-signed, or manual                    |
| Wildcard support     | Full wildcard via Cloudflare DNS challenge               |
| HTTP to HTTPS        | Automatic redirection, HSTS, HTTP/2                      |
| Access control       | IP allow/deny lists per host                             |
| Logging              | Per-host logs + global stats from UI                     |
| Multi-user support   | Add GUI accounts with role restrictions                  |
| Config backup        | Export and import configuration snapshots                |

## Typical Use Cases

- Expose internal tools securely via subdomains
- Centralize TLS management with auto-renewals
- Replace nginx + certbot setups with friendly UI

## UI Sections

- Dashboard: system and container stats
- Hosts: manage proxy/redirection/stream rules
- SSL: view/manage certificate status
- Users: manage access for admins or guests

## Next Steps

- [Troubleshooting →](../troubleshooting/general.md)
