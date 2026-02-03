---
description: Join an existing Hotwired run as second agent
arguments: []
---

# /pair - Join Hotwired Workflow

Join an existing run as SECONDARY AGENT.

## Compaction Survival

If context compaction occurs, preserve: `run_id`, `role`, `role_name`, `playbook`.
Call `get_run_status` to recover state.

## Tools Locked Until Success

No workflow tools until this returns your protocol.

## Prerequisites

1. `$ZELLIJ_SESSION_NAME` must be set
2. `mcp__hotwired__ping` must succeed

If either fails: "Restart Claude in Zellij with desktop app running."

## Execution

### 1. Call MCP
```
mcp__hotwired__pair({
  zellij_session: $ZELLIJ_SESSION_NAME,
  project_path: pwd
})
```

### 2. Handle Response

**Joined**:
```json
{
  "status": "joined",
  "run_id": "xxx",
  "role": "secondary",
  "role_name": "Reviewer",
  "playbook": "doc-editor",
  "protocol": "...",
  "context": { "primary_status": "...", "artifact": "...", "summary": "..." }
}
```
→ You have your protocol. Read the context summary. Begin your role.

**Multiple** (multiple runs waiting):
```json
{ "status": "multiple", "pending_runs": [{ "run_id", "intent", "role" }] }
```
→ Present options to user, wait for selection.

**None**:
→ "No runs waiting for second agent. Check that primary raised impediment."

**ProjectMismatch** (if same_project required):
→ "This run requires you to be in [path]. Please cd there and try again."

**Error**:
→ Report with fix suggestions.

## After Joined

Follow the protocol. Your role complements the primary agent.
Read the conversation summary to understand context.
