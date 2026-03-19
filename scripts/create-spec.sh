#!/bin/bash

# SPEC Creation Script
# Creates a new SPEC directory with 3-file structure based on MoAI methodology

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get plugin root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SPEC_TEMPLATE_DIR="${PLUGIN_ROOT}/scripts"

# Find project root (look for package.json, git root, or use plugin parent dir)
if [ -f "$(cd "${PLUGIN_ROOT}/.." && pwd)/package.json" ]; then
    PROJECT_ROOT="$(cd "${PLUGIN_ROOT}/.." && pwd)"
elif [ -d "$(cd "${PLUGIN_ROOT}/../.." && pwd)/.git" ]; then
    PROJECT_ROOT="$(cd "${PLUGIN_ROOT}/../.." && pwd)"
else
    PROJECT_ROOT="$(cd "${PLUGIN_ROOT}/.." && pwd)"
fi

SPECS_DIR="${PROJECT_ROOT}/docs/specs"

# Create specs directory if it doesn't exist
mkdir -p "$SPECS_DIR"

# Function to create URL-friendly slug
create_slug() {
    local input="$1"
    # Convert to lowercase
    input=$(echo "$input" | tr '[:upper:]' '[:lower:]')
    # Replace spaces with hyphens
    input=$(echo "$input" | tr ' ' '-')
    # Remove special characters except hyphens
    input=$(echo "$input" | sed 's/[^a-z0-9-]//g')
    # Remove multiple consecutive hyphens
    input=$(echo "$input" | sed 's/-\+/-/g')
    # Remove leading/trailing hyphens
    input=$(echo "$input" | sed 's/^-//;s/-$//')
    echo "$input"
}

# Function to replace template variables
replace_template_vars() {
    local template_file="$1"
    local feature_name="$2"
    local feature_slug="$3"
    local description="$4"
    local date=$(date +%Y-%m-%d)

    sed -e "s/{{FEATURE_NAME}}/${feature_name}/g" \
        -e "s/{{FEATURE_SLUG}}/${feature_slug}/g" \
        -e "s/{{DESCRIPTION}}/${description}/g" \
        -e "s/{{DATE}}/${date}/g" \
        "$template_file"
}

# Main script
echo -e "${BLUE}=== SPEC 생성 도구 ===${NC}"
echo ""

# Check if arguments provided
if [ $# -ge 1 ]; then
    feature_name="$1"
    shift
    description="$*"
else
    # Prompt for feature name
    read -p "${BLUE}피처 이름 (영어, kebab-case):${NC} " feature_name
fi

# Validate feature name format (kebab-case)
if ! [[ "$feature_name" =~ ^[a-z0-9-]+$ ]]; then
    echo -e "${RED}오류: 피처 이름은 소문자, 숫자, 하이픈만 사용할 수 있습니다 (kebab-case).${NC}"
    exit 1
fi

# Prompt for description if not provided
if [ -z "$description" ]; then
    read -p "${BLUE}피처 설명 (간단한 개요):${NC} " description
fi

# Create feature directory
feature_dir="${SPECS_DIR}/${feature_name}"
if [ -d "$feature_dir" ]; then
    echo -e "${YELLOW}경고: '${feature_name}' 스펙이 이미 존재합니다.${NC}"
    read -p "계속 진행하시겠습니까? (기존 파일을 덮어씁니다) [y/N]: " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}취소되었습니다.${NC}"
        exit 0
    fi
else
    mkdir -p "$feature_dir"
fi

# Create files from templates
echo -e "${GREEN}파일 생성 중...${NC}"

# spec.md
replace_template_vars "${SPEC_TEMPLATE_DIR}/spec-template.md" "$feature_name" "$feature_name" "$description" > "${feature_dir}/spec.md"

# plan.md
replace_template_vars "${SPEC_TEMPLATE_DIR}/plan-template.md" "$feature_name" "$feature_name" "$description" > "${feature_dir}/plan.md"

# acceptance.md
replace_template_vars "${SPEC_TEMPLATE_DIR}/acceptance-template.md" "$feature_name" "$feature_name" "$description" > "${feature_dir}/acceptance.md"

# CHANGELOG.md
cat > "${feature_dir}/CHANGELOG.md" << EOF
# Change Log

All notable changes to the ${feature_name} specification will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - $(date +%Y-%m-%d)

### Added
- Initial SPEC creation
- ${description}

**Status**: DRAFT
**Reason**: Initial requirements gathering
EOF

echo ""
echo -e "${GREEN}✅ SPEC이 성공적으로 생성되었습니다!${NC}"
echo ""
echo -e "${BLUE}생성된 파일:${NC}"
echo -e "  ${feature_dir}/spec.md         - EARS 형식 요구사항"
echo -e "  ${feature_dir}/plan.md         - 구현 계획"
echo -e "  ${feature_dir}/acceptance.md   - 인수 기준 (Given/When/Then)"
echo -e "  ${feature_dir}/CHANGELOG.md    - 변경 이력"
echo ""
echo -e "${YELLOW}다음 단계:${NC}"
echo "  1. spec.md 파일을 열고 EARS 형식으로 요구사항 정의"
echo "  2. plan.md 파일에 구현 계획 작성"
echo "  3. acceptance.md 파일에 테스트 시나리오 작성"
echo "  4. 요구사항이 확정되면 상태를 DRAFT → ACTIVE로 변경"
echo ""
echo -e "${BLUE}도움말:${NC}"
echo "  - EARS 형식: Ubiquitous, Event-driven, State-driven, Unwanted, Optional"
echo "  - Given/When/Then: 테스트 가능한 명확한 기준"
echo "  - /spec-update: 요구사항 변경 시 CHANGELOG 자동 업데이트"
echo ""
