# Basic Server Setup Guide

This guide walks you through setting up a basic web server with NGINX, SSL certificates, and process management for hosting your applications.

## Prerequisites

- A VPS or dedicated server with Ubuntu/Debian
- Root or sudo access
- A registered domain name
- Basic command line knowledge

## Step 1: Install Necessary Packages

Update your system and install required runtime environments:

```bash
# Update system packages
sudo apt update && sudo apt upgrade -y

Install necessary things for your project(node.js / go etc...)


# Verify installations
node --version
npm --version
go version
```

## Step 2: Install NGINX and Certbot

```bash
# Install NGINX
sudo apt install nginx -y

# Install Certbot for SSL certificates
sudo apt install certbot python3-certbot-nginx -y

# Start and enable NGINX
sudo systemctl start nginx
sudo systemctl enable nginx
```

## Step 3: Install Process Manager

Choose one based on your deployment method:

### Option A: PM2 (for non-Docker applications)
```bash
sudo npm install -g pm2
```

### Option B: Docker (for containerized applications)
```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install Docker Compose
sudo apt install docker-compose -y

# Add user to docker group (logout/login required)
sudo usermod -aG docker $USER
```

## Step 4: Configure DNS

Add an A record in your domain's DNS settings:
- **Type:** A
- **Name:** @ (for root domain) or subdomain name
- **Value:** Your server's IP address
- **TTL:** 300 (5 minutes) or default

Wait for DNS propagation (can take up to 48 hours, usually much faster).
Add both example.com and www.example.com if you want www support

## Step 5: Create NGINX Configuration

Create a new site configuration file:

```bash
sudo nano /etc/nginx/sites-available/examplesite.com
```

Add the following configuration (adjust port and paths as needed):

```nginx
server {
    listen 80;
    server_name examplesite.com www.examplesite.com;

    location / {
        proxy_pass http://localhost:3000;  # Adjust port to match your app
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
```

**Important:** Make sure the `proxy_pass` port matches the port your application is running on.

## Step 6: Enable the Site

Create a symbolic link to enable the site:

```bash
sudo ln -s /etc/nginx/sites-available/examplesite.com /etc/nginx/sites-enabled/
```

## Step 7: Set Up SSL Certificate

Use Certbot to automatically configure HTTPS:

```bash
sudo certbot --nginx -d examplesite.com -d www.examplesite.com
```

Follow the prompts to:
- Enter your email address
- Agree to terms of service
- Choose whether to share email with EFF
- Select redirect option (recommended: redirect HTTP to HTTPS)

## Step 8: Test and Reload NGINX

Test the NGINX configuration for syntax errors:

```bash
sudo nginx -t
```

If the test passes, reload NGINX to apply changes:

```bash
sudo systemctl reload nginx
```

## Step 9: Start Your Application

Make sure your application is running on the correct port:

### Using PM2:
```bash
# Start your app with PM2
pm2 start app.js --name "examplesite"
pm2 startup  # Configure PM2 to start on boot
pm2 save     # Save current process list
```

### Using Docker:
```bash
# Run your containerized app
docker run -d -p 3000:3000 --name examplesite your-app-image
```

## Step 10: Verify Setup

Open your browser and navigate to `https://examplesite.com`. You should see your application running with a valid SSL certificate.

## Troubleshooting

### Common Issues:

1. **502 Bad Gateway**: Check if your application is running on the correct port
2. **DNS not resolving**: Wait for DNS propagation or check A record configuration
3. **SSL certificate issues**: Ensure domain is accessible via HTTP before running Certbot
4. **Permission denied**: Check file permissions and ensure NGINX user can access files

### Useful Commands:

```bash
# Check NGINX status
sudo systemctl status nginx

# View NGINX error logs
sudo tail -f /var/log/nginx/error.log

# Check which process is using a port
sudo netstat -tlnp | grep :3000

# Restart NGINX
sudo systemctl restart nginx

# Check SSL certificate expiry
sudo certbot certificates
```

## Security Considerations

- Regularly update your server packages
- Configure a firewall (ufw recommended)
- Set up automatic SSL certificate renewal: `sudo crontab -e` and add `0 12 * * * /usr/bin/certbot renew --quiet`
- Consider setting up fail2ban for additional security
- Use strong passwords and SSH keys for server access

Your site should now be live and accessible at `https://examplesite.com`!
