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

# Find MCP binary - check multiple locations in order:
# 1. HOTWIRED_MCP_BINARY env var (for explicit override)
# 2. Dev mode: Local cargo build
# 3. Production: Bundled with Hotwired desktop app
find_mcp_binary() {
    # Explicit override
    if [ -n "${HOTWIRED_MCP_BINARY:-}" ] && [ -x "${HOTWIRED_MCP_BINARY}" ]; then
        echo "${HOTWIRED_MCP_BINARY}"
        return 0
    fi

    # Dev mode: Check for local cargo build (release or debug)
    local dev_paths=(
        "${HOME}/Code/hotwired/packages/hotwired-mcp-rs/target/release/hotwired-mcp"
        "${HOME}/Code/hotwired/packages/hotwired-mcp-rs/target/debug/hotwired-mcp"
    )
    for path in "${dev_paths[@]}"; do
        if [ -x "${path}" ]; then
            echo "${path}"
            return 0
        fi
    done

    # Production: Bundled with Hotwired desktop app
    local prod_path="/Applications/Hotwired.app/Contents/MacOS/hotwired-mcp"
    if [ -x "${prod_path}" ]; then
        echo "${prod_path}"
        return 0
    fi

    return 1
}

MCP_BINARY=$(find_mcp_binary) || {
    echo "[hotwired] MCP binary not found, skipping session deregistration" >&2
    exit 0
}

# Deregister session (fire and forget)
"${MCP_BINARY}" deregister --session "${SESSION_NAME}" &>/dev/null &

exit 0
