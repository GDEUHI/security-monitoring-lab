# Security Lab Testing Guide

## 🔍 Test Cases and Use Cases

### Use Case 1: Network Discovery and Monitoring
**Purpose**: Automated network scanning and asset discovery
**Components**: n8n, Elasticsearch, Kibana
**Steps**:
1. Start the lab: `./manage-lab.sh start`
2. Access n8n (http://localhost:5678)
3. Import and activate "Network Discovery" workflow
4. Monitor results in Kibana dashboard

**Success Criteria**:
- [ ] Workflow executes successfully
- [ ] Network scan results are stored in Elasticsearch
- [ ] Results are viewable in Kibana

### Use Case 2: Vulnerability Assessment
**Purpose**: Automated security scanning
**Components**: Metasploit, n8n, Elasticsearch
**Steps**:
1. Access n8n workflow dashboard
2. Import "Vulnerability Scan" workflow
3. Configure target scope
4. Run assessment
5. Review results in Kibana

**Success Criteria**:
- [ ] Metasploit framework initializes correctly
- [ ] Scan completes without errors
- [ ] Results are properly indexed in Elasticsearch

### Use Case 3: Incident Response Simulation
**Purpose**: Test incident detection and response
**Components**: Wazuh, n8n, Elasticsearch
**Steps**:
1. Configure Wazuh agent
2. Trigger test alert
3. Verify alert capture
4. Check automated response workflow

**Success Criteria**:
- [ ] Alerts are properly generated
- [ ] Incidents are logged in Elasticsearch
- [ ] Response workflows execute automatically

### Use Case 4: Security Compliance Checking
**Purpose**: Automated compliance verification
**Components**: n8n, Wazuh, Elasticsearch
**Steps**:
1. Import compliance workflow
2. Run compliance check
3. Generate compliance report
4. Review in Kibana dashboard

**Success Criteria**:
- [ ] Compliance checks execute successfully
- [ ] Reports are generated in correct format
- [ ] Results are searchable in Kibana

### Use Case 5: Threat Hunting
**Purpose**: Proactive threat detection
**Components**: Kali Linux, n8n, Elasticsearch
**Steps**:
1. Configure threat intel feeds
2. Import threat hunting workflow
3. Execute hunt operation
4. Analyze results

**Success Criteria**:
- [ ] Threat intel is properly ingested
- [ ] Hunt operations complete successfully
- [ ] Results are properly categorized and stored

## 🔧 Component Testing

### 1. Elasticsearch
```bash
# Test Elasticsearch health
curl http://localhost:9200/_cluster/health

# Expected output:
{
  "cluster_name": "docker-cluster",
  "status": "green",
  "number_of_nodes": 1
}
```

### 2. Kibana
```bash
# Test Kibana status
curl http://localhost:5601/api/status

# Expected: 200 OK response
```

### 3. n8n
```bash
# Test n8n health
curl http://localhost:5678/healthz

# Expected: 200 OK response
```

### 4. Wazuh Manager
```bash
# Test Wazuh API
curl -k -X GET "https://localhost:55000/security/user/authenticate" -H "Authorization: Basic d2F6dWg6d2F6dWg="

# Expected: Valid token response
```

## 📊 Performance Testing

### Resource Usage Baseline
```bash
# Check container resource usage
docker stats --no-stream

# Expected Limits:
- Elasticsearch: < 1GB RAM
- n8n: < 500MB RAM
- Kibana: < 500MB RAM
```

### Network Isolation Test
```bash
# Test attack network isolation
docker exec ethical-hacking-lab-kali-1 ping 8.8.8.8
# Expected: No response (isolated network)

# Test security network connectivity
docker exec ethical-hacking-lab-elasticsearch-1 ping kibana
# Expected: Successful response
```

## 🔒 Security Testing

### 1. Access Control
- [ ] n8n requires authentication
- [ ] Elasticsearch ports are only accessible within security_net
- [ ] Wazuh API requires authentication
- [ ] Attack network is properly isolated

### 2. Data Security
- [ ] Elasticsearch data is persisted across restarts
- [ ] n8n workflows are properly saved
- [ ] Logs are properly rotated
- [ ] Sensitive data is not exposed in logs

### 3. Network Security
- [ ] Services use appropriate encryption
- [ ] Internal networks are properly segregated
- [ ] External access is properly restricted
- [ ] No unnecessary ports are exposed

## 🔄 Integration Testing

### 1. Workflow Integration
- [ ] n8n can connect to Elasticsearch
- [ ] Wazuh alerts are captured by n8n
- [ ] Metasploit results are properly stored
- [ ] Kibana can visualize all data sources

### 2. Data Flow
- [ ] Network scans are properly indexed
- [ ] Alerts are properly formatted
- [ ] Reports are generated correctly
- [ ] Data is properly timestamped

## 📝 Test Results

| Component | Status | Notes |
|-----------|--------|-------|
| Elasticsearch | | |
| Kibana | | |
| n8n | | |
| Wazuh | | |
| Metasploit | | |
| Kali Linux | | |

## 🔍 Troubleshooting

### Common Issues

1. **Elasticsearch Fails to Start**
   ```bash
   # Check logs
   docker logs ethical-hacking-lab-elasticsearch-1
   # Common fix: Increase virtual memory
   sudo sysctl -w vm.max_map_count=262144
   ```

2. **n8n Workflow Failures**
   ```bash
   # Check n8n logs
   docker logs ethical-hacking-lab-n8n-1
   # Common fix: Restart n8n container
   docker restart ethical-hacking-lab-n8n-1
   ```

3. **Network Connectivity Issues**
   ```bash
   # Check network isolation
   docker network inspect ethical-hacking-lab_attack_net
   docker network inspect ethical-hacking-lab_security_net
   ```

## 📈 Monitoring

### Health Checks
```bash
# Run all health checks
./manage-lab.sh status

# Check specific service
./manage-lab.sh logs elasticsearch
```

### Performance Monitoring
```bash
# Monitor resource usage
docker stats

# Check disk usage
docker system df -v
```
