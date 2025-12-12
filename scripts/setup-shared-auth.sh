#!/bin/bash
# ============================================================================
# Setup MCP Server Authentication
# ============================================================================
# Configures Claude Code MCP servers for GitHub and Atlassian/Jira access.
# GitHub uses session-based auth via `gh auth login`; Atlassian uses OAuth.
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

# Check for GitHub CLI authentication
if ! gh auth status &>/dev/null; then
    echo -e "${YELLOW}WARNING: Not logged in to GitHub CLI${NC}"
    echo ""
    echo -e "${YELLOW}Run the following command to authenticate:${NC}"
    echo ""
    echo "  gh auth login"
    echo ""
    echo "This will open a browser for OAuth authentication."
    echo "The session token includes read:packages scope for GitHub Packages."
    echo ""
else
    echo -e "${GREEN}✓ GitHub CLI authenticated${NC}"
    # Show current auth status
    gh auth status 2>&1 | head -5
    echo ""
fi

echo ""
echo -e "${BLUE}============================================================================${NC}"
echo -e "${GREEN}MCP server configuration is in .devcache/ppt-dev/.claude.json${NC}"
echo -e "${BLUE}============================================================================${NC}"
echo ""
echo -e "${YELLOW}Notes:${NC}"
echo "  - GitHub MCP: Uses \$(gh auth token) for session-based auth"
echo "  - Atlassian MCP: Uses OAuth (will prompt for browser login on first use)"
echo ""
echo -e "${YELLOW}For npm packages:${NC}"
echo "  The GitHub session token includes read:packages scope."
echo "  Configure .npmrc to use: //npm.pkg.github.com/:_authToken=\$(gh auth token)"
echo ""
echo -e "${YELLOW}For NuGet packages:${NC}"
echo "  export NUGET_AUTH_TOKEN=\$(gh auth token)"
echo ""
echo -e "${YELLOW}Verify with:${NC}  claude mcp list"
echo ""
