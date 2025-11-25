# Claude Code Instructions for PrescriberPoint Development Environment

## Overview

This is the **PrescriberPoint Development Environment** repository. It provides shared infrastructure and configuration for all PPT microservices and projects.

**IMPORTANT**: This repository contains only the development environment setup. Do NOT make changes to code in the `repos/` directory - those are separate git repositories with their own history and should be worked on individually.

## Repository Purpose

This repository manages:
- Shared Docker Compose configuration
- DevContainer settings for each service
- Shared environment variables (.env)
- Development setup scripts
- Documentation for the unified development workflow

## Making Changes

### Changes to Development Infrastructure

When making changes to this repository:

1. **Configuration changes**: Edit `.env.example`, `docker-compose.yml`, or devcontainer configs
2. **Script changes**: Update helper scripts in `scripts/`
3. **Documentation**: Update README.md or this file

### Changes to Project Code

**DO NOT** make changes to code in `repos/` from this repository context. Instead:

1. Open the specific project repository in its own VS Code window
2. Attach to its devcontainer
3. Make changes within that repository's context
4. Commit and push from within that repository

## Key Files

- `.env.example` - Template for shared configuration (single source of truth)
- `docker-compose.yml` - Orchestrates all development containers and shared services
- `.devcontainer/*/devcontainer.json` - DevContainer configs for each service
- `scripts/clone-repos.sh` - Clones all project repositories
- `scripts/start-dev.sh` - Starts all containers
- `scripts/stop-dev.sh` - Stops all containers
- `Makefile` - Convenient commands for common operations

## Shared Configuration

The `.env` file is the single source of truth for:
- GitHub authentication (GITHUB_TOKEN)
- Atlassian/Jira API keys (ATLASSIAN_API_TOKEN)
- Database credentials (SQL Server)
- Azure configuration (App Configuration, Storage, Service Bus)
- Auth0 settings
- All other shared configuration

This ensures consistency between local development and Azure production deployments.

## Development Modes

### Multi-Container Mode (Recommended)

Best for working on multiple services simultaneously with full isolation:

```bash
make start          # Start all containers
make cli            # Shell into CLI container
make stop           # Stop all containers
```

Each service runs in its own container with its own devcontainer configuration.

### CLI Container (ppt-dev)

Isolated environment for CLI operations and cross-repository work:

**Option 1: Shell access (quick commands)**
```bash
make cli
```

**Option 2: VS Code DevContainer (full IDE experience)**
1. Open this repository in VS Code
2. Press `Ctrl+Shift+P` / `Cmd+Shift+P`
3. Select "Dev Containers: Reopen in Container"
4. Choose "PPT DEV"

Inside the CLI container:
- Run `az login` for Azure CLI
- Run `gh auth login` for GitHub CLI
- Run `claude` for Claude Code CLI
- Access all repos in `/workspace/repos/` (starting directory)
- Access parent ppt-dev repo at `/workspace/` (for git commits)
- Credentials isolated from host in `.devcache/ppt-dev/`
- Full VS Code extensions for .NET development

## Project Structure

```
ppt-dev/
├── repos/                              # Cloned project repositories
│   ├── ppt-agentic/                    # AI Agent orchestration service
│   ├── microservice-epa/               # Electronic Prior Authorization
│   ├── microservice-case-management/   # Case Management service
│   ├── microservice-profile/           # User Profile service
│   ├── microservice-sam-gateway/       # SAM Gateway service
│   └── ppt-common-csharp/              # Shared .NET libraries
├── .devcache/                          # Container home directories
│   ├── ppt-agentic/                    # Agentic container cache
│   ├── microservice-epa/               # ePA container cache
│   ├── microservice-case-management/   # Case Management cache
│   ├── microservice-profile/           # Profile container cache
│   ├── microservice-sam-gateway/       # SAM Gateway cache
│   ├── ppt-common-csharp/              # Common library cache
│   ├── ppt-dev/                        # CLI container cache
│   ├── claude-shared/                  # Shared Claude auth
│   └── gh-shared/                      # Shared GitHub CLI auth
├── docker-compose.yml                  # Multi-container orchestration
├── Dockerfile                          # Development container image
└── Makefile                            # Convenient commands
```

## Repositories

### ppt-agentic
- **Type**: .NET 9 Web API + Console App
- **Purpose**: AI Agent orchestration and workflow automation
- **Port**: 5100

### microservice-epa
- **Type**: .NET 9 Web API
- **Purpose**: Electronic Prior Authorization processing
- **Port**: 5200

### microservice-case-management
- **Type**: .NET 9 Web API
- **Purpose**: Case management and tracking
- **Port**: 5300

### microservice-profile
- **Type**: .NET 9 Web API
- **Purpose**: User profile management
- **Port**: 5250

### microservice-sam-gateway
- **Type**: .NET 9 Web API
- **Purpose**: SAM (Samples) Gateway integration
- **Port**: 5400

### ppt-common-csharp
- **Type**: .NET Class Libraries
- **Purpose**: Shared code, models, and utilities
- **Port**: N/A (library only)

## Shared Services

### SQL Server
- **Port**: 1433
- **User**: sa (configured in .env)
- **Databases**: EpaDb, CaseManagementDb, PPTAgentic, SamGatewayDb

### Redis
- **Port**: 6379
- **Purpose**: Caching and session state

### Azurite (Azure Storage Emulator)
- **Ports**: 10000 (Blob), 10001 (Queue), 10002 (Table)
- **Purpose**: Local Azure Storage emulation for blobs, queues, and tables
- **Account**: devstoreaccount1 (default Azurite well-known account)

## Development Workflow

This repository follows the standard PrescriberPoint git workflow:

1. Create feature branches for changes linked to Jira tickets
2. Never commit directly to `main`
3. Use Jira tickets to track work (accessible via Atlassian MCP)
4. Create pull requests for review

## Testing Changes

When making changes to this repository, test by:

1. Stopping current development environment: `make stop`
2. Rebuilding containers: `make build`
3. Starting environment: `make start`
4. Opening each project in VS Code and verifying it works
5. Testing that shared infrastructure (SQL Server, Redis, networking) works correctly

## Company Standards

- **Company**: PrescriberPoint
- **Product**: PPT Development Environment
- All documentation should reference PrescriberPoint as the company name

## MCP Servers

### GitHub MCP
- Provides access to GitHub repositories, issues, and PRs
- Uses `GITHUB_TOKEN` from environment

### Atlassian MCP
- Provides access to Jira issues and Confluence pages
- Uses OAuth via Atlassian's hosted service (https://mcp.atlassian.com/v1/sse)
- Will prompt for browser login on first use
- Site: prescriberpoint.atlassian.net

**IMPORTANT - Atlassian Cloud ID Configuration:**
When using Atlassian MCP tools (getJiraIssue, searchJiraIssuesUsingJql, etc.), you MUST use the correct cloud ID.
- **DO NOT** use `prescriberpoint.atlassian.net` as the cloudId parameter - it resolves incorrectly
- **ALWAYS** use the UUID cloud ID: `7c906d30-c1f8-4539-97a4-a5dec982b02e`
- If you get "Cloud id isn't explicitly granted" errors, call `getAccessibleAtlassianResources` first to verify the correct cloud ID
- The AA project (AI Agents) is in this Atlassian instance

### SonarQube MCP
- Provides access to SonarQube code quality analysis
- Examine PR issues, security hotspots, and code smells
- Uses `SONAR_TOKEN` and `SONARQUBE_URL` from environment
- Server: https://sonarqube.rnd.ontherapy.dev
- Runs as a Docker container in docker-compose (`sonarqube-mcp` service)
- Connects via Streamable HTTP at `http://sonarqube-mcp:8080/mcp`

**Available tools:**
- Get issues by severity, type, or status
- Review security hotspots
- Analyze branches and PRs
- Check quality gate status
- View source code with issues highlighted

## Shared Authentication

### Claude Code
- Configuration stored in `.devcache/ppt-dev/.claude.json`
- MCP servers configured for GitHub, Atlassian, and SonarQube access

### GitHub CLI
- Shared across all containers via `/home/gh-shared/`
- Run `gh auth login` once in any container
- Authentication available in all containers

## Cross-Repository Workflows

Each repository has its own `CLAUDE.md` file with project-specific instructions:

- **repos/ppt-agentic/CLAUDE.md** - AI Agent service instructions
- **repos/microservice-epa/CLAUDE.md** - ePA service instructions
- **repos/microservice-case-management/CLAUDE.md** - Case Management instructions
- **repos/microservice-profile/CLAUDE.md** - Profile service instructions

**IMPORTANT**: When working on code within a specific repository, follow the instructions in that repository's CLAUDE.md file.

## Useful Commands

```bash
# Setup
make clone              # Clone all repositories
make mcp-setup          # Configure MCP servers (shows token requirements)

# Multi-container mode
make start              # Start all containers
make stop               # Stop all containers
make restart            # Restart all containers
make status             # Show container status
make logs               # View logs from all containers

# CLI operations
make cli                # Shell into CLI container

# Individual service logs
make logs-epa           # ePA service logs
make logs-cm            # Case Management logs
make logs-agentic       # Agentic service logs
make logs-sql           # SQL Server logs
make logs-redis         # Redis logs
make logs-azurite       # Azurite storage emulator logs

# Database access
make db-shell           # SQL Server shell
make redis-shell        # Redis CLI

# Maintenance
make build              # Rebuild Docker images
make clean              # Stop all containers and remove volumes
```

## Azure Resources

The development environment connects to these Azure resources (via .env):

- **Azure App Configuration**: ppt-appconfig.azconfig.io
- **Azure Key Vault**: ppt-kv-preview
- **Azure Subscription**: PPT Production (configured via AZURE_SUBSCRIPTION_ID)

Ensure you're logged in with `az login` and have appropriate permissions.
