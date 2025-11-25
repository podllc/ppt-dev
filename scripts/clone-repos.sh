#!/bin/bash
# ============================================================================
# Clone PrescriberPoint Repositories
# ============================================================================
# This script clones all required PrescriberPoint repositories into the repos/
# directory. It checks for existing repositories to avoid re-cloning.
# ============================================================================

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

REPOS_DIR="repos"
GITHUB_ORG="PrescriberPoint"

# Array of repositories to clone
# Priority: ppt-agentic first, then epa/case-management/profile
REPOS=(
  "ppt-agentic"
  "microservice-epa"
  "microservice-case-management"
  "microservice-profile"
  "microservice-sam-gateway"
  "ppt-common-csharp"
)

echo -e "${BLUE}============================================================================${NC}"
echo -e "${BLUE}Cloning PrescriberPoint Repositories${NC}"
echo -e "${BLUE}============================================================================${NC}"
echo ""

# Check if repos directory exists
if [ ! -d "$REPOS_DIR" ]; then
  echo -e "${YELLOW}Creating repos directory...${NC}"
  mkdir -p "$REPOS_DIR"
fi

# Check if gh CLI is available
if ! command -v gh &> /dev/null; then
  echo -e "${RED}ERROR: GitHub CLI (gh) is not installed or not in PATH${NC}"
  echo "Please install gh CLI: https://cli.github.com/"
  echo ""
  echo "Alternative: Clone repositories manually using git:"
  for repo in "${REPOS[@]}"; do
    echo "  git clone git@github.com:$GITHUB_ORG/$repo.git $REPOS_DIR/$repo"
  done
  exit 1
fi

# Check if authenticated with GitHub
if ! gh auth status &> /dev/null; then
  echo -e "${RED}ERROR: Not authenticated with GitHub CLI${NC}"
  echo "Please run: gh auth login"
  exit 1
fi

# Clone each repository
for repo in "${REPOS[@]}"; do
  REPO_PATH="$REPOS_DIR/$repo"

  if [ -d "$REPO_PATH" ]; then
    echo -e "${YELLOW}~ Repository $repo already exists, pulling latest...${NC}"
    (cd "$REPO_PATH" && git pull --ff-only 2>/dev/null || echo -e "${YELLOW}  (skipped - local changes or non-ff merge)${NC}")
  else
    echo -e "${GREEN}Cloning $repo...${NC}"
    gh repo clone "$GITHUB_ORG/$repo" "$REPO_PATH"
    echo -e "${GREEN}~ Successfully cloned $repo${NC}"
  fi
  echo ""
done

echo -e "${BLUE}============================================================================${NC}"
echo -e "${GREEN}All repositories cloned successfully!${NC}"
echo -e "${BLUE}============================================================================${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Ensure .env is configured (copy from .env.example if needed)"
echo "2. Run 'make start' or './scripts/start-dev.sh' to start all containers"
echo "3. Open each repository in a separate VS Code window"
echo "4. In each window, run 'Dev Containers: Reopen in Container'"
echo ""
echo -e "${YELLOW}Repository locations:${NC}"
for repo in "${REPOS[@]}"; do
  echo "  $REPOS_DIR/$repo"
done
echo ""
