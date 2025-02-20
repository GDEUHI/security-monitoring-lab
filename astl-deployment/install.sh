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
