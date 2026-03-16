# Agent Zero Skill: Claude Code Delegation

## Skill Name
`claude_code_delegate`

## Purpose
Delegate complex coding tasks from Agent Zero to Claude Code CLI for higher-quality code generation, debugging, refactoring, and review.

## When to Use This Skill
- Writing new Python, JavaScript, Bash, or other code from scratch
- Debugging or fixing errors in existing code
- Refactoring code for readability or performance
- Writing unit tests for existing functions
- Code review and security analysis
- Multi-file code changes within a project directory

## When NOT to Use This Skill
- Simple one-liner bash commands (use terminal directly)
- Non-coding tasks (web search, file management, reasoning)
- When ANTHROPIC_API_KEY is not available

---

## Invocation Patterns

### Pattern 1: Single Prompt, Inline Code
```bash
claude --print "[YOUR CODING INSTRUCTION HERE]"
```

### Pattern 2: Code from File
```bash
claude --print "[INSTRUCTION]: $(cat /path/to/file.py)"
```

### Pattern 3: JSON Output (for Agent Zero to parse)
```bash
claude --output-format json --print "[INSTRUCTION]"
```

### Pattern 4: Full Project Directory Context
```bash
claude --print --add-dir /path/to/project "[INSTRUCTION]"
```

### Pattern 5: Pipe output to file
```bash
claude --print "Write a Python function that does X" > /tmp/output.py
```

---

## Agent Zero Decision Tree

```
Task received
    │
    ├── Is it a coding task? ──No──▶ Handle with Agent Zero + OpenRouter directly
    │
    └── Yes
          │
          ├── Is ANTHROPIC_API_KEY set? ──No──▶ Attempt OpenRouter ANTHROPIC_BASE_URL fallback
          │
          └── Yes
                │
                └── Invoke: claude --print "[task]" ──▶ Capture output ──▶ Return to user
```

---

## Example Usage by Agent Zero

**User asks:** "Write a Python script that monitors a directory for new files and logs them"

**Agent Zero executes:**
```bash
claude --print "Write a complete Python script that monitors a directory for new files using watchdog, logs each new file with timestamp to a log file, and accepts the target directory and log path as command-line arguments. Include error handling and comments." > /workspace/file_monitor.py
```

**Agent Zero then:** reads `/workspace/file_monitor.py`, reviews it, and returns to user.

---

## Environment Variables Required

| Variable | Required | Description |
|---|---|---|
| `ANTHROPIC_API_KEY` | Yes | Anthropic or OpenRouter API key |
| `ANTHROPIC_BASE_URL` | Optional | Set to `https://openrouter.ai/api` to use OpenRouter |

---

## Troubleshooting

| Error | Likely Cause | Fix |
|---|---|---|
| `command not found: claude` | Claude Code not installed | Run `scripts/install_claude_code.sh` |
| `401 Unauthorized` | Bad or missing API key | Check `ANTHROPIC_API_KEY` env var |
| `claude: interactive mode` | Missing `--print` flag | Always use `claude --print` for non-interactive |
| Timeout | Large code context | Break task into smaller chunks |
