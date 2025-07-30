# Tailscale 1.84.3 (Docker)

## Introduction

Tailscale is a secure mesh VPN solution based on WireGuard that allows devices to connect across private networks without complex firewall or NAT configurations. This stack documents the deployment of Tailscale inside a Docker container, which acts as an active node and subnet gateway to access internal lab VLANs.

## Stack Purpose

- Connect isolated Docker environments to the Tailscale mesh network
- Expose multiple internal VLANs to remote clients through a single container
- Provide secure relay between on-prem and mobile nodes
- Take advantage of automatic discovery, encrypted tunnels, and centralized ACLs

## Topology

```text
+-------------------+        VPN Mesh (Tailscale)       +---------------------+
|  Laptop (Remote)  |  <----------------------------->  |   Tailscale Container |
|  IP: 100.x.x.x    |                                  |   Host: dock1         |
+-------------------+                                  +-----------+---------+
                                                                    |
                                                                    | host networking
                                                                    |
                                                        +-----------+----------+
                                                        |  Internal VLANs       |
                                                        |  10.10.0.0/24, etc.   |
                                                        +------------------------+
```

## Components

| Component         | Version    | Role                            |
|-------------------|------------|----------------------------------|
| Tailscale image   | latest     | VPN node                         |
| Docker            | 24.x       | Container runtime environment    |
| Linux host        | Debian 12  | VLAN router + local bridge       |

## Documentation

- [Installation](installation.md)
- [Configuration](configuration.md)
- [Networking](network.md)
- [Features](features.md)
- [Troubleshooting](../troubleshooting/general.md)
