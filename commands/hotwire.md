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

1. **Run `hotwired status`** first - if it shows you're already attached to a run, ask:
   → "You're attached to run [run_id]. Continue that, or start a new run?"

2. **Only suggest resuming if ALL of these are true:**
   - The run is from the SAME project directory (compare `pwd` with run's project path)
   - The run is recent (created today or yesterday, not a week ago)
   - The run is `active` status (ignore `pending_confirmation` or `completed`)
   - The intent/goal is similar to what the user is asking

3. **DON'T suggest resuming if:**
   - You're in a different directory than the run's project
   - The run is old (more than 1-2 days)
   - The run is `pending_confirmation` (these are stale, just start fresh)
   - The run is `completed`

4. **When in doubt, start fresh.** Users prefer a clean start over being asked about old runs.

This prevents annoying prompts about irrelevant runs from other projects.

## Tools Locked Until Success

No workflow tools until this returns your protocol.

## Prerequisites

1. `$ZELLIJ_SESSION_NAME` must be set
2. `hotwired status` must succeed (tests CLI connectivity)

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

### 3. Call CLI
```bash
hotwired hotwire \
  --project-path "$PWD" \
  --zellij-session "$ZELLIJ_SESSION_NAME" \
  --intent "<intent>" \
  --playbook "<suggested_playbook>"
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
