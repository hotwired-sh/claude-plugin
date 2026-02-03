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

**Joined** (exactly one match - auto-paired):
```json
{
  "status": "joined",
  "run_id": "xxx",
  "role": "reviewer",
  "role_name": "Reviewer",
  "playbook": "doc-editor",
  "protocol": "...",
  "context": { "primary_status": "...", "current_artifact": "...", "conversation_summary": "..." }
}
```
→ You have your protocol. Read the context summary. Begin your role.
→ Note: Backend determined your role from the `needs_second_agent` impediment.

**NeedsSelection** (multiple runs waiting - app shows picker):
```json
{
  "status": "needs_selection",
  "pending_runs": [{ "run_id": "...", "playbook": "...", "intent": "...", "role_needed": "..." }],
  "message": "Multiple runs need pairing. Select in app."
}
```
→ Tell user: "Multiple runs need a second agent. Please select which one in the Hotwired app."
→ Wait. When user selects, you'll receive a trigger message via Zellij.
→ Then call `get_protocol(run_id, role)` to get your instructions.

**NoneAvailable**:
```json
{ "status": "none", "message": "No runs need second agent" }
```
→ "No runs waiting for second agent. Check that primary raised impediment."

**ProjectMismatch** (if same_project required):
```json
{ "status": "project_mismatch", "required_path": "/path/to/project", "current_path": "/wrong/path" }
```
→ "This run requires you to be in [required_path]. Please cd there and try again."

**Error**:
→ Report with fix suggestions.

## After Joined

Follow the protocol. Your role complements the primary agent.
Read the conversation summary to understand context.
