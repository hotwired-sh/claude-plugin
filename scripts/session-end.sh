#!/bin/bash
# Deregister this Claude session from Hotwired backend
#
# Called by Claude Code's SessionEnd hook.
# Communicates via the hotwired-mcp binary which connects to the Unix socket.

set -e

# Session info from environment
SESSION_NAME="${ZELLIJ_SESSION_NAME:-}"

# Skip if not in a Zellij session
if [ -z "${SESSION_NAME}" ]; then
    exit 0
fi

# Deregister session (fire and forget)
npx --yes @hotwired-sh/hotwired-mcp@latest deregister --session "${SESSION_NAME}" &>/dev/null &

exit 0
