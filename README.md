# Automated Security Testing Lab (ASTL)

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/Docker-20.10%2B-blue)](https://www.docker.com/)
[![n8n](https://img.shields.io/badge/n8n-Latest-orange)](https://n8n.io/)

A comprehensive, containerized security testing environment designed for small to medium-sized networks (up to 50 devices). Features automated vulnerability assessment, threat hunting, and incident response capabilities.

## 🚀 Features

- **Automated Security Workflows**: Pre-configured n8n workflows for common security tasks
- **Multi-Level Security Testing**: Support for basic to advanced security operations
- **Isolated Testing Environment**: Separate networks for attack simulation and monitoring
- **Resource-Optimized**: Configured for optimal performance on smaller networks
- **Compliance Ready**: Automated compliance checking and reporting

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/ethical-hacking-lab.git
cd ethical-hacking-lab

# Start the lab
./manage-lab.sh start

# Check status
./manage-lab.sh status

# Stop the lab
./manage-lab.sh stop
```

## 📋 Prerequisites

- Docker Desktop 20.10+
- 8GB RAM minimum
- 50GB free disk space
- macOS/Linux environment

## 🔑 Default Credentials

- **n8n**:
  - URL: http://localhost:5678
  - Username: admin
  - Password: changeme

- **Kibana**:
  - URL: http://localhost:5601
  - No authentication (development setup)

- **Elasticsearch**:
  - URL: http://localhost:9200
  - No authentication (development setup)

## 📋 Available Commands

```bash
./manage-lab.sh {start|stop|restart|status|logs [service]}

Examples:
  ./manage-lab.sh start    - Start all services
  ./manage-lab.sh stop     - Stop all services
  ./manage-lab.sh restart  - Restart all services
  ./manage-lab.sh status   - Check service health
  ./manage-lab.sh logs n8n - Show logs for n8n
```

## 🔄 Sample Workflows

1. **Network Discovery** (`workflows/basic/1-network-discovery.json`)
   - Performs network scanning using nmap
   - Saves results to Elasticsearch
   - Runs on demand

2. **Vulnerability Scanning** (`workflows/basic/2-vulnerability-scan.json`)
   - Checks Metasploit framework status
   - Runs every 5 minutes
   - Logs results to Elasticsearch

3. **Incident Response** (`workflows/basic/3-incident-response.json`)
   - Connects to Wazuh manager
   - Retrieves agent status
   - Logs incidents to Elasticsearch

## 🏗 Architecture

### Core Components
- **n8n**: Workflow automation
- **Elasticsearch**: Data storage
- **Kibana**: Visualization
- **Wazuh**: Security monitoring
- **Metasploit**: Penetration testing
- **Kali Linux**: Security tools

### Networks
- **security_net**: Internal monitoring network
- **attack_net**: Isolated network for security testing

## 🛡 Security Considerations

- Default credentials are for testing only
- Change all passwords before deployment
- Review network isolation settings
- Monitor resource usage

## 📚 Documentation

- [Architecture Details](docs/ARCHITECTURE.md)
- [Security Guidelines](docs/SECURITY.md)
- [Workflow Details](docs/WORKFLOWS.md)
- [API Documentation](docs/API.md)
- [Setup Guide](docs/SETUP.md)
- [Contributing Guidelines](CONTRIBUTING.md)
- [Security Hardening](docs/HARDENING.md)
- [Wazuh Component Guide](docs/components/WAZUH.md)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Contact

- Project Link: https://github.com/YOUR_USERNAME/ethical-hacking-lab
- Issue Tracker: https://github.com/YOUR_USERNAME/ethical-hacking-lab/issues
