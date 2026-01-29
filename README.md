# Hotwired Plugin for Claude Code

Multi-agent workflow orchestration for Claude Code. This plugin connects Claude Code to the [Hotwired](https://hotwired.sh) desktop application, enabling:

- **Workflow tools**: Send messages, handoffs, report status between agents
- **Session detection**: Automatic registration so Hotwired knows when Claude is running
- **Slash commands**: `/hotwired:status` to check connection

## Prerequisites

1. **Hotwired Desktop App** - Install from [hotwired.sh](https://hotwired.sh)
2. **Zellij** - Terminal multiplexer ([zellij.dev](https://zellij.dev))
3. **Claude Code** - Version 1.0.33 or later

## Installation

### From Official Marketplace (Recommended)

```bash
claude plugin install hotwired
```

### From GitHub

```bash
# Add the marketplace
claude plugin marketplace add hotwired-sh/claude-plugin

# Install the plugin
claude plugin install hotwired
```

## Usage

### 1. Start Hotwired Desktop App

Launch the Hotwired app. It will listen on `~/.hotwired/hotwired.sock`.

### 2. Start Claude in Zellij

```bash
# Create or attach to a Zellij session
zellij -s my-project

# Start Claude Code
claude
```

When Claude starts, the plugin automatically:
- Registers your session with Hotwired
- Connects to the Hotwired backend via Unix socket
- Makes workflow tools available

### 3. Check Status

Run the status command to verify everything is connected:

```
/hotwired:status
```

### 4. Join a Workflow

In the Hotwired UI, create a workflow run and pair your Claude session. The plugin provides these MCP tools:

| Tool | Description |
|------|-------------|
| `get_protocol` | Fetch workflow protocol and role instructions |
| `get_run_status` | Check current run status |
| `report_status` | Update your working state |
| `send_message` | Send message to other participants |
| `request_input` | Ask human for input (blocks workflow) |
| `report_impediment` | Signal you're blocked |
| `handoff` | Hand work to another agent |
| `task_complete` | Mark a task as complete |

## How It Works

```
┌─────────────────────────────────────────────────────────────────┐
│  HOTWIRED DESKTOP APP                                           │
│  └── Listens on ~/.hotwired/hotwired.sock                       │
└─────────────────────────────────────────────────────────────────┘
                              ▲
                              │ Unix Socket
                              │
┌─────────────────────────────┼───────────────────────────────────┐
│  CLAUDE CODE                │                                   │
│  ┌──────────────────────────┴───────────────────────────┐      │
│  │  hotwired-mcp binary                                  │      │
│  │  (from Hotwired.app)                                  │      │
│  └───────────────────────────────────────────────────────┘      │
│  ┌───────────────────────────────────────────────────────┐      │
│  │  Hotwired Plugin                                      │      │
│  │  - SessionStart hook → registers session              │      │
│  │  - SessionEnd hook → deregisters session              │      │
│  │  - /hotwired:status command                           │      │
│  └───────────────────────────────────────────────────────┘      │
└─────────────────────────────────────────────────────────────────┘
```

## Troubleshooting

### "Desktop app not found"

The plugin looks for the MCP binary at:
- macOS: `/Applications/Hotwired.app/Contents/MacOS/hotwired-mcp`

Make sure the Hotwired desktop app is installed.

### "Not in Zellij session"

The plugin requires Zellij for session management. Start Claude inside a Zellij session:

```bash
zellij -s my-session
claude
```

### "Socket not found"

Make sure the Hotwired desktop app is running. The app creates the socket at `~/.hotwired/hotwired.sock`.

## Development

To test the plugin locally during development:

```bash
claude --plugin-dir /path/to/claude-plugin
```

## License

MIT
