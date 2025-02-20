#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Function to check service health
check_health() {
    echo -e "${BLUE}Checking service health...${NC}"
    
    # Check n8n
    if curl -s http://localhost:5678 > /dev/null; then
        echo -e "${GREEN}✓ n8n is running${NC}"
    else
        echo -e "${RED}✗ n8n is not accessible${NC}"
    fi
    
    # Check Elasticsearch
    if curl -s http://localhost:9200 > /dev/null; then
        echo -e "${GREEN}✓ Elasticsearch is running${NC}"
    else
        echo -e "${RED}✗ Elasticsearch is not accessible${NC}"
    fi
    
    # Check Kibana
    if curl -s http://localhost:5601 > /dev/null; then
        echo -e "${GREEN}✓ Kibana is running${NC}"
    else
        echo -e "${RED}✗ Kibana is not accessible${NC}"
    fi
    
    # Check containers
    echo -e "\n${BLUE}Container Status:${NC}"
    docker-compose ps
}

case "$1" in
    "start")
        echo -e "${BLUE}Starting ASTL...${NC}"
        docker-compose up -d
        sleep 10
        check_health
        ;;
    "stop")
        echo -e "${BLUE}Stopping ASTL...${NC}"
        docker-compose down
        ;;
    "restart")
        echo -e "${BLUE}Restarting ASTL...${NC}"
        docker-compose down
        docker-compose up -d
        sleep 10
        check_health
        ;;
    "status")
        check_health
        ;;
    "logs")
        if [ -z "$2" ]; then
            echo -e "${BLUE}Showing logs for all services...${NC}"
            docker-compose logs --tail=100
        else
            echo -e "${BLUE}Showing logs for $2...${NC}"
            docker-compose logs --tail=100 "$2"
        fi
        ;;
    *)
        echo -e "Usage: $0 {start|stop|restart|status|logs [service]}"
        echo -e "\nExamples:"
        echo -e "  $0 start    - Start all services"
        echo -e "  $0 stop     - Stop all services"
        echo -e "  $0 restart  - Restart all services"
        echo -e "  $0 status   - Check service health"
        echo -e "  $0 logs n8n - Show logs for n8n"
        exit 1
        ;;
esac
