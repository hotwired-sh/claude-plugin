---
description: Open a document for review and editing
arguments:
  - name: document
    description: File path or description of document to open
    required: false
---

# /open - Open Document for Editing

Opens a document as a tracked artifact for review and editing. Works in two modes:

- **Standalone**: Creates a new single-agent workflow run
- **In-run**: Opens the document in your existing run

## Compaction Survival

If context compaction occurs, preserve: `run_id`, `role`, `artifact_path`.
- **Standalone mode**: Call `hotwired status` to recover state and `hotwired protocol` to re-fetch your instructions.
- **In-run mode**: Call `hotwired status` to recover state and `hotwired protocol --playbook doc-open --role editor` to re-fetch editor instructions.

## Prerequisites

1. `$ZELLIJ_SESSION_NAME` must be set (you must be in a Zellij terminal)
2. Hotwired desktop app must be running

If either fails: "Restart Claude in Zellij with desktop app running."

## Execution

### 1. Gather Context

```bash
echo $ZELLIJ_SESSION_NAME   # Must be set
pwd                          # Your project directory
hotwired status              # Check if already in a run
```

### 2. Resolve the Document

**If user provided a file path:**
- Verify the file exists (use `ls` or `Read` tool)
- Use the full relative path from project root (e.g., `docs/features/auth.md`, NOT just `auth.md`)

**If user provided a description (e.g., "the auth PRD"):**
- Search for matching files:
  ```bash
  # Look in common doc locations
  ls docs/ specs/ 2>/dev/null
  ```
- Use `Glob` tool to find matches (e.g., `**/*auth*.md`, `**/*prd*.md`)
- If multiple matches, ask the user which one

**If no argument:**
- Ask the user which document to open

### 3A. NOT in a Run → Create New Run

If `hotwired status` shows no active run:

```bash
hotwired hotwire --project "$PWD" --intent "Open and edit <filename>" --playbook "doc-open"
```

Then follow the returned protocol. It will instruct you to:
1. Run `hotwired artifact sync <path>` to register the file
2. Use `Read` to load the content
3. Wait for user direction on what to review or change

### 3B. ALREADY in a Run → Open in Existing Run

If `hotwired status` shows you're attached to a run:

**Step 1: Fetch the editor protocol**

```bash
hotwired protocol --playbook doc-open --role editor
```

This returns editor protocol instructions (how to use artifact tools, editing workflow, comment handling). **Read the output carefully** — it is your guide for document editing, just like `/hotwire` and `/pair` return protocol instructions.

**Step 2: Register the document as a tracked artifact**

```bash
hotwired artifact sync <path>
```

**Step 3: Read the document**

Use the `Read` tool to load the file content.

**Step 4: Follow the editor protocol**

The protocol instructions from Step 1 tell you exactly how to work with the document — editing, syncing versions, adding/resolving comments. Follow them.

**Step 5: Tell the user the document is ready**

Summarize the document (length, sections, key topics) and ask what they'd like to do:
- Review specific sections
- Make edits
- Add comments
- Get a critique

## After Opening

Your protocol instructions (from `/hotwire` response or `hotwired protocol --playbook doc-open --role editor`) tell you everything you need. Key commands for quick reference:
- `hotwired artifact sync <path>` - Snapshot after edits
- `hotwired artifact comment add <path> "<text>" "<msg>"` - Add anchored comment
- `hotwired artifact resolve <id> [--reply "<msg>"]` - Resolve a comment
- `hotwired status` - Check run state
