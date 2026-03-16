# Technical Specifications: Claude Code + Agent Zero Integration

**Version:** 1.0.0  
**Date:** 2026-03-16  
**Status:** Draft

---

## 1. Environment Overview

### 1.1 Agent Zero Docker Container
- Base image: `frdel/agent-zero-run` (or equivalent current tag)
- OS: Debian/Ubuntu-based Linux
- Agent Zero communicates via internal REST API (default port 0.0.0.0:50001)
- Container has full terminal/bash access, Python 3.x, pip, and git pre-installed

### 1.2 Claude Code CLI Requirements
- Runtime: Node.js >= 18.x and npm
- Package: `@anthropic-ai/claude-code` (global npm install)
- Authentication: Anthropic API key OR OpenRouter via `ANTHROPIC_BASE_URL` override
- Execution mode for Agent Zero: non-interactive (`--print` flag or `--output-format json`)

---

## 2. Integration Architecture

```
┌─────────────────────────────────────────────────┐
│              Agent Zero Docker Container         │
│                                                  │
│  ┌──────────────┐      ┌─────────────────────┐  │
│  │  Agent Zero  │─────▶│  Claude Code CLI    │  │
│  │  (OpenRouter)│      │  (@anthropic-ai/    │  │
│  │              │◀─────│   claude-code)      │  │
│  └──────────────┘      └─────────────────────┘  │
│         │                        │               │
│         ▼                        ▼               │
│    Web/Files/Tools          Code Execution       │
│    General Reasoning        Git Operations       │
│    Orchestration            Multi-file Edits     │
└─────────────────────────────────────────────────┘
         │
         ▼
    GitHub Repo (this repo)
    - Read task specs
    - Update task status
    - Report issues
```

---

## 3. Authentication Strategy

### Option A: Direct Anthropic API Key (Recommended for quality)
```bash
export ANTHROPIC_API_KEY="your-key-here"
claude --print "your prompt"
```

### Option B: OpenRouter as Backend (Unified billing)
```bash
export ANTHROPIC_API_KEY="your-openrouter-key"
export ANTHROPIC_BASE_URL="https://openrouter.ai/api"
claude --print "your prompt"
```
This lets both Agent Zero and Claude Code route through the same OpenRouter account.

---

## 4. Agent Zero Invocation Pattern

Agent Zero will invoke Claude Code using its `code_execution_tool` or `terminal` tool:

```bash
# Non-interactive single prompt
claude --print "Refactor this Python function to handle edge cases: $(cat myfile.py)"

# JSON output for Agent Zero to parse
claude --output-format json --print "Review this code and list bugs"

# With working directory context
claude --print --add-dir /path/to/project "Add error handling to all functions"
```

### Agent Zero Prompt Template for Delegation
When Agent Zero detects a coding task, it should use this handoff pattern:

```
Task Type: [code_generation | code_review | refactor | debug | test_writing]
Context: [file paths, project description]
Instruction: [specific coding task]
Output Expected: [file to create/modify, or stdout response]
```

---

## 5. GitHub Integration for Agent Zero

Agent Zero will use its built-in tools + git CLI to:

1. **Clone this repo** into its working directory
2. **Read TASKS.md** to get current task list and status
3. **Execute tasks** one by one
4. **Update TASKS.md** by checking off completed items and pushing back
5. **Open GitHub Issues** for any blockers encountered

### Required git config inside container:
```bash
git config --global user.name "Agent Zero"
git config --global user.email "agent@agent-zero-instance"
```
A GitHub Personal Access Token (PAT) must be available as `GITHUB_TOKEN` env var.

---

## 6. Security Considerations

- All execution is sandboxed inside the Docker container
- API keys stored as Docker environment variables, never hardcoded
- GitHub PAT should have minimum required scopes: `repo` (read/write to this repo only)
- Claude Code should be invoked with `--disallow-todos` and limited directory access in production
- Recommended: Run Agent Zero container with `--read-only` filesystem mounts except for working directory

---

## 7. Success Criteria

- [ ] Claude Code CLI successfully installed inside Agent Zero container
- [ ] Agent Zero can invoke `claude --print` and capture output
- [ ] Agent Zero can read and parse TASKS.md from this GitHub repo
- [ ] Agent Zero can push task status updates back to GitHub
- [ ] End-to-end test: Agent Zero delegates a Python coding task to Claude Code and returns result
