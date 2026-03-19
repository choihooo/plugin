#!/bin/bash
# Claude Code 플러그인 심볼릭 링크 스크립트

set -euo pipefail

# 색상
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# 플러그인 경로
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN_NAME="set-tools"

# Claude Code 플러그인 디렉토리
CLAUDE_PLUGINS_DIR="$HOME/.claude/plugins"

echo -e "${BLUE}🔗 SET Tools 플러그in 연결 중...${NC}"

# Claude Code 플러그인 디렉토리 확인
if [ ! -d "$CLAUDE_PLUGINS_DIR" ]; then
  echo "📁 Claude Code 플러그인 디렉토리 생성 중..."
  mkdir -p "$CLAUDE_PLUGINS_DIR"
fi

# 기존 링크/디렉토리 백업
if [ -e "$CLAUDE_PLUGINS_DIR/$PLUGIN_NAME" ]; then
  echo "⚠️  기존 플러그인 발견: 백업 중..."
  mv "$CLAUDE_PLUGINS_DIR/$PLUGIN_NAME" "$CLAUDE_PLUGINS_DIR/$PLUGIN_NAME.backup.$(date +%Y%m%d%H%M%S)"
fi

# 심볼릭 링크 생성
echo "🔗 심볼릭 링크 생성 중..."
ln -s "$PLUGIN_DIR" "$CLAUDE_PLUGINS_DIR/$PLUGIN_NAME"

# 확인
if [ -L "$CLAUDE_PLUGINS_DIR/$PLUGIN_NAME" ]; then
  echo -e "${GREEN}✅ 플러그인 연결 성공!${NC}"
  echo ""
  echo "📍 플러그인 위치: $PLUGIN_DIR"
  echo "🔗 링크 위치: $CLAUDE_PLUGINS_DIR/$PLUGIN_NAME"
  echo ""
  echo "🎯 다음 커맨드 사용 가능:"
  echo "   /project-init  - 프로젝트 전체 설계"
  echo "   /spec-create   - 피처 스펙 생성"
  echo "   /quality-check - 품질 검증"
  echo "   /trust-validate - LSP 품질 게이트"
  echo ""
  echo "💡 팁: 플러그인을 수정하면 바로 반영됩니다!"
else
  echo "❌ 플러그인 연결 실패"
  exit 1
fi
