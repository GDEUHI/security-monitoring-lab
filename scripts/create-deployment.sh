#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Creating deployment package for ASTL...${NC}"

# Create deployment directory
DEPLOY_DIR="astl-deployment"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
PACKAGE_NAME="astl-deployment-${TIMESTAMP}.tar.gz"

# Create directory structure
mkdir -p ${DEPLOY_DIR}/{config,scripts,workflows,docs}

# Copy configuration files
echo -e "${GREEN}Copying configuration files...${NC}"
cp docker-compose.yml ${DEPLOY_DIR}/
cp .env ${DEPLOY_DIR}/config/
cp -r nginx ${DEPLOY_DIR}/config/
cp -r workflows ${DEPLOY_DIR}/

# Copy documentation
echo -e "${GREEN}Copying documentation...${NC}"
cp -r docs ${DEPLOY_DIR}/
cp README.md ${DEPLOY_DIR}/
cp CONTRIBUTING.md ${DEPLOY_DIR}/

# Create installation script
cat > ${DEPLOY_DIR}/install.sh << 'EOF'
#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}Starting ASTL installation...${NC}"

# Check prerequisites
command -v docker >/dev/null 2>&1 || { echo -e "${RED}Docker is required but not installed. Aborting.${NC}" >&2; exit 1; }
command -v docker-compose >/dev/null 2>&1 || { echo -e "${RED}Docker Compose is required but not installed. Aborting.${NC}" >&2; exit 1; }

# Create necessary directories
echo -e "${GREEN}Creating directories...${NC}"
mkdir -p {nginx/{conf.d,ssl},suricata/{logs,rules}}

# Copy configuration files
echo -e "${GREEN}Copying configuration files...${NC}"
cp config/.env ./.env
cp -r config/nginx/* ./nginx/

# Generate SSL certificates
echo -e "${GREEN}Generating SSL certificates...${NC}"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout nginx/ssl/nginx.key -out nginx/ssl/nginx.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

# Start services
echo -e "${GREEN}Starting services...${NC}"
docker-compose up -d

# Verify installation
echo -e "${GREEN}Verifying installation...${NC}"
sleep 10
docker-compose ps

# Print access information
echo -e "${BLUE}Installation complete!${NC}"
echo -e "${GREEN}Access your services at:${NC}"
echo "n8n: https://localhost:5678"
echo "Kibana: http://localhost:5601"
echo "Security Gateway: http://localhost:8080"
EOF

# Make installation script executable
chmod +x ${DEPLOY_DIR}/install.sh

# Create backup script
cat > ${DEPLOY_DIR}/scripts/backup.sh << 'EOF'
#!/bin/bash

BACKUP_DIR="backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Create backup directory
mkdir -p ${BACKUP_DIR}

# Backup volumes
echo "Backing up volumes..."
docker run --rm \
    --volumes-from $(docker-compose ps -q elasticsearch) \
    -v $(pwd)/${BACKUP_DIR}:/backup \
    alpine tar czf /backup/elasticsearch-${TIMESTAMP}.tar.gz /usr/share/elasticsearch/data

docker run --rm \
    --volumes-from $(docker-compose ps -q n8n) \
    -v $(pwd)/${BACKUP_DIR}:/backup \
    alpine tar czf /backup/n8n-${TIMESTAMP}.tar.gz /home/node/.n8n

# Backup configuration
tar czf ${BACKUP_DIR}/config-${TIMESTAMP}.tar.gz \
    docker-compose.yml \
    .env \
    nginx/

echo "Backup complete! Files saved in ${BACKUP_DIR}/"
EOF

chmod +x ${DEPLOY_DIR}/scripts/backup.sh

# Create the deployment package
echo -e "${GREEN}Creating deployment package...${NC}"
tar czf ${PACKAGE_NAME} ${DEPLOY_DIR}

# Cleanup
rm -rf ${DEPLOY_DIR}

echo -e "${GREEN}Deployment package created: ${PACKAGE_NAME}${NC}"
echo -e "${BLUE}To deploy on target system:${NC}"
echo "1. Copy ${PACKAGE_NAME} to target system"
echo "2. Extract: tar xzf ${PACKAGE_NAME}"
echo "3. cd astl-deployment"
echo "4. ./install.sh"
