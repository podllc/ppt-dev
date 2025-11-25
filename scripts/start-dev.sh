#!/bin/bash
# ============================================================================
# Start PrescriberPoint Development Environment
# ============================================================================
# This script starts all Docker Compose services for the PrescriberPoint
# development environment. It performs pre-flight checks and displays
# service status.
# ============================================================================

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}============================================================================${NC}"
echo -e "${BLUE}Starting PrescriberPoint Development Environment${NC}"
echo -e "${BLUE}============================================================================${NC}"
echo ""

# Check if .env file exists
if [ ! -f ".env" ]; then
  echo -e "${RED}ERROR: .env file not found!${NC}"
  echo -e "${YELLOW}Please copy .env.example to .env and configure your settings:${NC}"
  echo "  cp .env.example .env"
  echo ""
  exit 1
fi

# Check for required environment variables
if ! grep -q "NUGET_AUTH_TOKEN=." .env 2>/dev/null; then
  echo -e "${YELLOW}WARNING: NUGET_AUTH_TOKEN may not be set in .env${NC}"
  echo "Some .NET package restores may fail without a valid GitHub token."
  echo ""
fi

# Clone/update repositories if the script exists
if [ -f "./scripts/clone-repos.sh" ]; then
  echo -e "${GREEN}Checking repositories...${NC}"
  ./scripts/clone-repos.sh
  echo ""
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
  echo -e "${RED}ERROR: Docker is not running${NC}"
  echo "Please start Docker Desktop or the Docker daemon."
  exit 1
fi

echo -e "${GREEN}Starting Docker Compose services with build cache...${NC}"
DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose up -d --build

echo ""
echo -e "${GREEN}Waiting for services to be healthy...${NC}"
sleep 5

# Show container status
echo ""
echo -e "${BLUE}============================================================================${NC}"
echo -e "${GREEN}Development environment started successfully!${NC}"
echo -e "${BLUE}============================================================================${NC}"
echo ""
echo -e "${YELLOW}Service Ports:${NC}"
echo "  SQL Server:              localhost:1433"
echo "  Redis:                   localhost:6379"
echo ""
echo "  Microservice ePA:        http://localhost:5100"
echo "  Case Management:         http://localhost:5200"
echo "  Profile:                 http://localhost:5250"
echo "  SAM Gateway:             http://localhost:5300"
echo "  PPT Agentic:             http://localhost:5400"
echo "  PPT Common:              http://localhost:5500"
echo "  PPT CLI:                 http://localhost:5600"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Open each repository in repos/ in a separate VS Code window"
echo "2. In each window, run 'Dev Containers: Reopen in Container'"
echo "3. Start debugging or development in each container"
echo ""
echo -e "${YELLOW}Useful commands:${NC}"
echo "  View logs:        make logs           (or docker-compose logs -f)"
echo "  Stop services:    make stop           (or docker-compose down)"
echo "  Restart service:  docker-compose restart [service-name]"
echo "  Service status:   make status         (or docker-compose ps)"
echo "  Shell into CLI:   make cli"
echo ""
