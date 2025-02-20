#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Function to check if Docker is running
check_docker() {
    if ! docker info >/dev/null 2>&1; then
        echo -e "${RED}Docker is not running. Please start Docker first.${NC}"
        exit 1
    fi
}

# Function to check service health
check_service_health() {
    local service=$1
    local port=$2
    local max_attempts=30
    local attempt=1

    echo -n "Checking $service... "
    while [ $attempt -le $max_attempts ]; do
        if curl -s "http://localhost:$port" >/dev/null; then
            echo -e "${GREEN}OK${NC}"
            return 0
        fi
        sleep 2
        attempt=$((attempt + 1))
    done
    echo -e "${RED}Failed${NC}"
    return 1
}

# Start the lab
start() {
    check_docker
    echo "Starting ASTL..."
    docker-compose up -d
    
    echo "Checking service health..."
    check_service_health "n8n" "5678"
    check_service_health "Elasticsearch" "9200"
    check_service_health "Kibana" "5601"
    check_service_health "Grafana" "3000"
    check_service_health "Prometheus" "9090"
    
    echo -e "\nContainer Status:"
    docker-compose ps
}

# Stop the lab
stop() {
    echo "Stopping ASTL..."
    docker-compose down
}

# Restart the lab
restart() {
    stop
    start
}

# Show status
status() {
    echo "ASTL Status:"
    docker-compose ps
}

# Show logs
logs() {
    docker-compose logs --tail=100 -f
}

# Run security scan
scan() {
    echo "Running security scan..."
    docker-compose exec nuclei nuclei -u http://localhost
    docker-compose exec zap zap-baseline.py -t http://localhost
}

# Main
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        status
        ;;
    logs)
        logs
        ;;
    scan)
        scan
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status|logs|scan}"
        exit 1
esac

exit 0
