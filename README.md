# PrescriberPoint Development Environment

This repository provides a unified development environment for all PrescriberPoint .NET microservices with shared infrastructure (SQL Server, Redis) and consistent tooling.

## Architecture

- **Single source of truth for configuration** - All shared config in one `.env` file
- **Shared infrastructure** - SQL Server and Redis run once, shared by all projects
- **Independent repositories** - Each project repo remains separate for git operations
- **Multiple debugging sessions** - Open each repo in its own VS Code window with full debugging support
- **.devcache pattern** - Persistent cache directories for VS Code Server, tools, and extensions

## Projects Included

- **microservice-epa** (.NET 9) - Electronic Prior Authorization service
- **microservice-case-management** (.NET 9) - Case Management service
- **microservice-sam-gateway** (.NET 9) - SAM Gateway service
- **ppt-agentic** (.NET 9) - Agentic AI service
- **ppt-common-csharp** (.NET 9) - Shared common library

## Prerequisites

- **Docker** and **Docker Compose** installed
- **VS Code** with the **Dev Containers** extension
- **Git** installed locally

## Quick Start

### 1. Clone this repository

```bash
cd ~/development/prescriberpoint
# ppt-dev directory should already exist
cd ppt-dev
```

### 2. Configure environment

```bash
cp .env.example .env
```

Edit `.env` and configure:
- `CONTAINER_USERNAME` - Your local username (typically `vscode`)
- `MSSQL_SA_PASSWORD` - Strong password for SQL Server
- `GITHUB_TOKEN` - GitHub PAT with package read permissions
- `GITHUB_ACTOR` - Your GitHub username
- Other settings as needed for your services

### 3. Start the development environment

```bash
make start
# or
./scripts/start-dev.sh
```

This starts all Docker Compose services including:
- SQL Server (port 1433)
- Redis (port 6379)
- All five development containers

### 4. Open repositories in VS Code

For each project you want to work on:

1. Open a **new VS Code window**
2. Open the repository folder (e.g., `~/development/prescriberpoint/microservice-epa`)
3. Run command: **Dev Containers: Reopen in Container**
4. Select the appropriate container when prompted
5. VS Code will attach to the running container

Repeat for each project, using separate VS Code windows.

## Development Workflow

### Working with Multiple Services

Since each repository opens in its own VS Code window attached to its own container, you can:

- **Debug multiple services simultaneously** - Each window has full debugging capabilities
- **Run services independently** - Start/stop services as needed
- **View logs separately** - Each window shows logs for its container
- **Use different VS Code settings** - Each project can have custom settings

### Container Communication

All containers are on the same Docker network (`ppt-dev`), so they can communicate using container names:

- From **ppt-agentic**: `http://microservice-epa:5000`
- From **microservice-case-management**: `http://microservice-sam-gateway:5000`
- SQL Server: `sqlserver:1433`
- Redis: `redis:6379`

### Service Ports

| Service | Host Port | Container Port | Description |
|---------|-----------|----------------|-------------|
| sqlserver | 1433 | 1433 | SQL Server |
| redis | 6379 | 6379 | Redis |
| microservice-epa | 5100 | 5000 | ePA API |
| microservice-case-management | 5200 | 5000 | Case Management API |
| microservice-sam-gateway | 5300 | 5000 | SAM Gateway API |
| ppt-agentic | 5400 | 5000 | Agentic API |
| ppt-common-csharp | 5500 | 5000 | Common library (dev) |

### Common Commands

**From the ppt-dev directory:**

```bash
# Start all services
make start

# Stop all services (preserves data)
make stop

# Restart all services
make restart

# View all container logs
make logs

# View specific service logs
docker-compose logs -f microservice-epa

# Check service status
make status

# Open shell in CLI container
make cli

# Stop and remove all containers and volumes
make clean
```

**From within a devcontainer:**

Each project has its own build/test commands:

```bash
# Build the solution
dotnet build

# Run tests
dotnet test

# Format code
dotnet format

# Run Entity Framework migrations (if applicable)
dotnet ef database update
```

## Configuration Management

### Shared Configuration

The `.env` file in this repository is the **single source of truth** for all configuration shared across projects:

- GitHub authentication
- SQL Server credentials
- Redis connection
- Azure configuration
- Auth0 settings
- OpenAI/AI service keys
- And more...

This ensures consistency between local development and Azure production deployments.

### Project-Specific Configuration

Each project repository maintains its own:
- `appsettings.json` and `appsettings.Development.json`
- `.devcontainer/devcontainer.json` settings (in `ppt-dev/.devcontainer/`)
- VS Code extensions and settings
- Build and test configurations
- Git history and branches

### Unified .NET 9 Development Image

All containers use a shared base image (`ppt-dev/Dockerfile`) that includes:
- **.NET 9 SDK** - For all .NET services
- **Node.js 20** - For tooling and scripts
- **SQL Server tools** - For database access
- **Azure CLI** - For Azure operations
- **GitHub CLI** - For GitHub operations
- **Claude Code CLI** - For AI-assisted development
- **Common development tools** - git, vim, nano, jq, etc.

This approach ensures:
- Consistent tooling across all development environments
- Fast container startup (tools pre-installed)
- Ability to work across service boundaries

### Caching Strategy

The development environment uses **host-mounted cache directories** (`.devcache/`) for container home directories. Each service has its own cache subdirectory:

- `.devcache/microservice-epa/` - ePA service cache
- `.devcache/microservice-case-management/` - Case Management cache
- `.devcache/microservice-sam-gateway/` - SAM Gateway cache
- `.devcache/ppt-agentic/` - Agentic service cache
- `.devcache/ppt-common-csharp/` - Common library cache
- `.devcache/ppt-dev/` - CLI container cache
- `.devcache/claude-shared/` - Shared Claude Code auth
- `.devcache/gh-shared/` - Shared GitHub CLI auth

**What gets cached:**
- VS Code Server binaries and extensions (~1-2GB per service)
- Bash history and shell configuration
- .NET tools (dotnet-ef, NSwag, etc.)
- Azure CLI configuration and extensions
- Git configuration

**Benefits:**
- **Fast startup** - Tools and extensions persist across container rebuilds
- **Smaller images** - Heavy dependencies stay in cached volumes, not in Docker images
- **Preserved state** - Bash history, git config, and CLI settings persist between sessions
- **Disk-based caching** - Much faster than downloading/installing on each startup

Each cache directory can grow to 3-4GB but significantly speeds up development workflow.

## Directory Structure

```
ppt-dev/
├── .devcontainer/                    # DevContainer configs for each service
│   ├── microservice-epa/
│   ├── microservice-case-management/
│   ├── microservice-sam-gateway/
│   ├── ppt-agentic/
│   ├── ppt-common-csharp/
│   └── ppt-dev/
├── .devcache/                        # Container home directories (gitignored)
│   ├── microservice-epa/
│   ├── microservice-case-management/
│   ├── microservice-sam-gateway/
│   ├── ppt-agentic/
│   ├── ppt-common-csharp/
│   ├── ppt-dev/
│   ├── claude-shared/
│   └── gh-shared/
├── scripts/
│   ├── start-dev.sh                  # Start development environment
│   └── stop-dev.sh                   # Stop development environment
├── .env.example                      # Template configuration
├── .env                              # Your local configuration (gitignored)
├── .gitignore
├── docker-compose.yml                # Multi-container orchestration
├── Dockerfile                        # Unified .NET 9 development image
├── Makefile                          # Convenient commands
├── ppt-dev.code-workspace            # VS Code workspace file
└── README.md
```

## Debugging

### .NET Services

1. Open repository in VS Code devcontainer
2. Set breakpoints in your code
3. Press F5 or use the Run and Debug panel
4. VS Code will attach to the running process or launch with debugger

For detailed debugging instructions, see each repository's `CLAUDE.md` file.

## Troubleshooting

### Containers won't start

```bash
# Check Docker Compose logs
docker-compose logs

# Ensure .env file exists and is configured
cat .env

# Rebuild containers
docker-compose up -d --build
```

### Can't connect to SQL Server

```bash
# Check if SQL Server is healthy
docker-compose ps sqlserver

# View SQL Server logs
docker-compose logs sqlserver

# Verify connection string in .env matches SQL Server settings
# Default: Server=sqlserver;Database=YourDb;User Id=sa;Password=YourStrong!Passw0rd;TrustServerCertificate=true;
```

### Port conflicts

If you get port binding errors, check for processes using the ports:

```bash
# Linux/WSL
sudo lsof -i :1433
sudo lsof -i :5100

# Or stop conflicting containers
docker ps
docker stop <container-id>
```

### VS Code can't find devcontainer

Ensure you:
1. Opened the repository folder (e.g., `~/development/prescriberpoint/microservice-epa`), not the root `ppt-dev` folder
2. Have the Dev Containers extension installed
3. Docker is running
4. Containers are started with `make start`

### Cache directories taking too much space

Each service's `.devcache` directory can grow to 3-4GB. To clean:

```bash
# Remove all cache directories (will need to reinstall VS Code extensions)
rm -rf .devcache/

# Or remove specific service cache
rm -rf .devcache/microservice-epa/
```

## Shared Services

### SQL Server

- **Image**: `mcr.microsoft.com/mssql/server:2022-latest`
- **Port**: 1433
- **User**: sa
- **Password**: Configured in `.env` as `MSSQL_SA_PASSWORD`

Connect from any service using:
```
Server=sqlserver;Database=YourDb;User Id=sa;Password=${MSSQL_SA_PASSWORD};TrustServerCertificate=true;
```

### Redis

- **Image**: `redis:7-alpine`
- **Port**: 6379
- **Connection**: `redis:6379`

Connect from any service using the connection string in `.env`.

## Development Best Practices

1. **Always run tests before committing**: `dotnet test`
2. **Format code**: `dotnet format`
3. **Keep .env.example updated** with new configuration keys
4. **Use feature branches** for development
5. **Keep services focused** - each microservice should have a single responsibility

## VS Code Workspace

The `ppt-dev.code-workspace` file allows you to open all repositories in a single VS Code workspace. This is useful for:
- Searching across all repositories
- Global find/replace
- Overview of all projects

To use:
```bash
code ppt-dev.code-workspace
```

## CLI Container

The `ppt-dev` container provides a unified environment for cross-repository work:

**Option 1: Shell access (quick commands)**
```bash
make cli
```

**Option 2: VS Code DevContainer (full IDE experience)**
1. Open `ppt-dev` directory in VS Code
2. Press `Ctrl+Shift+P` / `Cmd+Shift+P`
3. Select "Dev Containers: Reopen in Container"
4. Choose "PPT CLI"

Inside the CLI container:
- Access all repos from parent directories
- Run `az login` for Azure CLI
- Run `gh auth login` for GitHub CLI
- Run `claude` for Claude Code CLI
- All tools available: .NET SDK, Azure CLI, GitHub CLI, etc.

## Contributing

This repository tracks the shared development infrastructure. Changes to individual projects should be made in their respective repositories.

To contribute to this infrastructure:

1. Create a feature branch
2. Make your changes
3. Test with all projects
4. Submit a pull request

## License

Copyright (c) 2024 PrescriberPoint. All rights reserved.

## Support

For issues with:
- **This development environment**: Contact the DevOps team
- **Individual projects**: Open issues in the respective project repositories
