# Hotwired Plugin v1.0.0

This plugin connects Claude Code to the Hotwired multi-agent workflow system.

## Version Info
- **Plugin Version**: 1.0.0
- **MCP Server**: hotwired-mcp (installed separately)

## Available Commands
- `/hotwired:status` - Check connection status and plugin version
- `/hotwire [intent]` - Start a new workflow run
- `/pair` - Join an existing run as a second agent

## Quick Reference

When working in a Hotwired workflow:
1. You'll receive a protocol via `get_protocol` MCP tool
2. Follow the protocol instructions for your role
3. Use `report_status` to update your progress
4. Use `handoff` to pass work to other agents
5. Use `report_impediment` if you're blocked

## Troubleshooting

Run `/hotwired:status` to diagnose connection issues.
