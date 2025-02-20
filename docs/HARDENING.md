# Security Hardening Guide

## System Hardening

### Docker Hardening
```bash
# Create dedicated user for Docker
sudo groupadd docker
sudo usermod -aG docker $USER

# Configure Docker daemon
cat << EOF | sudo tee /etc/docker/daemon.json
{
  "userns-remap": "default",
  "live-restore": true,
  "userland-proxy": false,
  "no-new-privileges": true,
  "selinux-enabled": true,
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
EOF
```

### Container Hardening

#### Base Image Security
```dockerfile
# Use specific versions
FROM alpine:3.15

# Add security packages
RUN apk add --no-cache \
    ca-certificates \
    tzdata \
    && update-ca-certificates

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Set secure workdir
WORKDIR /app
```

### Network Security

#### Network Isolation
```yaml
# docker-compose.yml network configuration
networks:
  security_net:
    driver: bridge
    internal: true
    ipam:
      config:
        - subnet: 172.20.0.0/16
          ip_range: 172.20.5.0/24
    driver_opts:
      encrypt: "true"
```

## Application Security

### n8n Security

#### Authentication
```env
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=your_secure_password
N8N_JWT_SECRET=your_jwt_secret
```

#### Workflow Security
```javascript
// Validate input data
function validateInput(input) {
  if (!input || typeof input !== 'object') {
    throw new Error('Invalid input');
  }
  // Add more validation
}
```

### Elasticsearch Security

#### Security Settings
```yaml
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.http.ssl.enabled: true
```

#### Index Security
```bash
# Create secure index
curl -X PUT "localhost:9200/secure-logs" -H "Content-Type: application/json" -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 1,
    "index.mapping.total_fields.limit": 2000,
    "index.queries.cache.enabled": false
  }
}'
```

## Monitoring & Alerts

### System Monitoring
```yaml
# Prometheus configuration
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'node'
    static_configs:
      - targets: ['localhost:9100']
```

### Alert Rules
```yaml
# Alert manager rules
groups:
- name: security_alerts
  rules:
  - alert: HighErrorRate
    expr: rate(http_requests_total{status=~"5.."}[5m]) > 1
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: High error rate detected
```

## Compliance

### File Permissions
```bash
# Set secure permissions
chmod 600 /etc/security/*
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub
```

### Audit Policy
```bash
# Enable audit
auditctl -w /etc/passwd -p wa -k passwd_changes
auditctl -w /etc/security -p wa -k security_changes
```

## Backup Security

### Encrypted Backups
```bash
# Create encrypted backup
tar czf - /data | gpg --encrypt --recipient admin@example.com > backup.tar.gz.gpg

# Decrypt backup
gpg --decrypt backup.tar.gz.gpg | tar xzf -
```

### Secure Transfer
```bash
# Transfer using encrypted channel
rsync -avz -e "ssh -i /path/to/key" /backup/ user@remote:/backup/
```

## Regular Security Tasks

### Daily Tasks
```bash
#!/bin/bash
# security-daily.sh

# Check for failed login attempts
grep "Failed password" /var/log/auth.log

# Check for modified system files
find /etc -mtime -1 -type f -ls

# Check running services
netstat -tulpn

# Check disk usage
df -h
```

### Weekly Tasks
```bash
#!/bin/bash
# security-weekly.sh

# Update security packages
apt-get update && apt-get upgrade -y

# Check for unused users
for user in $(cut -d: -f1 /etc/passwd); do
  last $user | grep -q "never logged in" && echo "$user never logged in"
done

# Review audit logs
aureport --summary
```
