#!/bin/bash
# ============================================================================
# Setup MCP Server Authentication
# ============================================================================
# Configures Claude Code MCP servers for GitHub and Atlassian/Jira access.
# Both require API tokens set in the .env file.
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

MISSING_TOKENS=0

# Check for GitHub token
if [ -z "$GITHUB_TOKEN" ]; then
    echo -e "${YELLOW}WARNING: GITHUB_TOKEN not set in environment${NC}"
    MISSING_TOKENS=1
fi

# Check for Atlassian credentials
if [ -z "$ATLASSIAN_API_TOKEN" ]; then
    echo -e "${YELLOW}WARNING: ATLASSIAN_API_TOKEN not set in environment${NC}"
    MISSING_TOKENS=1
fi

if [ -z "$ATLASSIAN_USER_EMAIL" ]; then
    echo -e "${YELLOW}WARNING: ATLASSIAN_USER_EMAIL not set in environment${NC}"
    MISSING_TOKENS=1
fi

if [ $MISSING_TOKENS -eq 1 ]; then
    echo ""
    echo -e "${YELLOW}Add missing tokens to your .env file:${NC}"
    echo ""
    echo "  # GitHub (for GitHub MCP server)"
    echo "  GITHUB_TOKEN=ghp_your_token_here"
    echo ""
    echo "  # Atlassian (for Jira/Confluence MCP server)"
    echo "  ATLASSIAN_SITE_NAME=prescriberpoint"
    echo "  ATLASSIAN_USER_EMAIL=your-email@prescriberpoint.com"
    echo "  ATLASSIAN_API_TOKEN=your_atlassian_api_token"
    echo ""
    echo "Get tokens from:"
    echo "  GitHub:    https://github.com/settings/tokens"
    echo "  Atlassian: https://id.atlassian.com/manage-profile/security/api-tokens"
    echo ""
fi

echo ""
echo -e "${BLUE}============================================================================${NC}"
echo -e "${GREEN}MCP server configuration is in .devcache/ppt-dev/.claude.json${NC}"
echo -e "${BLUE}============================================================================${NC}"
echo ""
echo -e "${YELLOW}Notes:${NC}"
echo "  - GitHub MCP: Uses GITHUB_TOKEN from environment"
echo "  - Atlassian MCP: Uses ATLASSIAN_USER_EMAIL and ATLASSIAN_API_TOKEN"
echo ""
echo -e "${YELLOW}Verify with:${NC}  claude mcp list"
echo ""
