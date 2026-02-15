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
2. `hotwired status` must succeed (tests CLI connectivity)

If either fails: "Restart Claude in Zellij with desktop app running."

## Execution

### 1. Find the Run to Join

```bash
hotwired run list
```

Look for runs with status `active` in the **same project directory** you're currently in.
If you know the run ID already (e.g., user told you, or you see it in the UI), skip to step 2.

### 2. Determine Your Role

For `plan-build` playbook: If `strategist` is taken, you're `builder`.
For `architect-team` playbook: You might be `worker-1`, `worker-2`, or `worker-3`.
For `doc-editor` playbook: If `writer` is taken, you're `critiquer`.

### 3. Call CLI

```bash
hotwired pair <RUN_ID> --role <YOUR_ROLE>
```

Example:
```bash
hotwired pair 1e9ba421 --role builder
```

### 4. Handle Response

**Success** - You'll see:
```
Joined run: <run_id>
Your role: <role>

<protocol instructions>
```
→ You have your protocol. Begin your role.

**Error** - Common issues:
- "Run not found" → Check the run ID is correct
- "Role already taken" → That role is filled, try a different one
- "Not in Zellij" → You must run this from within a Zellij session

**No protocol returned** → The backend may not have assigned the role properly. Check `hotwired status` to verify attachment.

## After Joined

Follow the protocol. Your role complements the primary agent.
Read the conversation summary to understand context.
