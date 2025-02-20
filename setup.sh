#!/bin/bash

# Create necessary directories
mkdir -p nginx/conf.d nginx/ssl suricata/logs suricata/rules workflows

# Generate self-signed SSL certificate for development
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout nginx/ssl/nginx.key -out nginx/ssl/nginx.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

# Create basic NGINX configuration
cat > nginx/conf.d/default.conf << EOF
server {
    listen 80;
    listen [::]:80;
    server_name localhost;

    location / {
        return 301 https://\$host\$request_uri;
    }
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name localhost;

    ssl_certificate /etc/nginx/ssl/nginx.crt;
    ssl_certificate_key /etc/nginx/ssl/nginx.key;

    location / {
        proxy_pass http://n8n:5678;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

# Create .env file with default values
cat > .env << EOF
N8N_HOST=localhost
N8N_PROTOCOL=https
ELASTIC_VERSION=7.17.0
EOF

# Make setup script executable
chmod +x setup.sh

echo "Initial setup completed. Please review the configurations and run 'docker-compose up -d' to start the services."
