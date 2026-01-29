#!/bin/bash
# Deregister this Claude session from Hotwired backend
#
# Called by Claude Code's SessionEnd hook.
# Communicates via the hotwired-mcp binary which connects to the Unix socket.

set -e

# Path to the MCP binary (bundled with Hotwired desktop app)
MCP_BINARY="/Applications/Hotwired.app/Contents/MacOS/hotwired-mcp"

# Session info from environment
SESSION_NAME="${ZELLIJ_SESSION_NAME:-}"

# Skip if not in a Zellij session
if [ -z "${SESSION_NAME}" ]; then
    exit 0
fi

# Skip if MCP binary doesn't exist
if [ ! -x "${MCP_BINARY}" ]; then
    exit 0
fi

# Deregister session (fire and forget)
"${MCP_BINARY}" deregister --session "${SESSION_NAME}" &>/dev/null &

exit 0
