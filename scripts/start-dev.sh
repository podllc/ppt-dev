#!/bin/bash
# ============================================================================
# Start PrescriberPoint Development Environment
# ============================================================================

set -e

echo "Starting PrescriberPoint development environment..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo "ERROR: .env file not found!"
    echo "Please copy .env.example to .env and configure your settings:"
    echo "  cp .env.example .env"
    exit 1
fi

# Start all services
docker-compose up -d

echo ""
echo "Development environment started successfully!"
echo ""
echo "Service URLs:"
echo "  SQL Server:              localhost:1433"
echo "  Redis:                   localhost:6379"
echo "  Microservice ePA:        http://localhost:5100"
echo "  Case Management:         http://localhost:5200"
echo "  SAM Gateway:             http://localhost:5300"
echo "  PPT Agentic:             http://localhost:5400"
echo "  PPT Common:              http://localhost:5500"
echo ""
echo "To view logs:"
echo "  docker-compose logs -f"
echo ""
echo "To open a repository in VS Code:"
echo "  1. Open VS Code"
echo "  2. Open the repository folder (e.g., ../microservice-epa)"
echo "  3. Run: Dev Containers: Reopen in Container"
echo ""
