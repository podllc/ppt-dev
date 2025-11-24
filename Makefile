.PHONY: help start stop restart status logs clean build cli

help: ## Show this help message
	@echo "PrescriberPoint Development Environment"
	@echo ""
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

start: ## Start all development containers
	@./scripts/start-dev.sh

stop: ## Stop all development containers
	@./scripts/stop-dev.sh

restart: ## Restart all development containers
	@docker-compose restart

status: ## Show status of all containers
	@docker-compose ps

logs: ## View logs from all containers
	@docker-compose logs -f

build: ## Build all Docker images
	@docker-compose build

clean: ## Stop and remove all containers and volumes
	@docker-compose down -v
	@echo "All containers and volumes removed"

cli: ## Open a shell in the CLI container
	@docker-compose exec ppt-cli bash
