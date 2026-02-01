# Hotwired Plugin for Claude Code

![Hotwired](hotwired-sh.png)

Claude Code plugin for [Hotwired](https://hotwired.sh) multi-agent workflow orchestration.

## What is Hotwired?

Hotwired coordinates multiple AI coding agents working together on complex tasks. Instead of one agent doing everything, you can have specialized agents (strategist, builder, reviewer) collaborating in real-time with human oversight.

This plugin connects Claude Code to the Hotwired desktop app, enabling:

- **Workflow coordination** - Send messages, handoffs, and status updates between agents
- **Human-in-the-loop** - Request input, report blockers, get approvals
- **Session tracking** - Hotwired knows when Claude is running and in which terminal

## Prerequisites

- [Hotwired Desktop App](https://hotwired.sh) - Must be running
- [Zellij](https://zellij.dev) - Terminal multiplexer for session management
- [Claude Code](https://claude.ai/code) - Version 1.0.33 or later
- [Node.js](https://nodejs.org) - For running the MCP server via npx

## Installation

### From GitHub

```bash
# Add the marketplace
claude plugin marketplace add hotwired-sh/claude-plugin

# Install the plugin
claude plugin install hotwired@hotwired-sh-claude-plugin
```

## Quick Start

```bash
# 1. Start Hotwired desktop app

# 2. Start Claude in a Zellij session
zellij -s my-project
claude

# 3. Check connection
/hotwired:status
```

When Claude starts, the plugin automatically registers your session with Hotwired.

## Available Tools

| Tool | Description |
|------|-------------|
| `get_protocol` | Fetch workflow protocol and role instructions |
| `get_run_status` | Check current run status |
| `report_status` | Update your working state |
| `send_message` | Send message to other participants |
| `request_input` | Ask human for input |
| `report_impediment` | Signal you're blocked |
| `handoff` | Hand work to another agent |
| `task_complete` | Mark a task as complete |

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│  HOTWIRED DESKTOP APP                                           │
│  └── Unix Socket: ~/.hotwired/hotwired.sock                     │
└─────────────────────────────────────────────────────────────────┘
                              ▲
                              │ Local IPC (no network)
                              │
┌─────────────────────────────┼───────────────────────────────────┐
│  CLAUDE CODE                │                                   │
│  ┌──────────────────────────┴────────────────────────────┐      │
│  │  hotwired-mcp (via npx)                               │      │
│  │  github.com/hotwired-sh/hotwired-mcp                  │      │
│  └───────────────────────────────────────────────────────┘      │
│  ┌───────────────────────────────────────────────────────┐      │
│  │  This Plugin                                          │      │
│  │  - SessionStart hook → registers session              │      │
│  │  - SessionEnd hook → deregisters session              │      │
│  │  - /hotwired:status command                           │      │
│  └───────────────────────────────────────────────────────┘      │
└─────────────────────────────────────────────────────────────────┘
```

**Everything runs locally.** The MCP server communicates with the desktop app via Unix socket. No external network calls.

## Troubleshooting

### "MCP server not found"

The plugin runs `npx @hotwired-sh/hotwired-mcp`. Make sure Node.js is installed.

### "Not in Zellij session"

Start Claude inside a Zellij session:

```bash
zellij -s my-session
claude
```

### "Socket not found"

Make sure the Hotwired desktop app is running. It creates the socket at `~/.hotwired/hotwired.sock`.

## Related

- [hotwired-mcp](https://github.com/hotwired-sh/hotwired-mcp) - The MCP server (open source)
- [hotwired.sh](https://hotwired.sh) - Desktop app and documentation

## License

MIT
