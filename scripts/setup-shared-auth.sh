#!/bin/bash
# ============================================================================
# Setup MCP Server Authentication
# ============================================================================
# Configures Claude Code MCP servers for GitHub and Atlassian/Jira access.
# GitHub requires a token in .env; Atlassian uses OAuth via hosted service.
# ============================================================================

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}============================================================================${NC}"
echo -e "${BLUE}Setting up MCP Servers for Claude Code${NC}"
echo -e "${BLUE}============================================================================${NC}"
echo ""

# Check for GitHub token
if [ -z "$GITHUB_TOKEN" ]; then
    echo -e "${YELLOW}WARNING: GITHUB_TOKEN not set in environment${NC}"
    echo ""
    echo -e "${YELLOW}Add to your .env file:${NC}"
    echo ""
    echo "  GITHUB_TOKEN=ghp_your_token_here"
    echo ""
    echo "Get token from: https://github.com/settings/tokens"
    echo "Required scopes: read:packages, repo"
    echo ""
fi

# Add GitHub MCP server
echo -e "${GREEN}Configuring GitHub MCP server...${NC}"
claude mcp add github -- npx -y @modelcontextprotocol/server-github 2>/dev/null || \
    echo -e "  ${YELLOW}(already configured or claude not available)${NC}"

# Add Atlassian MCP server (uses OAuth via hosted service)
echo -e "${GREEN}Configuring Atlassian MCP server (OAuth)...${NC}"
claude mcp add atlassian --type sse --url "https://mcp.atlassian.com/v1/sse" 2>/dev/null || \
    echo -e "  ${YELLOW}(already configured or claude not available)${NC}"

echo ""
echo -e "${BLUE}============================================================================${NC}"
echo -e "${GREEN}MCP server setup complete!${NC}"
echo -e "${BLUE}============================================================================${NC}"
echo ""
echo -e "${YELLOW}Notes:${NC}"
echo "  - GitHub MCP: Uses GITHUB_TOKEN from environment"
echo "  - Atlassian MCP: Uses OAuth (will prompt for login on first use)"
echo ""
echo -e "${YELLOW}Verify with:${NC}  claude mcp list"
echo ""
