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
