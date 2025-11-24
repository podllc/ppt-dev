#!/bin/bash
# ============================================================================
# Stop PrescriberPoint Development Environment
# ============================================================================

set -e

echo "Stopping PrescriberPoint development environment..."

docker-compose stop

echo "Development environment stopped successfully!"
echo ""
echo "To start again:"
echo "  ./scripts/start-dev.sh"
echo ""
echo "To remove all containers and volumes:"
echo "  docker-compose down -v"
echo ""
