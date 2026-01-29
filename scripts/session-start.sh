#!/bin/bash
# Register this Claude session with Hotwired backend
#
# Called by Claude Code's SessionStart hook.
# Communicates via the hotwired-mcp binary which connects to the Unix socket.

set -e

# Path to the MCP binary (bundled with Hotwired desktop app)
MCP_BINARY="/Applications/Hotwired.app/Contents/MacOS/hotwired-mcp"

# Session info from environment
SESSION_NAME="${ZELLIJ_SESSION_NAME:-}"
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

# Skip if not in a Zellij session
if [ -z "${SESSION_NAME}" ]; then
    exit 0
fi

# Skip if MCP binary doesn't exist (desktop app not installed)
if [ ! -x "${MCP_BINARY}" ]; then
    echo "[hotwired] Desktop app not found, skipping session registration" >&2
    exit 0
fi

# Register session (fire and forget, don't block Claude startup)
"${MCP_BINARY}" --register \
    --session "${SESSION_NAME}" \
    --project "${PROJECT_DIR}" &>/dev/null &

exit 0
