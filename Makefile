# ============================================================================
# PrescriberPoint Development Environment - Makefile
# ============================================================================
# Convenient commands for managing the development environment
# ============================================================================

.PHONY: help clone start stop restart logs status cli clean build mcp-setup

# Default target - show help
help:
	@echo "PrescriberPoint Development Environment - Make Commands"
	@echo ""
	@echo "Setup:"
	@echo "  make clone              Clone all PPT repositories to repos/"
	@echo "  make mcp-setup          Configure MCP servers (GitHub, Atlassian)"
	@echo ""
	@echo "Development:"
	@echo "  make start              Start multi-container development environment"
	@echo "  make stop               Stop all containers"
	@echo "  make restart            Restart all containers"
	@echo "  make build              Build all Docker images"
	@echo ""
	@echo "Monitoring:"
	@echo "  make logs               View logs from all containers"
	@echo "  make status             Show status of all containers"
	@echo "  make cli                Shell into the CLI container"
	@echo ""
	@echo "Maintenance:"
	@echo "  make clean              Stop all containers and remove volumes"
	@echo ""
	@echo "Repository Locations (after clone):"
	@echo "  repos/ppt-agentic"
	@echo "  repos/microservice-epa"
	@echo "  repos/microservice-case-management"
	@echo "  repos/microservice-profile"
	@echo "  repos/microservice-sam-gateway"
	@echo "  repos/ppt-common-csharp"
	@echo ""

# ============================================================================
# Setup
# ============================================================================

clone:
	@./scripts/clone-repos.sh

mcp-setup:
	@./scripts/setup-shared-auth.sh

# ============================================================================
# Development
# ============================================================================

start:
	@./scripts/start-dev.sh

stop:
	@./scripts/stop-dev.sh

restart: stop start

build:
	@echo "Building Docker images..."
	@DOCKER_BUILDKIT=1 docker-compose build

# ============================================================================
# Monitoring
# ============================================================================

logs:
	@docker-compose logs -f

status:
	@docker-compose ps

cli:
	@docker exec -it ppt-dev bash

# ============================================================================
# Individual Service Logs
# ============================================================================

logs-sql:
	@docker-compose logs -f sqlserver

logs-redis:
	@docker-compose logs -f redis

logs-azurite:
	@docker-compose logs -f azurite

logs-epa:
	@docker-compose logs -f microservice-epa

logs-cm:
	@docker-compose logs -f microservice-case-management

logs-agentic:
	@docker-compose logs -f ppt-agentic

# ============================================================================
# Maintenance
# ============================================================================

clean:
	@echo "Stopping all containers and removing volumes..."
	@docker-compose down -v 2>/dev/null || true
	@echo "Cleanup complete"

# ============================================================================
# Database Operations
# ============================================================================

db-shell:
	@docker exec -it ppt-sqlserver /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$(shell grep MSSQL_SA_PASSWORD .env | cut -d '=' -f2)" -C

redis-shell:
	@docker exec -it ppt-redis redis-cli
