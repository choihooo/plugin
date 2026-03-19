#!/bin/bash
# TRUST 5 Quality Check Script
# MoAI 기반 품질 검증 스크립트

set -euo pipefail

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 기본값
PHASE="sync"
VERBOSE=false
AUTO_FIX=false
SPECIFIC_CHECK=""
TARGET_PATH="."

# 인자 파싱
while [[ $# -gt 0 ]]; do
  case $1 in
    --phase)
      PHASE="$2"
      shift 2
      ;;
    --verbose)
      VERBOSE=true
      shift
      ;;
    --fix)
      AUTO_FIX=true
      shift
      ;;
    --tested|--readable|--unified|--secured|--trackable)
      SPECIFIC_CHECK="${1#--}"
      shift
      ;;
    --config)
      CONFIG_FILE="$2"
      shift 2
      ;;
    *)
      TARGET_PATH="$1"
      shift
      ;;
  esac
done

# 설정 로드
load_config() {
  if [ -f ".trust.yaml" ]; then
    echo "📋 Loading .trust.yaml..."
    # yaml 파싱은 간단하게 grep으로 처리
    MIN_COVERAGE=$(grep "min_coverage:" .trust.yaml | awk '{print $2}' || echo "85")
  else
    MIN_COVERAGE=85
  fi
}

# 헬퍼 함수
print_section() {
  echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
  echo -e "${BLUE}$1${NC}"
  echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_result() {
  local status=$1
  local message=$2
  local details=$3

  case $status in
    "PASS")
      echo -e "${GREEN}✅ $message: PASS${NC}"
      ;;
    "WARN")
      echo -e "${YELLOW}⚠️  $message: WARN${NC}"
      ;;
    "FAIL")
      echo -e "${RED}❌ $message: FAIL${NC}"
      ;;
  esac

  if [ -n "$details" ] && [ "$VERBOSE" = true ]; then
    echo "$details"
  fi
}

# 프로젝트 타입 감지
detect_project_type() {
  if [ -f "package.json" ]; then
    echo "node"
  elif [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
    echo "python"
  elif [ -f "go.mod" ]; then
    echo "go"
  else
    echo "unknown"
  fi
}

# Tested 검증
check_tested() {
  print_section "Tested (테스트 완료)"

  local project_type=$(detect_project_type)
  local coverage=0
  local result=""

  case $project_type in
    node)
      if grep -q '"jest"' package.json || grep -q '"vitest"' package.json; then
        echo "🔍 Running tests with coverage..."
        if npm run test -- --coverage --watchAll=false > /tmp/test-output.txt 2>&1; then
          coverage=$(grep -oP 'All files[^%]*\K\d+(?=%)' /tmp/test-output.txt | head -1 || echo "0")
          result=$(cat /tmp/test-output.txt)
        else
          coverage=0
          result="Test execution failed"
        fi
      else
        echo "⚠️  No test framework found"
        return 0
      fi
      ;;
    python)
      if command -v pytest &> /dev/null; then
        echo "🔍 Running pytest with coverage..."
        if pytest --cov=src --cov-report=term-missing --cov-report=json > /tmp/test-output.txt 2>&1; then
          coverage=$(python3 -c "import json; print(int(json.load(open('/tmp/coverage.json'))['totals']['percent_covered']))" 2>/dev/null || echo "0")
          result=$(cat /tmp/test-output.txt)
        else
          coverage=0
          result="Test execution failed"
        fi
      else
        echo "⚠️  pytest not found"
        return 0
      fi
      ;;
    *)
      echo "⚠️  Unsupported project type for testing"
      return 0
      ;;
  esac

  if [ "$coverage" -ge "$MIN_COVERAGE" ]; then
    print_result "PASS" "Tested" "($coverage% coverage, required: $MIN_COVERAGE%)"
    return 0
  elif [ "$coverage" -ge 70 ]; then
    print_result "WARN" "Tested" "($coverage% coverage, required: $MIN_COVERAGE%)"
    return 1
  else
    print_result "FAIL" "Tested" "($coverage% coverage, required: $MIN_COVERAGE%)\n$result"
    return 2
  fi
}

# Readable 검증
check_readable() {
  print_section "Readable (가독성)"

  local project_type=$(detect_project_type)
  local errors=0
  local result=""

  case $project_type in
    node)
      if grep -q '"eslint"' package.json; then
        echo "🔍 Running ESLint..."
        if npm run lint > /tmp/lint-output.txt 2>&1; then
          errors=0
          result="No lint errors"
        else
          errors=$(grep -c "error" /tmp/lint-output.txt || echo "1")
          result=$(cat /tmp/lint-output.txt)
        fi
      else
        echo "⚠️  ESLint not found"
        return 0
      fi
      ;;
    python)
      if command -v ruff &> /dev/null; then
        echo "🔍 Running ruff..."
        if ruff check src/ > /tmp/lint-output.txt 2>&1; then
          errors=0
          result="No lint errors"
        else
          errors=$(ruff check src/ --output-format=json | jq '.length' 2>/dev/null || echo "1")
          result=$(cat /tmp/lint-output.txt)
        fi
      elif command -v flake8 &> /dev/null; then
        echo "🔍 Running flake8..."
        if flake8 src/ > /tmp/lint-output.txt 2>&1; then
          errors=0
          result="No lint errors"
        else
          errors=$(wc -l < /tmp/lint-output.txt)
          result=$(cat /tmp/lint-output.txt)
        fi
      else
        echo "⚠️  No linter found"
        return 0
      fi
      ;;
    *)
      echo "⚠️  Unsupported project type for linting"
      return 0
      ;;
  esac

  if [ "$errors" -eq 0 ]; then
    print_result "PASS" "Readable" "(0 errors)"
    return 0
  elif [ "$errors" -le 10 ]; then
    print_result "WARN" "Readable" "(0 errors, $errors warnings)"
    return 1
  else
    print_result "FAIL" "Readable" "($errors errors)\n$result"
    return 2
  fi
}

# Unified 검증
check_unified() {
  print_section "Unified (통일성)"

  local project_type=$(detect_project_type)
  local issues=0
  local result=""

  case $project_type in
    node)
      if grep -q '"prettier"' package.json; then
        echo "🔍 Checking formatting..."
        if npm run format:check > /tmp/format-output.txt 2>&1; then
          issues=0
          result="All files formatted"
        else
          issues=$(grep -c "Code style issues found" /tmp/format-output.txt || echo "1")
          result=$(cat /tmp/format-output.txt)
        fi
      else
        echo "⚠️  Prettier not found"
        return 0
      fi
      ;;
    python)
      if command -v ruff &> /dev/null; then
        echo "🔍 Checking formatting with ruff..."
        if ruff format --check src/ > /tmp/format-output.txt 2>&1; then
          issues=0
          result="All files formatted"
        else
          issues=$(wc -l < /tmp/format-output.txt)
          result=$(cat /tmp/format-output.txt)
        fi
      elif command -v black &> /dev/null; then
        echo "🔍 Checking formatting with black..."
        if black --check src/ > /tmp/format-output.txt 2>&1; then
          issues=0
          result="All files formatted"
        else
          issues=$(wc -l < /tmp/format-output.txt)
          result=$(cat /tmp/format-output.txt)
        fi
      else
        echo "⚠️  No formatter found"
        return 0
      fi
      ;;
    *)
      echo "⚠️  Unsupported project type for formatting"
      return 0
      ;;
  esac

  if [ "$issues" -eq 0 ]; then
    print_result "PASS" "Unified" "(0 format issues)"
    return 0
  else
    print_result "FAIL" "Unified" "($issues files need formatting)\n$result"

    if [ "$AUTO_FIX" = true ]; then
      echo "🔧 Auto-fixing formatting issues..."
      case $project_type in
        node)
          npm run format
          ;;
        python)
          ruff format src/ 2>/dev/null || black src/
          ;;
      esac
      echo "✅ Formatting fixed!"
    fi

    return 2
  fi
}

# Secured 검증
check_secured() {
  print_section "Secured (보안)"

  local project_type=$(detect_project_type)
  local vulnerabilities=0
  local high_severity=0
  local result=""

  case $project_type in
    node)
      echo "🔍 Running npm audit..."
      if npm audit --production > /tmp/audit-output.txt 2>&1; then
        vulnerabilities=0
        result="No vulnerabilities found"
      else
        vulnerabilities=$(grep -c "vulnerabilities" /tmp/audit-output.txt || echo "1")
        high_severity=$(grep -oE "[0-9]+ high" /tmp/audit-output.txt | grep -oE "[0-9]+" || echo "0")
        result=$(cat /tmp/audit-output.txt)
      fi
      ;;
    python)
      if command -v safety &> /dev/null; then
        echo "🔍 Running safety check..."
        if safety check > /tmp/audit-output.txt 2>&1; then
          vulnerabilities=0
          result="No vulnerabilities found"
        else
          vulnerabilities=$(wc -l < /tmp/audit-output.txt)
          result=$(cat /tmp/audit-output.txt)
        fi
      elif command -v bandit &> /dev/null; then
        echo "🔍 Running bandit..."
        if bandit -r src/ > /tmp/audit-output.txt 2>&1; then
          vulnerabilities=0
          result="No security issues found"
        else
          vulnerabilities=$(grep -c "Issue" /tmp/audit-output.txt || echo "1")
          result=$(cat /tmp/audit-output.txt)
        fi
      else
        echo "⚠️  No security auditor found"
        return 0
      fi
      ;;
    *)
      echo "⚠️  Unsupported project type for security audit"
      return 0
      ;;
  esac

  if [ "$vulnerabilities" -eq 0 ]; then
    print_result "PASS" "Secured" "(0 vulnerabilities)"
    return 0
  elif [ "$high_severity" -gt 0 ]; then
    print_result "FAIL" "Secured" "($high_severity high severity vulnerabilities)\n$result"
    return 2
  else
    print_result "WARN" "Secured" "($vulnerabilities vulnerabilities found)\n$result"
    return 1
  fi
}

# Trackable 검증
check_trackable() {
  print_section "Trackable (추적 가능성)"

  local commit_msg=""
  local changelog_exists=false
  local result=0

  # 커밋 메시지 확인
  if [ -d ".git" ]; then
    commit_msg=$(git log -1 --pretty=%B 2>/dev/null || echo "")
    if [ -n "$commit_msg" ]; then
      # Conventional Commits 형식 검증
      if echo "$commit_msg" | grep -qE '^(feat|fix|docs|style|refactor|test|chore|perf|ci|build|revert)(\(.+\))?: .+'; then
        echo "✅ Commit format: Conventional Commits compliant"
      else
        echo "❌ Commit format: Not compliant with Conventional Commits"
        echo "   Expected: type(scope): description"
        echo "   Got: $commit_msg"
        result=$((result + 1))
      fi
    fi
  fi

  # CHANGELOG 확인
  if [ -f "CHANGELOG.md" ]; then
    changelog_exists=true
    echo "✅ CHANGELOG.md exists"
  else
    echo "⚠️  CHANGELOG.md not found"
    result=$((result + 1))
  fi

  if [ $result -eq 0 ]; then
    print_result "PASS" "Trackable" "(commit format OK, CHANGELOG exists)"
    return 0
  else
    print_result "FAIL" "Trackable" "(Some tracking requirements not met)"
    return 2
  fi
}

# LSP 진단 확인 (Serena MCP 사용 가능한 경우)
check_lsp() {
  print_section "LSP Diagnostics"

  # Serena MCP가 있는 경우 사용
  if command -v mcp__serena__search_for_pattern &> /dev/null; then
    echo "🔍 Checking LSP diagnostics via Serena..."
    # 여기서는 기본 메시지 출력 (실제 LSP 진단은 Claude Code가 수행)
    echo "ℹ️  LSP diagnostics will be checked by Claude Code"
  else
    echo "⚠️  Serena MCP not available, skipping LSP check"
  fi

  return 0
}

# 메인 실행
main() {
  print_section "TRUST 5 Quality Gate"
  echo "Phase: $PHASE"
  echo "Target: $TARGET_PATH"
  echo "Auto-fix: $AUTO_FIX"
  echo "Verbose: $VERBOSE"

  load_config

  local exit_code=0

  # 특정 검증만 실행하는 경우
  if [ -n "$SPECIFIC_CHECK" ]; then
    case $SPECIFIC_CHECK in
      tested)
        check_tested || exit_code=$?
        ;;
      readable)
        check_readable || exit_code=$?
        ;;
      unified)
        check_unified || exit_code=$?
        ;;
      secured)
        check_secured || exit_code=$?
        ;;
      trackable)
        check_trackable || exit_code=$?
        ;;
    esac
  else
    # 전체 검증
    check_tested || exit_code=$?
    check_readable || exit_code=$?
    check_unified || exit_code=$?
    check_secured || exit_code=$?
    check_trackable || exit_code=$?
  fi

  # LSP 검증 (항상 실행)
  check_lsp

  # 최종 결과
  print_section "Overall Result"
  if [ $exit_code -eq 0 ]; then
    echo -e "${GREEN}✅ PASS - Ready to commit!${NC}\n"
  elif [ $exit_code -eq 1 ]; then
    echo -e "${YELLOW}⚠️  WARN - Review recommendations${NC}\n"
  else
    echo -e "${RED}❌ FAIL - Fix issues before committing${NC}\n"
  fi

  exit $exit_code
}

# 실행
main
