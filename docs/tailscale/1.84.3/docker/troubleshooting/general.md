# Tailscale (Docker) – Troubleshooting Guide

## Introduction

This guide provides common troubleshooting steps for issues encountered while running Tailscale inside a Docker container.

---

## Common Problems and Solutions

### Problem: Container is not connecting to Tailscale network

**Symptoms:**
- `tailscale status` shows `stopped` or `no connection`
- Node does not appear in the admin panel

**Solution:**
- Ensure the auth key is valid and preapproved
- Restart the container: `docker-compose restart`
- Check logs: `docker logs tailscale`

---

### Problem: Subnet routes not available

**Symptoms:**
- `tailscale status` does not show `routes: ...`
- Internal IPs (e.g. `10.10.0.1`) are not reachable from other nodes

**Solution:**
- Verify `--advertise-routes=` is set correctly in `TS_EXTRA_ARGS`
- Approve routes in the Admin Panel
- Enable IP forwarding on the host (`net.ipv4.ip_forward = 1`)

---

### Problem: DERP fallback for all connections

**Symptoms:**
- `tailscale netcheck` shows relay-only
- High latency and unstable connections

**Solution:**
- Check that outbound UDP port 41641 is allowed
- Inspect firewall/NAT rules for restrictive behavior

---

### Problem: MagicDNS is not working

**Symptoms:**
- Cannot resolve `hostname.tailnet.ts.net`
- Only IP-based access is functional

**Solution:**
- Enable MagicDNS in the admin panel under DNS settings
- Check that the Tailscale client has DNS configuration enabled

---

## Diagnostic Commands

```bash
tailscale status
tailscale netcheck
tailscale ip -4
ping 10.10.0.1
```

---

## Useful Links

- [Admin Panel](https://login.tailscale.com/admin/machines)
- [Official Docs – Troubleshooting](https://tailscale.com/kb/1017/troubleshooting/)
- [Subnet Routing Guide](https://tailscale.com/kb/1019/subnets)
