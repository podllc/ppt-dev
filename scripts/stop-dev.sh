#!/bin/bash
# ============================================================================
# Stop PrescriberPoint Development Environment
# ============================================================================
# This script stops all Docker Compose services for the PrescriberPoint
# development environment while preserving data volumes.
# ============================================================================

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}============================================================================${NC}"
echo -e "${BLUE}Stopping PrescriberPoint Development Environment${NC}"
echo -e "${BLUE}============================================================================${NC}"
echo ""

echo -e "${YELLOW}Stopping Docker Compose services...${NC}"
docker-compose down

echo ""
echo -e "${GREEN}~ All services stopped${NC}"
echo ""
echo -e "${YELLOW}Note:${NC} Data volumes are preserved. To remove volumes, run:"
echo "  docker-compose down -v"
echo "  or: make clean"
echo ""
echo -e "${YELLOW}To start again:${NC}"
echo "  make start"
echo "  or: ./scripts/start-dev.sh"
echo ""
