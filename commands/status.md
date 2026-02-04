---
description: Check Hotwired connection status and session registration
version: --help
---

# Hotwired Status Check

**Plugin Version: --help**

Check your connection to the Hotwired backend and verify your session is registered.

## What to check:

1. **Zellij Session**: Report the value of `$ZELLIJ_SESSION_NAME` environment variable
2. **Socket Connection**: Check if `~/.hotwired/hotwired.sock` exists
3. **Desktop App**: Check if Hotwired desktop app is running
4. **MCP Server**: Call `mcp__hotwired__ping` to verify the MCP server is responding

## Report format:

```
Hotwired Status
===============
Plugin Version: --help
Zellij Session: [session-name or "Not in Zellij"]
Socket: [Connected / Not found]
Desktop App: [Running / Not detected]
MCP Server: [Connected / Error message if failed]
```

If any issues are found, suggest how to fix them.
