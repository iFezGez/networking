# Tailscale (Docker) – Features Overview

## Introduction

This document highlights the key features available when running Tailscale inside a Docker container. Despite being containerized, Tailscale supports most mesh VPN and routing capabilities found in full OS deployments.

## Feature Matrix

| Feature                     | Description                                                               |
|-----------------------------|---------------------------------------------------------------------------|
| Automatic mesh connectivity | Direct or relay-based peer communication without manual IP config        |
| Subnet routing              | Advertise LAN/VLAN subnets to other Tailscale nodes                      |
| NAT traversal               | Bypass NAT/firewalls using UDP hole punching and DERP fallback           |
| MagicDNS                    | Internal name resolution within the tailnet using `.ts.net` domain       |
| ACLs and node tagging       | Fine-grained access control based on identity, tags, and groups          |
| Exit Node support           | Route internet-bound traffic through another Tailscale node              |
| Persistent IP address       | Each node receives a fixed IP (e.g., `100.x.x.x`)                        |
| Auth key management         | Supports ephemeral, reusable, and preapproved node authentication        |
| End-to-end encryption       | Based on WireGuard, all traffic is encrypted between nodes               |
| Central web admin UI        | Visual control over connected devices, routes, DNS, and ACLs             |

## Use Cases in Containers

- Join internal-only Docker services to a global mesh network
- Use the container as a private gateway for remote access to VLANs
- Run test services in isolated labs and connect securely without port forwarding
- Enable encrypted communication between cloud VMs and on-prem resources

## Best Practices for Docker Usage

| Aspect              | Recommendation                                                  |
|---------------------|------------------------------------------------------------------|
| Networking mode     | Use `host` mode for visibility into physical interfaces          |
| Capabilities        | Add `NET_ADMIN` and map `/dev/net/tun`                          |
| Persistent identity | Mount `/var/lib/tailscale` as a volume                          |
| Restarts            | Use `restart: unless-stopped` or manage via systemd/compose     |

## Related Sections

- [Installation](installation.md)
- [Networking](network.md)
- [Troubleshooting](../troubleshooting/general.md)
