# Security Lab Services Guide

## 🔑 Quick Access

| Service | URL | Default Credentials |
|---------|-----|-------------------|
| n8n | http://localhost:5678 | admin/changeme |
| Kibana | http://localhost:5601 | none (dev mode) |
| Elasticsearch | http://localhost:9200 | none (dev mode) |
| Wazuh API | https://localhost:5500 | wazuh/wazuh |
| Metasploit | http://localhost:3790 | msf/msf |
| Kali Linux | http://localhost:8080 | kali/kali |

## 📊 Service Details

### 1. n8n (Workflow Automation)
- **Purpose**: Automate security workflows and integrations
- **Access**: http://localhost:5678
- **Credentials**: admin/changeme
- **Key Features**:
  - Workflow creation and management
  - API integrations
  - Scheduled tasks
  - Error handling and retries

**Quick Start**:
1. Navigate to http://localhost:5678
2. Log in with admin/changeme
3. Click "Workflows" to see available workflows
4. Import workflows from `workflows/basic/` directory

### 2. Kibana (Visualization)
- **Purpose**: Data visualization and analysis
- **Access**: http://localhost:5601
- **Key Features**:
  - Dashboard creation
  - Log analysis
  - Security event visualization
  - Custom reports

**Quick Start**:
1. Navigate to http://localhost:5601
2. Go to "Stack Management" → "Index Patterns"
3. Create index patterns for:
   - security-*
   - wazuh-*
   - vuln-*

### 3. Elasticsearch (Data Storage)
- **Purpose**: Central data storage and search
- **Access**: http://localhost:9200
- **Key Features**:
  - Full-text search
  - Real-time data indexing
  - RESTful API
  - Scalable storage

**Quick Start**:
```bash
# Check cluster health
curl http://localhost:9200/_cluster/health

# List indices
curl http://localhost:9200/_cat/indices
```

### 4. Wazuh (Security Monitoring)
- **Purpose**: Security monitoring and HIDS
- **Manager**: TCP 1514, 1515
- **API**: https://localhost:5500
- **Key Features**:
  - File integrity monitoring
  - Intrusion detection
  - Security policy monitoring
  - Compliance checking

**Quick Start**:
```bash
# Check Wazuh manager status
curl -k -X GET "https://localhost:5500/manager/status" \
     -H "Authorization: Bearer $WAZUH_TOKEN"
```

### 5. Metasploit (Security Testing)
- **Purpose**: Vulnerability assessment and penetration testing
- **Access**: Via docker exec
- **Key Features**:
  - Vulnerability scanning
  - Exploit development
  - Post-exploitation
  - Report generation

**Quick Start**:
```bash
# Access Metasploit console
docker exec -it ethical-hacking-lab-metasploit-1 ./msfconsole

# Basic scan
msf > db_nmap -sV 192.168.1.1
```

### 6. Kali Linux (Security Tools)
- **Purpose**: Comprehensive security testing environment
- **Access**: Via docker exec
- **Key Features**:
  - Full security toolkit
  - Custom tools installation
  - Persistent storage
  - Network analysis

**Quick Start**:
```bash
# Access Kali shell
docker exec -it ethical-hacking-lab-kali-1 bash

# Install additional tools
apt update && apt install -y nmap wireshark
```

## 🔧 Common Tasks

### Starting Services
```bash
# Start all services
./manage-lab.sh start

# Start specific service
docker-compose up -d elasticsearch
```

### Stopping Services
```bash
# Stop all services
./manage-lab.sh stop

# Stop specific service
docker-compose stop kibana
```

### Checking Logs
```bash
# View all logs
./manage-lab.sh logs

# View specific service logs
./manage-lab.sh logs n8n
```

### Backup Data
```bash
# Backup all data
./scripts/backup.sh

# Restore from backup
./scripts/restore.sh backup_20250220.tar.gz
```

## 🔒 Security Notes

1. **Default Credentials**
   - Change all default passwords before using in production
   - Use strong passwords
   - Rotate credentials regularly

2. **Network Security**
   - Services are exposed only on localhost
   - Use VPN for remote access
   - Monitor exposed ports

3. **Data Security**
   - Regular backups are recommended
   - Encrypt sensitive data
   - Monitor access logs

## 🔍 Troubleshooting

### Common Issues

1. **Service Won't Start**
```bash
# Check logs
./manage-lab.sh logs [service]

# Restart service
docker-compose restart [service]
```

2. **Cannot Connect to Service**
```bash
# Check if service is running
docker ps | grep [service]

# Check port mapping
docker-compose ps
```

3. **Data Persistence Issues**
```bash
# Check volume mounts
docker volume ls
docker volume inspect [volume_name]
```

## 📈 Monitoring

### Health Checks
```bash
# Check all services
./manage-lab.sh status

# Check specific service
curl http://localhost:5678/healthz  # n8n
curl http://localhost:9200/_cluster/health  # Elasticsearch
```

### Resource Usage
```bash
# Monitor container resources
docker stats

# Check disk usage
docker system df -v
```

## 🔄 Updates and Maintenance

### Updating Services
```bash
# Pull latest images
docker-compose pull

# Rebuild and restart
docker-compose up -d --build
```

### Cleaning Up
```bash
# Remove unused resources
docker system prune

# Clean old volumes
docker volume prune
```
