# Hotwired Plugin for Claude Code

![Hotwired](hotwired-sh.png)

Claude Code plugin for [Hotwired](https://hotwired.sh) multi-agent workflow orchestration.

## What is Hotwired?

Hotwired coordinates multiple AI coding agents working together on complex tasks. Instead of one agent doing everything, you can have specialized agents (strategist, builder, reviewer) collaborating in real-time with human oversight.

This plugin connects Claude Code to the Hotwired desktop app, enabling:

- **Workflow coordination** - CLI commands for messages, handoffs, and status updates between agents
- **Human-in-the-loop** - Request input, report blockers, get approvals
- **Session tracking** - Hotwired knows when Claude is running and in which terminal
- **Lifecycle telemetry** - Hook events (Stop, PreCompact, SubagentStart, etc.) are forwarded to the Hotwired UI

## Prerequisites

- [Hotwired Desktop App](https://hotwired.sh) - Must be running
- [Zellij](https://zellij.dev) - Terminal multiplexer for session management
- [Claude Code](https://claude.ai/code) - Version 1.0.33 or later
- [hotwired CLI](https://github.com/hotwired-sh/hotwired-cli) - Installed and on PATH
- [Node.js](https://nodejs.org) - For running the MCP server via npx

## Installation

### From GitHub

```bash
# Add the marketplace
claude plugin marketplace add hotwired-sh/claude-plugin

# Install the plugin
claude plugin install hotwired@hotwired-sh
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

## MCP Tools (Workflow Setup)

These MCP tools are used to start/join workflows:

| Tool | Description |
|------|-------------|
| `mcp__hotwired__hotwire` | Start a new workflow run |
| `mcp__hotwired__pair` | Join an existing run |
| `mcp__hotwired__ping` | Check connection to Hotwired |
| `mcp__hotwired__get_protocol` | Fetch workflow protocol and role instructions |
| `mcp__hotwired__list_active_runs` | List runs you can join or resume |

## CLI Commands (Agent Communication)

After joining a workflow, use the `hotwired` CLI for agent communication:

| Command | Description |
|---------|-------------|
| `hotwired status` | Check run state and connected agents |
| `hotwired send --to <recipient> <msg>` | Send message/handoff to agent or human |
| `hotwired impediment <description>` | Signal you're blocked |
| `hotwired complete` | Mark your task as complete |
| `hotwired inbox` | Check for incoming messages |
| `hotwired artifact sync <file>` | Track a document artifact |
| `hotwired artifact comment <file> <text> <comment>` | Add comment to document |

## Architecture

```
┌──────────────────────────────────────────────────────────────┐
│  HOTWIRED DESKTOP APP                                        │
│  ├── Unix Socket: ~/.hotwired/hotwired.sock                  │
│  └── WebSocket: ws://127.0.0.1:8765 (UI event bus)          │
└──────────────────────────────────────────────────────────────┘
                             ▲
                             │ Local IPC (no network)
                             │
┌────────────────────────────┼─────────────────────────────────┐
│  CLAUDE CODE               │                                 │
│  ┌─────────────────────────┴───────────────────────────────┐ │
│  │  hotwired-mcp (via npx)                                 │ │
│  │  MCP tools: hotwire, pair, ping, get_protocol           │ │
│  └─────────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  hotwired CLI (native binary)                           │ │
│  │  Workflow: status, send, impediment, complete, inbox     │ │
│  │  Internal: session-start, session-end, hook-event        │ │
│  └─────────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  This Plugin (hooks.json)                               │ │
│  │  Routes lifecycle hooks → hotwired CLI                  │ │
│  │  /hotwired:status slash command                         │ │
│  └─────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
```

**Everything runs locally.** The MCP server and CLI communicate with the desktop app via Unix socket. No external network calls.

### Lifecycle Hooks

The plugin registers handlers for Claude Code lifecycle events via `hooks.json`. All hooks route through the `hotwired` CLI binary for fast, fire-and-forget IPC:

| Hook | Command | Purpose |
|------|---------|---------|
| SessionStart | `hotwired internal session-start` | Register session + telemetry |
| SessionEnd | `hotwired internal session-end` | Deregister session + telemetry |
| Stop | `hotwired internal hook-event stop` | Agent stopping |
| PreCompact | `hotwired internal hook-event pre_compact` | Context about to compact |
| Notification | `hotwired internal hook-event notification` | Agent notification |
| SubagentStart | `hotwired internal hook-event subagent_start` | Subagent spawned |
| SubagentStop | `hotwired internal hook-event subagent_stop` | Subagent finished |
| TaskCompleted | `hotwired internal hook-event task_completed` | Task completed |

## Troubleshooting

### "MCP server not found"

The plugin runs `npx @hotwired-sh/hotwired-mcp`. Make sure Node.js is installed.

### "hotwired: command not found"

The `hotwired` CLI must be on your PATH. Install it from [hotwired-cli](https://github.com/hotwired-sh/hotwired-cli).

### "Not in Zellij session"

Start Claude inside a Zellij session:

```bash
zellij -s my-session
claude
```

### "Socket not found"

Make sure the Hotwired desktop app is running. It creates the socket at `~/.hotwired/hotwired.sock`.

## Related

- [hotwired-cli](https://github.com/hotwired-sh/hotwired-cli) - The CLI binary (open source)
- [hotwired-mcp](https://github.com/hotwired-sh/hotwired-mcp) - The MCP server (open source)
- [hotwired.sh](https://hotwired.sh) - Desktop app and documentation

## License

MIT
