#!/bin/bash
# Helper script for plugin utilities

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
  echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
  echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
  echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
  echo -e "${RED}❌ $1${NC}"
}

# Example utility functions
get_plugin_root() {
  echo "${CLAUDE_PLUGIN_ROOT}"
}

check_dependencies() {
  log_info "Checking dependencies..."
  # Add dependency checks here
  log_success "All dependencies satisfied"
}

# Export functions for use in other scripts
export -f log_info log_success log_warning log_error
