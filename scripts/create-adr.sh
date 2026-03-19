#!/bin/bash
# ADR (Architecture Decision Record) Helper Script
# This script helps create new ADR files with proper numbering and structure

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
ADR_DIR="docs/ADR"
TEMPLATE_FILE="${CLAUDE_PLUGIN_ROOT}/scripts/adr-template.md"

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to get next ADR number
get_next_adr_number() {
    local adr_dir="$1"

    if [ ! -d "$adr_dir" ]; then
        echo "001"
        return
    fi

    # Find the highest numbered ADR
    local highest_number=$(find "$adr_dir" -name "ADR-*.md" -type f | \
        sed -E 's/.*ADR-([0-9]+).*/\1/' | \
        sort -n | \
        tail -n 1)

    if [ -z "$highest_number" ]; then
        echo "001"
    else
        # Increment and pad with zeros
        local next_number=$((10#$highest_number + 1))
        printf "%03d" $next_number
    fi
}

# Function to create slug from title
create_slug() {
    local title="$1"
    # Convert to lowercase, replace spaces with hyphens, remove special chars
    echo "$title" | \
        tr '[:upper:]' '[:lower:]' | \
        tr ' ' '-' | \
        sed -E 's/[^a-z0-9-]+//g' | \
        sed -E 's/-+/-/g' | \
        sed -E 's/^-+|-+$//g'
}

# Function to validate ADR directory
validate_adr_dir() {
    local project_root="$1"

    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_warning "Not in a git repository. ADRs work best in version controlled projects."
        return 0
    fi

    return 0
}

# Main function
main() {
    # Check if template exists
    if [ ! -f "$TEMPLATE_FILE" ]; then
        print_error "Template file not found at: $TEMPLATE_FILE"
        exit 1
    fi

    # Determine project root (current directory or git root)
    local project_root="$(git rev-parse --show-toplevel 2>/dev/null || echo '.')"
    local adr_path="$project_root/$ADR_DIR"

    # Validate and create directory if needed
    if [ ! -d "$adr_path" ]; then
        print_info "Creating ADR directory at: $adr_path"
        mkdir -p "$adr_path"
    fi

    # Get next ADR number
    local adr_number=$(get_next_adr_number "$adr_path")
    print_info "Next ADR number: $adr_number"

    # Prompt for ADR title
    echo ""
    read -p "Enter ADR title: " adr_title

    if [ -z "$adr_title" ]; then
        print_error "Title cannot be empty"
        exit 1
    fi

    # Create slug
    local adr_slug=$(create_slug "$adr_title")
    local filename="ADR-$adr_number-$adr_slug.md"
    local filepath="$adr_path/$filename"

    # Check if file already exists
    if [ -f "$filepath" ]; then
        print_error "File already exists: $filepath"
        exit 1
    fi

    # Get current date
    local current_date=$(date +"%Y-%m-%d")

    # Read template and replace variables
    local content=$(cat "$TEMPLATE_FILE")
    content="${content//{{ADR_NUMBER}}/$adr_number}"
    content="${content//{{ADR_TITLE}}/$adr_title"
    content="${content//{{ADR_DATE}}/$current_date}"

    # Write to file
    echo "$content" > "$filepath"

    print_info "ADR created successfully: $filename"
    echo ""
    echo "Location: $filepath"
    echo ""
    echo "Next steps:"
    echo "  1. Edit the ADR file to add your decision details"
    echo "  2. Commit the ADR to your repository"
    echo "  3. Share with your team if needed"
    echo ""
}

# Run main function
main "$@"
