#!/bin/bash
# Register this Claude session with Hotwired backend
#
# Called by Claude Code's SessionStart hook.
# Communicates via the hotwired-mcp binary which connects to the Unix socket.

set -e

# Session info from environment
SESSION_NAME="${ZELLIJ_SESSION_NAME:-}"
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Skip if not in a Zellij session
if [ -z "${SESSION_NAME}" ]; then
    exit 0
fi

# Register session (fire and forget, don't block Claude startup)
npx --yes @hotwired-sh/hotwired-mcp@latest register \
    --session "${SESSION_NAME}" \
    --project "${PROJECT_DIR}" &>/dev/null &

exit 0
