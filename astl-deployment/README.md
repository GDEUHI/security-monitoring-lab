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

## 📋 Prerequisites

- Docker Desktop 20.10+
- 8GB RAM minimum
- 50GB free disk space
- macOS/Linux environment

## 🛠 Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/ethical-hacking-lab.git

# Navigate to project directory
cd ethical-hacking-lab

# Setup environment
./setup.sh

# Start services
docker-compose up -d
```

## 🏗 Architecture

The lab consists of three primary components:

1. **Security Monitoring Layer**
   - n8n for workflow automation
   - Wazuh for HIDS
   - ELK Stack for log analysis

2. **Testing Environment**
   - Kali Linux for penetration testing
   - Metasploit Framework
   - Custom security tools

3. **Isolation Layer**
   - Network segregation
   - Security gateway
   - Traffic monitoring

For detailed architecture information, see [ARCHITECTURE.md](docs/ARCHITECTURE.md)

## 🔒 Security Workflows

### Level 1 - Basic Security
- Network Discovery
- Compliance Audit
- Basic Monitoring

### Level 2 - Advanced Monitoring
- Vulnerability Assessment
- Incident Response
- Enhanced Logging

### Level 3 - Security Testing
- Automated Pentesting
- Threat Hunting
- Red Team Automation

For workflow details, see [WORKFLOWS.md](docs/WORKFLOWS.md)

## 📊 Dashboards

- n8n Dashboard: `https://localhost:5678`
- Kibana: `http://localhost:5601`
- Security Gateway: `http://localhost:8080`

## 🛡 Security Considerations

- Default credentials are for testing only
- Change all passwords before deployment
- Review network isolation settings
- Monitor resource usage

## 📚 Documentation

- [Setup Guide](docs/SETUP.md)
- [Architecture](docs/ARCHITECTURE.md)
- [Workflows](docs/WORKFLOWS.md)
- [Security](docs/SECURITY.md)
- [API Reference](docs/API.md)
- [Contributing](CONTRIBUTING.md)

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- n8n community
- Docker community
- Security tool maintainers

## 📧 Contact

- Project Link: https://github.com/yourusername/ethical-hacking-lab
- Issue Tracker: https://github.com/yourusername/ethical-hacking-lab/issues
