# Agent Zero + Claude Code Integration

> **Project Owner:** wasumiro  
> **Created:** 2026-03-16  
> **Status:** 🟡 In Planning

## Overview

This project defines the architecture, specifications, and step-by-step implementation plan for integrating **Claude Code CLI** into an **Agent Zero** Docker container instance. The goal is to create a hybrid agentic workflow where:

- **Agent Zero** (via OpenRouter) handles orchestration, browsing, file management, and general reasoning
- **Claude Code CLI** runs as a subordinate coding agent inside the same Docker container, invoked by Agent Zero for complex programming tasks
- **GitHub** (this repository) serves as the handoff medium between the planning phase (human + AI architect) and the execution phase (Agent Zero)

## Repository Structure

```
/
├── README.md                   # This file — project overview and status
├── SPECS.md                    # Full technical specifications
├── TASKS.md                    # Executable task list for Agent Zero
├── scripts/
│   ├── install_claude_code.sh  # Shell script to install Claude Code in container
│   └── test_integration.sh     # Validation/smoke test script
└── agent_zero_skills/
    └── claude_code_skill.md    # Agent Zero skill definition for invoking Claude Code
```

## Workflow Model

```
[Larry / Perplexity]  →  GitHub (specs + tasks)  →  [Agent Zero reads repo]
                                                            ↓
                                                   Executes TASKS.md
                                                            ↓
                                                   Installs Claude Code
                                                            ↓
                                                   Updates task status in GitHub
```

## Quick Start for Agent Zero

1. Read `TASKS.md` for the current task list
2. Execute tasks in order, checking off each one
3. Update task status back to this repo when complete
4. Report any blockers as GitHub Issues

## Related Links
- [Agent Zero GitHub](https://github.com/agent0ai/agent-zero)
- [Claude Code Docs](https://docs.anthropic.com/claude-code)
- [OpenRouter Claude Code Integration](https://openrouter.ai/docs/guides/guides/coding-agents/claude-code-integration)
