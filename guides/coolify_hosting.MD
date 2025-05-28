# Self-Hosting Setup with Coolify and Cloudflare Tunnel

This guide explains how to set up Coolify with Cloudflare Tunnel for secure, remote access to your self-hosted services.

## Overview

- Use Coolify as your self-hosting platform
- Connect Cloudflare Tunnel to Coolify services
- Configure Docker networking to allow proper communication

## Setup Instructions

### 1. Cloudflare Tunnel Configuration

Create a `docker-compose.yml` file with the following configuration:

```yaml
services:
 cloudflared:
   container_name: cloudflare-tunnel
   image: 'cloudflare/cloudflared:latest'
   restart: unless-stopped
   command: 'tunnel --no-autoupdate run'
   environment:
     - 'TUNNEL_TOKEN=${CLOUDFLARE_TUNNEL_TOKEN}'
   networks:
     - coolify
   healthcheck:
     test:
       - CMD
       - cloudflared
       - '--version'
     interval: 5s
     timeout: 20s
     retries: 10

networks:
 coolify:
   external: true

## 2. Network Configuration

The key configuration is connecting the Cloudflare Tunnel container to Coolify's network:

- Use `networks: - coolify` to join Coolify's network.  
- Set `external: true` to connect to the existing Coolify network.  
- **Do not** use `network_mode: host` as this would isolate Cloudflared from Coolify.  

## 3. Service Discovery  

After setup, forward traffic in Cloudflare Tunnel to the appropriate container name and port:  

- **For Coolify dashboard:** `http://coolify:8080`  
- **For Coolify proxy:** `http://coolify-proxy:443`  

## 4. Troubleshooting  

To find container names for forwarding:  

```bash
docker ps -a

This will list all container names that can be used in your Cloudflare Tunnel configuration.

