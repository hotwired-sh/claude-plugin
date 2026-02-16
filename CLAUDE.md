# Hotwired Plugin v--help

This plugin connects Claude Code to the Hotwired multi-agent workflow system.

## Version Info
- **Plugin Version**: --help
- **MCP Server**: hotwired-mcp (installed separately)

## Available Commands
- `/hotwired:status` - Check connection status and plugin version
- `/hotwire [intent]` - Start a new workflow run
- `/pair` - Join an existing run as a second agent

## Lifecycle Hooks

This plugin routes Claude Code lifecycle events to the Hotwired backend via the `hotwired` CLI:

- **SessionStart/SessionEnd** → `hotwired internal session-start/session-end` (registers/deregisters sessions)
- **Stop, PreCompact, Notification** → `hotwired internal hook-event <name>` (telemetry)
- **SubagentStart, SubagentStop, TaskCompleted** → `hotwired internal hook-event <name>` (telemetry)

All hooks are fire-and-forget. They never block Claude Code.

## Quick Reference

When working in a Hotwired workflow:
1. You'll receive a protocol via `get_protocol` MCP tool
2. Follow the protocol instructions for your role
3. Use `hotwired status` to check run state
4. Use `hotwired send --to <agent>` to pass work to other agents
5. Use `hotwired impediment` if you're blocked
6. Use `hotwired complete` when your task is done

## CLI Commands (v2.0+)

After joining a workflow, communicate using the `hotwired` CLI:

| Command | Description |
|---------|-------------|
| `hotwired status` | Check run state and connected agents |
| `hotwired send --to <recipient> <message>` | Send message/handoff to agent or human |
| `hotwired impediment <description>` | Report a blocker |
| `hotwired complete` | Mark your task as complete |
| `hotwired inbox` | Check for incoming messages |

## Troubleshooting

Run `/hotwired:status` to diagnose connection issues.
