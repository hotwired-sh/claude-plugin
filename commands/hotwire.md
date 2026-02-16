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
Call `hotwired status` to recover state and `hotwired protocol` to re-fetch your instructions.

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

## Prerequisites

1. `$ZELLIJ_SESSION_NAME` must be set (you must be in a Zellij terminal)
2. Hotwired desktop app must be running

If either fails: "Restart Claude in Zellij with desktop app running."

## Execution

### 1. Gather Context
```bash
echo $ZELLIJ_SESSION_NAME   # Must be set
pwd                          # Your project directory
```

### 2. Analyze Intent
- "create/write/draft/PRD" → `--playbook doc-editor`
- "implement/build/code/fix" → `--playbook plan-build`
- Scan for docs/, specs/ directories to help decide

### 3. Call CLI

**IMPORTANT: Use these EXACT flags. Do NOT invent flags like --project-path or --zellij-session.**

```bash
hotwired hotwire --project "$PWD" --intent "<intent>" --playbook "<playbook>"
```

The Zellij session is auto-detected from `$ZELLIJ_SESSION_NAME`. Do NOT pass it as a flag.

Full flag reference:
- `--project <PATH>` - Project directory (defaults to current dir, so often optional)
- `--intent <TEXT>` - What you want to accomplish
- `--playbook <NAME>` - Which playbook (doc-editor, plan-build, architect-team)

### 4. Handle Response

**Started** (immediate):
```
Run started: <run_id>
Your role: <role>

<protocol instructions>
```
→ You have your protocol. **Immediately run `hotwired status` to verify attachment.**

**NeedsConfirmation** (user must confirm in app):
```
Run pending: <run_id>
```
→ Tell user: "Please confirm the workflow in Hotwired app."
→ Wait. When user confirms, you'll receive a trigger message.

**Error**:
→ Report to user with fix suggestions.

## After Started - CRITICAL STEPS

1. **Verify attachment**: Run `hotwired status` - must show your run and role
2. **Read your protocol carefully** - the protocol instructions returned above are your workflow guide. If you lose them after compaction, run `hotwired protocol` to re-fetch.
3. **Follow your protocol instructions** - they tell you exactly what to do for your role
4. When you need a second agent, raise impediment → user runs `/pair`

## Available CLI Commands (after hotwire)

Once attached to a run, you can use:
- `hotwired protocol` - Re-fetch your protocol instructions (use after compaction)
- `hotwired status` - Check run status and connected agents
- `hotwired artifact sync <file>` - Register/update a document artifact
- `hotwired artifact ls` - List tracked artifacts
- `hotwired artifact comment <file> "<text>" "<comment>"` - Add anchored comment
- `hotwired send <role> "<message>"` - Send message to another agent
- `hotwired inbox` - Check for messages
- `hotwired complete` - Mark task as done
- `hotwired impediment "<description>"` - Report a blocker
