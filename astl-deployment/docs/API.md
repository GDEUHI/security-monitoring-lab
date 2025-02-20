# API Documentation

## Overview

The Automated Security Testing Lab (ASTL) exposes several APIs for integration and automation. This document details the available endpoints, authentication methods, and usage examples.

## Authentication

### Basic Authentication

```bash
curl -X POST https://localhost:5678/api/v1/auth \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "your_password"
  }'
```

Response:
```json
{
  "token": "eyJhbGciOiJIUzI1NiIs...",
  "expires": "2025-02-21T10:11:43Z"
}
```

## API Endpoints

### 1. Workflow Management

#### List Workflows
```http
GET /api/v1/workflows
Authorization: Bearer {token}
```

Response:
```json
{
  "workflows": [
    {
      "id": "workflow_1",
      "name": "Network Discovery",
      "status": "active",
      "last_run": "2025-02-20T10:11:43Z"
    }
  ]
}
```

#### Execute Workflow
```http
POST /api/v1/workflows/{workflow_id}/execute
Authorization: Bearer {token}
Content-Type: application/json

{
  "parameters": {
    "scan_range": "192.168.1.0/24",
    "scan_type": "quick"
  }
}
```

### 2. Security Events

#### Get Events
```http
GET /api/v1/events
Authorization: Bearer {token}
```

Parameters:
```yaml
filters:
  severity: high|medium|low
  start_time: ISO8601 timestamp
  end_time: ISO8601 timestamp
  limit: integer
  offset: integer
```

Response:
```json
{
  "events": [
    {
      "id": "evt_123",
      "type": "security_alert",
      "severity": "high",
      "timestamp": "2025-02-20T10:11:43Z",
      "details": {
        "source": "192.168.1.100",
        "description": "Unauthorized access attempt"
      }
    }
  ],
  "total": 1,
  "has_more": false
}
```

### 3. Device Management

#### List Devices
```http
GET /api/v1/devices
Authorization: Bearer {token}
```

Response:
```json
{
  "devices": [
    {
      "id": "dev_123",
      "ip": "192.168.1.100",
      "hostname": "workstation-1",
      "last_seen": "2025-02-20T10:11:43Z",
      "status": "active"
    }
  ]
}
```

#### Update Device
```http
PUT /api/v1/devices/{device_id}
Authorization: Bearer {token}
Content-Type: application/json

{
  "hostname": "new-hostname",
  "tags": ["windows", "workstation"],
  "monitoring_level": "high"
}
```

### 4. Scan Management

#### Start Scan
```http
POST /api/v1/scans
Authorization: Bearer {token}
Content-Type: application/json

{
  "type": "vulnerability",
  "targets": ["192.168.1.100"],
  "options": {
    "intensity": "normal",
    "ports": "1-1000"
  }
}
```

Response:
```json
{
  "scan_id": "scan_123",
  "status": "running",
  "estimated_time": 300
}
```

#### Get Scan Results
```http
GET /api/v1/scans/{scan_id}/results
Authorization: Bearer {token}
```

### 5. Alert Management

#### Get Alerts
```http
GET /api/v1/alerts
Authorization: Bearer {token}
```

#### Update Alert Status
```http
PUT /api/v1/alerts/{alert_id}
Authorization: Bearer {token}
Content-Type: application/json

{
  "status": "acknowledged",
  "notes": "False positive - investigating"
}
```

## Webhook Integration

### Register Webhook
```http
POST /api/v1/webhooks
Authorization: Bearer {token}
Content-Type: application/json

{
  "url": "https://your-server.com/webhook",
  "events": ["security_alert", "scan_complete"],
  "secret": "your_webhook_secret"
}
```

### Webhook Payload Example
```json
{
  "event": "security_alert",
  "timestamp": "2025-02-20T10:11:43Z",
  "data": {
    "alert_id": "alt_123",
    "severity": "high",
    "description": "Potential data breach detected"
  },
  "signature": "sha256_hmac_signature"
}
```

## Rate Limits

```yaml
rate_limits:
  default:
    requests: 1000
    per: hour
  scan_api:
    requests: 10
    per: minute
  bulk_operations:
    requests: 100
    per: hour
```

## Error Codes

```yaml
error_codes:
  400: Bad Request
  401: Unauthorized
  403: Forbidden
  404: Not Found
  429: Too Many Requests
  500: Internal Server Error
```

## SDK Examples

### Python
```python
from astl_client import ASTLClient

client = ASTLClient(
    base_url="https://localhost:5678",
    api_key="your_api_key"
)

# List workflows
workflows = client.workflows.list()

# Start a scan
scan = client.scans.create(
    type="vulnerability",
    targets=["192.168.1.100"]
)
```

### JavaScript
```javascript
const { ASTLClient } = require('astl-client');

const client = new ASTLClient({
  baseUrl: 'https://localhost:5678',
  apiKey: 'your_api_key'
});

// Get alerts
async function getAlerts() {
  const alerts = await client.alerts.list({
    severity: 'high',
    limit: 10
  });
  return alerts;
}
```

## Best Practices

### Security
1. Use HTTPS for all API calls
2. Implement API key rotation
3. Set appropriate rate limits
4. Validate all inputs
5. Monitor API usage

### Performance
1. Use pagination for large datasets
2. Implement caching where appropriate
3. Optimize query parameters
4. Monitor response times

### Integration
1. Handle errors gracefully
2. Implement retry logic
3. Log API interactions
4. Maintain version compatibility
