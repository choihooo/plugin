#!/bin/bash
# 다른 프로젝트에 SET Tools 플러그인 설치 스크립트

set -euo pipefail

# 색상
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🚀 SET Tools 플러그인 설치${NC}"
echo ""

# 플러그인 소스 경로
SOURCE_DIR="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

# Claude Code 플러그인 디렉토리
CLAUDE_PLUGINS_DIR="$HOME/.claude/plugins"

# 대상 프로젝트 경로 (선택사항)
TARGET_PROJECT="${1:-$(pwd)}"

echo "📁 소스: $SOURCE_DIR"
echo "📁 Claude 플러그인: $CLAUDE_PLUGINS_DIR"
echo "📁 대상 프로젝트: $TARGET_PROJECT"
echo ""

# Claude Code 플러그인 디렉토리 확인
if [ ! -d "$CLAUDE_PLUGINS_DIR" ]; then
  echo "📁 Claude Code 플러그인 디렉토리 생성..."
  mkdir -p "$CLAUDE_PLUGINS_DIR"
fi

# 설치 방법 선택
echo "설치 방법을 선택하세요:"
echo "1. 심볼릭 링크 (개발 중 추천 - 수정 즉시 반영)"
echo "2. 복사 (독립적)"
echo ""
read -p "선택 (1 또는 2): " choice

case $choice in
  1)
    echo -e "${BLUE}🔗 심볼릭 링크로 설치 중...${NC}"

    # 기존 링크/디렉토리 백업
    if [ -e "$CLAUDE_PLUGINS_DIR/set-tools" ]; then
      echo "⚠️  기존 플러그인 발견: 백업 중..."
      mv "$CLAUDE_PLUGINS_DIR/set-tools" "$CLAUDE_PLUGINS_DIR/set-tools.backup.$(date +%Y%m%d%H%M%S)"
    fi

    # 심볼릭 링크 생성
    ln -s "$SOURCE_DIR" "$CLAUDE_PLUGINS_DIR/set-tools"

    if [ -L "$CLAUDE_PLUGINS_DIR/set-tools" ]; then
      echo -e "${GREEN}✅ 심볼릭 링크 설치 성공!${NC}"
    else
      echo "❌ 설치 실패"
      exit 1
    fi
    ;;

  2)
    echo -e "${BLUE}📦 복사로 설치 중...${NC}"

    # 기존 디렉토리 백업
    if [ -e "$CLAUDE_PLUGINS_DIR/set-tools" ]; then
      echo "⚠️  기존 플러그인 발견: 백업 중..."
      mv "$CLAUDE_PLUGINS_DIR/set-tools" "$CLAUDE_PLUGINS_DIR/set-tools.backup.$(date +%Y%m%d%H%M%S)"
    fi

    # 복사
    cp -r "$SOURCE_DIR" "$CLAUDE_PLUGINS_DIR/set-tools"

    if [ -d "$CLAUDE_PLUGINS_DIR/set-tools" ]; then
      echo -e "${GREEN}✅ 복사 설치 성공!${NC}"
    else
      echo "❌ 설치 실패"
      exit 1
    fi
    ;;

  *)
    echo "❌ 잘못된 선택"
    exit 1
    ;;
esac

echo ""
echo -e "${GREEN}🎉 설치 완료!${NC}"
echo ""
echo "📋 설치된 커맨드:"
echo "   /project-init    - 프로젝트 전체 설계"
echo "   /spec-create     - 피처 스펙 생성 (EARS)"
echo "   /spec-update     - 스펙 변경 및 CHANGELOG"
echo "   /spec-diff       - 스펙 버전 비교"
echo "   /spec-list       - 전체 스펙 목록"
echo "   /quality-check   - TRUST 5 품질 검증"
echo "   /trust-validate  - LSP 품질 게이트"
echo "   /adr-create      - ADR 생성"
echo "   /adr-list        - ADR 목록"
echo ""
echo "🤖 자동 활성화 스킬:"
echo "   - spec-generator   (스펙 자동 생성)"
echo "   - spec-updater     (스펙 변경 추적)"
echo "   - trust-validator  (품질 자동 검증)"
echo "   - adr-generator    (ADR 자동 생성)"
echo ""
echo "💡 사용법:"
echo "   1. 새 프로젝트: cd 프로젝트 && /project-init"
echo "   2. 기존 프로젝트: cd 프로젝트 && /quality-check"
echo ""
echo "⚙️  설정 파일이 필요하면:"
echo "   cp /home/choiho/set/my-plugin/.trust.example.yaml .trust.yaml"
