#!/bin/bash
# Post-bash hook to log commands for audit trail

set -e

echo "📊 Command executed: $CMD" >> "${CLAUDE_PLUGIN_ROOT}/logs/command-history.log"
echo "⏰ Timestamp: $(date)" >> "${CLAUDE_PLUGIN_ROOT}/logs/command-history.log"
echo "---" >> "${CLAUDE_PLUGIN_ROOT}/logs/command-history.log"
