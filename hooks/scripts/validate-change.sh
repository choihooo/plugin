#!/bin/bash
# Pre-write validation hook
# Validates file changes before they're written

set -e

echo "🔍 Validating code changes..."

# Check if file being written is too large (>1MB)
FILE_SIZE=$(stat -c%s "${FILE_PATH}" 2>/dev/null || echo "0")
if [ "$FILE_SIZE" -gt 1048576 ]; then
  echo "⚠️  Warning: File size exceeds 1MB ($FILE_SIZE bytes)"
fi

# Check for common security issues in the content
if echo "$CONTENT" | grep -i "password.*=.*['\"].*['\"]"; then
  echo "⚠️  Warning: Possible hardcoded password detected"
fi

if echo "$CONTENT" | grep -i "api_key.*=.*['\"].*['\"]"; then
  echo "⚠️  Warning: Possible hardcoded API key detected"
fi

# Check for TODO/FIXME comments
TODO_COUNT=$(echo "$CONTENT" | grep -c "TODO\|FIXME" || true)
if [ "$TODO_COUNT" -gt 0 ]; then
  echo "📝 Found $TODO_COUNT TODO/FIXME comments"
fi

echo "✅ Validation complete"
