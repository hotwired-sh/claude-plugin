---
description: Check Hotwired connection status and session registration
---

# Hotwired Status Check

Check your connection to the Hotwired backend and verify your session is registered.

## What to check:

1. **Zellij Session**: Report the value of `$ZELLIJ_SESSION_NAME` environment variable
2. **Socket Connection**: Check if `~/.hotwired/hotwired.sock` exists
3. **Desktop App**: Check if Hotwired desktop app is running

## Report format:

```
Hotwired Status
===============
Zellij Session: [session-name or "Not in Zellij"]
Socket: [Connected / Not found]
Desktop App: [Running / Not detected]
```

If any issues are found, suggest how to fix them.
