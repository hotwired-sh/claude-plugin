---
description: Join an existing Hotwired run as second agent
arguments: []
---

# /pair - Join Hotwired Workflow

Join an existing run as SECONDARY AGENT.

## Compaction Survival

If context compaction occurs, preserve: `run_id`, `role`, `playbook`.
Call `hotwired status` to recover state and `hotwired protocol` to re-fetch your instructions.

## Prerequisites

1. `$ZELLIJ_SESSION_NAME` must be set (you must be in a Zellij terminal)
2. Hotwired desktop app must be running

If either fails: "Restart Claude in Zellij with desktop app running."

## Execution

### 1. Find the Run to Join

```bash
hotwired run list
```

Look for runs with status `active` in the **same project directory** you're currently in.
If you know the run ID already (e.g., user told you), skip to step 2.

### 2. Call CLI

**IMPORTANT: Use these EXACT flags. The Zellij session is auto-detected.**

```bash
hotwired pair <RUN_ID>
```

Optionally specify a role:
```bash
hotwired pair <RUN_ID> --role <ROLE>
```

If you don't specify `--role`, the backend will auto-assign the next unfilled role from the playbook.

Full flag reference:
- `<RUN_ID>` (required, positional) - The run to join (can use prefix match)
- `--role <ROLE>` (optional) - Role to take (e.g., builder, critiquer, worker-1)

### 3. Handle Response

**Success**:
```
Joined run: <run_id>
Your role: <role>

<protocol instructions>
```
→ You have your protocol. **Immediately run `hotwired status` to verify attachment.**

**Error** - Common issues:
- "Run not found" → Check the run ID is correct (`hotwired run list` to see active runs)
- "Role already taken" → That role is filled, try a different one or omit `--role`
- "Not in Zellij" → You must run this from within a Zellij session

### 4. Verify Attachment

```bash
hotwired status
```

Must show your run ID and role. If it says "not attached", something went wrong.

## After Joined - CRITICAL STEPS

1. **Verify attachment**: Run `hotwired status`
2. **Check inbox**: Run `hotwired inbox` to see what happened before you joined
3. **For doc-editor playbook**: Check tracked artifacts:
   ```bash
   hotwired artifact ls
   ```
4. **Follow your protocol instructions** - your role complements the primary agent

## Available CLI Commands (after pair)

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
