# Setup Guide

## Prerequisites

### System Requirements
```yaml
hardware:
  cpu: 4 cores minimum
  memory: 8GB minimum
  storage: 50GB free space

software:
  os: macOS/Linux
  docker: 20.10+
  docker_compose: 2.0+
```

### Network Requirements
```yaml
ports:
  - 5678  # n8n
  - 5601  # Kibana
  - 9200  # Elasticsearch
  - 8080  # Security Gateway
```

## Installation

### 1. Clone Repository
```bash
git clone https://github.com/yourusername/ethical-hacking-lab.git
cd ethical-hacking-lab
```

### 2. Environment Setup
```bash
# Create required directories
mkdir -p {backups,workflows,nginx/{conf.d,ssl},suricata/{logs,rules}}

# Copy example configuration
cp config/example.env .env

# Generate SSL certificates
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout nginx/ssl/nginx.key -out nginx/ssl/nginx.crt \
  -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"
```

### 3. Configuration

#### Update Environment Variables
```bash
# Edit .env file
nano .env
```

Example `.env`:
```env
# n8n Configuration
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=changeme

# Elasticsearch Configuration
ELASTIC_VERSION=7.17.0
ES_JAVA_OPTS="-Xms1g -Xmx1g"

# Network Configuration
DOCKER_SUBNET=172.20.0.0/16
```

#### Configure NGINX
```nginx
# nginx/conf.d/default.conf
server {
    listen 80;
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    ssl_certificate /etc/nginx/ssl/nginx.crt;
    ssl_certificate_key /etc/nginx/ssl/nginx.key;

    location / {
        proxy_pass http://n8n:5678;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

### 4. Start Services

```bash
# Start all services
docker-compose up -d

# Check service status
docker-compose ps

# View logs
docker-compose logs -f
```

## Post-Installation

### 1. Security Configuration

#### Change Default Passwords
```bash
# n8n
docker-compose exec n8n npm run change-password

# Elasticsearch
curl -X POST "localhost:9200/_security/user/elastic/_password" \
  -H "Content-Type: application/json" \
  -d '{"password":"new_password"}'
```

#### Configure Firewall
```bash
# Allow required ports
sudo ufw allow 5678/tcp  # n8n
sudo ufw allow 5601/tcp  # Kibana
sudo ufw allow 8080/tcp  # Gateway

# Enable firewall
sudo ufw enable
```

### 2. Import Workflows

```bash
# Navigate to n8n dashboard
open https://localhost:5678

# Import workflows
1. Click "Workflows"
2. Click "Import from File"
3. Select workflows from ./workflows directory
```

### 3. Configure Monitoring

#### Setup Elasticsearch Indices
```bash
# Create security index
curl -X PUT "localhost:9200/security-events" \
  -H "Content-Type: application/json" \
  -d '{
    "settings": {
      "number_of_shards": 1,
      "number_of_replicas": 0
    }
  }'
```

#### Configure Kibana
1. Navigate to http://localhost:5601
2. Create index pattern for security-events
3. Import saved dashboards

## Verification

### 1. Check Services
```bash
# Verify all containers are running
docker-compose ps

# Check n8n
curl -I https://localhost:5678

# Check Elasticsearch
curl -I http://localhost:9200

# Check Kibana
curl -I http://localhost:5601
```

### 2. Test Workflows
```bash
# Run network discovery workflow
curl -X POST "https://localhost:5678/api/v1/workflows/network-discovery/execute" \
  -H "Authorization: Bearer YOUR_TOKEN"

# Check results
curl "https://localhost:5678/api/v1/executions" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

### 3. Verify Security
```bash
# Test SSL
openssl s_client -connect localhost:443

# Test authentication
curl -u admin:changeme https://localhost:5678/api/v1/workflows
```

## Troubleshooting

### Common Issues

#### Container Won't Start
```bash
# Check logs
docker-compose logs [service_name]

# Check resources
docker stats

# Verify ports
netstat -tulpn | grep LISTEN
```

#### Network Issues
```bash
# Check Docker networks
docker network ls
docker network inspect ethical-hacking-lab_security_net

# Test connectivity
docker-compose exec n8n ping elasticsearch
```

#### Permission Issues
```bash
# Fix volume permissions
sudo chown -R 1000:1000 ./volumes

# Fix log permissions
sudo chmod 644 ./logs/*
```

### Logs

#### Collect Debug Information
```bash
# Create debug archive
./scripts/collect-debug-info.sh

# View specific service logs
docker-compose logs -f n8n
docker-compose logs -f elasticsearch
```

## Maintenance

### Backup
```bash
# Backup volumes
./scripts/backup-volumes.sh

# Backup configurations
tar -czf configs.tar.gz \
  docker-compose.yml \
  .env \
  nginx/conf.d/ \
  workflows/
```

### Updates
```bash
# Update images
docker-compose pull

# Apply updates
docker-compose up -d

# Clean up
docker system prune
```

### Health Checks
```bash
# Check system health
./scripts/health-check.sh

# Monitor resources
docker stats

# Check logs for errors
grep -r "ERROR" ./logs/
```

## Additional Resources

### Documentation
- [Architecture Overview](ARCHITECTURE.md)
- [Security Guide](SECURITY.md)
- [API Documentation](API.md)
- [Workflow Guide](WORKFLOWS.md)

### Support
- GitHub Issues: [Report a Bug](https://github.com/yourusername/ethical-hacking-lab/issues)
- Documentation: [Wiki](https://github.com/yourusername/ethical-hacking-lab/wiki)
- Community: [Discussions](https://github.com/yourusername/ethical-hacking-lab/discussions)
