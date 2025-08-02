# General Troubleshooting – Nginx Proxy Manager

## Introduction

This guide provides solutions for common issues encountered when using Nginx Proxy Manager in a Docker environment, particularly with SSL, port conflicts, and reverse proxy failures.

---

## Port Conflicts (80/443)

**Symptoms:**
- Container won't start
- Logs show: `Error starting userland proxy: listen tcp 0.0.0.0:80: bind: address already in use`

**Solution:**
- Identify the process occupying the port:
  ```bash
  sudo lsof -i :80
  sudo lsof -i :443
  ```
- Stop or disable conflicting services (e.g. Apache, another Nginx)
- Restart NPM:
  ```bash
  docker-compose restart
  ```

---

## SSL Certificate Request Fails

**Symptoms:**
- Let's Encrypt cert fails to issue
- Error: `Timeout during connect (likely firewall blocking port 80)`

**Solution:**
- Ensure port 80 is open to the internet
- Temporarily disable Cloudflare proxy (DNS Only mode)
- Use DNS Challenge + Cloudflare API token if public IP is dynamic

---

## Wildcard DNS Challenge fails

**Symptoms:**
- Cert creation with `*.domain.com` fails
- Logs show DNS update timeout or token errors

**Solution:**
- Verify your API token in Cloudflare:
  - Must have DNS Read + Edit for the zone
- Ensure token uses correct `dns_cloudflare_api_token=...` format
- Check DNS propagation time or set Propagation Seconds to `60`

---

## Admin Panel Not Loading

**Symptoms:**
- UI is inaccessible via browser (`http://ip:81`)
- Browser says “refused to connect” or blank screen

**Solution:**
- Check container health:
  ```bash
  docker ps
  docker logs -f npm
  ```
- Verify port 81 is not blocked by firewall
- Check if container restarted due to volume or permission issues

---

## Proxy Host Not Responding

**Symptoms:**
- Clicking a domain returns 502 or times out
- Internal service doesn’t appear to respond

**Solution:**
- Confirm destination IP and port are correct
- Check if upstream service is running
- Enable WebSocket support if required
- Check container logs for backend errors

---

## Certificate Renewal Fails

**Symptoms:**
- Old cert shows "Expires soon" or “Renewal failed”

**Solution:**
- Go to **SSL Certificates** → manually click **Renew**
- Check if NPM has access to issue again (DNS or port 80)
- For DNS challenge, renews automatically if token is still valid

---

## Useful Commands

```bash
docker logs -f npm
docker exec -it npm nginx -t
docker inspect npm
```

---

## References

- [Nginx Proxy Manager Docs](https://nginxproxymanager.com/guide/)
- [Let's Encrypt Rate Limits](https://letsencrypt.org/docs/rate-limits/)
- [Cloudflare DNS API Docs](https://developers.cloudflare.com/api/)
