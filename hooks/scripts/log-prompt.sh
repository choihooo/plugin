#!/bin/bash
# User prompt submission hook for analytics

set -e

LOG_DIR="${CLAUDE_PLUGIN_ROOT}/logs"
mkdir -p "$LOG_DIR"

PROMPT_LENGTH=${#USER_PROMPT}
echo "📝 Prompt length: $PROMPT_LENGTH characters" >> "${LOG_DIR}/prompt-analytics.log"
echo "⏰ Time: $(date '+%Y-%m-%d %H:%M:%S')" >> "${LOG_DIR}/prompt-analytics.log"
echo "---" >> "${LOG_DIR}/prompt-analytics.log"
