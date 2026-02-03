---
description: Start a new Hotwired workflow run
arguments:
  - name: intent
    description: What you want to accomplish (optional)
    required: false
---

# /hotwire - Start Hotwired Workflow

Initiates the Hotwired protocol. You become the PRIMARY AGENT.

## Compaction Survival

If context compaction occurs, preserve: `run_id`, `role`, `playbook`.
Call `get_run_status` to recover state.

## Check for Active/Resumable Runs First

Before starting a new run, check if you should CONTINUE an existing one:

1. **Call `mcp__hotwired__list_active_runs`** with project_path and zellij_session.

2. **If you find a run where `my_role` is set:**
   → You were attached to this run (maybe after compaction).
   → Suggest: "I was working on run [run_id]. Continue that run, or start new?"

3. **If user's intent matches an active run's intent:**
   → "There's an active '[playbook]' run for '[intent]'. Continue that, or start new?"

4. **Only if no match or user wants new** → proceed with `hotwire` tool.

This prevents duplicate runs and helps users resume interrupted work.

## Tools Locked Until Success

No workflow tools until this returns your protocol.

## Prerequisites

1. `$ZELLIJ_SESSION_NAME` must be set
2. `mcp__hotwired__ping` must succeed

If either fails: "Restart Claude in Zellij with desktop app running."

## Execution

### 1. Gather Context
```
project_path: pwd
intent: user's description (may be empty)
zellij_session: $ZELLIJ_SESSION_NAME
```

### 2. Analyze Intent
- "create/write/draft/PRD" → doc-editor
- "implement/build/code/fix" → plan-build
- Scan for docs/, specs/ directories
- Match keywords to existing files

### 3. Call MCP
```
mcp__hotwired__hotwire({
  project_path,
  zellij_session,
  intent,
  suggested_playbook,
  suggested_artifacts: [{ path, action }]
})
```

### 4. Handle Response

**Started** (immediate):
```json
{ "status": "started", "run_id": "xxx", "role": "primary", "playbook": "...", "protocol": "..." }
```
→ You have your protocol. Begin working.

**NeedsConfirmation** (user must confirm in app):
```json
{ "status": "needs_confirmation", "pending_run_id": "xxx", "message": "..." }
```
→ Tell user: "Please confirm the workflow in Hotwired app."
→ Wait. When user confirms, you'll receive a trigger message.
→ Then call `get_protocol(run_id, role)` to get your instructions.

**Error**:
→ Report to user with fix suggestions.

## After Started

Follow the protocol. When you need a second agent, raise impediment → user runs `/pair`.
