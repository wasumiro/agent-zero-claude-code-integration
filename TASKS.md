# Agent Zero Execution Task List

**Project:** Claude Code + Agent Zero Integration  
**Last Updated:** 2026-03-16  
**Instructions for Agent Zero:** Read this file, execute each task in order, update the checkbox status, and push changes back to this repo after each phase is complete.

---

## Phase 1: Environment Verification

- [ ] **TASK-001** — Confirm you are running inside the Agent Zero Docker container (run `uname -a` and `whoami`, report results as a comment in this file)
- [ ] **TASK-002** — Check if Node.js is installed (`node --version`). If not, proceed to TASK-003. If yes, skip to TASK-004.
- [ ] **TASK-003** — Install Node.js 20.x LTS using the NodeSource installer:
  ```bash
  curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
  apt-get install -y nodejs
  ```
- [ ] **TASK-004** — Verify npm is available (`npm --version`) and record version

---

## Phase 2: Claude Code Installation

- [ ] **TASK-005** — Install Claude Code CLI globally:
  ```bash
  npm install -g @anthropic-ai/claude-code
  ```
- [ ] **TASK-006** — Verify installation (`claude --version`) and record version
- [ ] **TASK-007** — Confirm ANTHROPIC_API_KEY environment variable is set (do NOT print the key itself, just confirm it exists with `echo $ANTHROPIC_API_KEY | wc -c`)

---

## Phase 3: Authentication Test

- [ ] **TASK-008** — Run a minimal non-interactive test:
  ```bash
  claude --print "Reply with only the words: INTEGRATION TEST SUCCESSFUL"
  ```
  Record the output. If it matches expected output, mark as complete. If it fails, open a GitHub Issue with the error.

---

## Phase 4: Agent Zero ↔ Claude Code Skill Setup

- [ ] **TASK-009** — Read the skill definition at `agent_zero_skills/claude_code_skill.md`
- [ ] **TASK-010** — Create a test Python file at `/tmp/test_code.py` with a simple buggy function (a function that doesn't handle division by zero)
- [ ] **TASK-011** — Invoke Claude Code to fix the bug:
  ```bash
  claude --print "Fix the division by zero bug in this code: $(cat /tmp/test_code.py)"
  ```
- [ ] **TASK-012** — Save Claude Code's output to `/tmp/test_code_fixed.py` and verify it runs without error

---

## Phase 5: GitHub Integration Validation

- [ ] **TASK-013** — Confirm GITHUB_TOKEN environment variable is set
- [ ] **TASK-014** — Clone this repository into `/tmp/agent-zero-claude-code-integration` using the token
- [ ] **TASK-015** — Update this TASKS.md file: add a comment line below this task with the timestamp and container hostname
- [ ] **TASK-016** — Commit and push the updated TASKS.md back to this repo

---

## Phase 6: Report

- [ ] **TASK-017** — Create a file at `reports/run_001.md` in this repo documenting:
  - Node.js version found/installed
  - Claude Code version installed
  - Authentication test result
  - Integration test result
  - Any errors encountered
  - Timestamp of completion
- [ ] **TASK-018** — Push the report file and mark this project status in README.md as 🟢 Complete

---

## Blockers / Issues

*Agent Zero: If you encounter a blocker, open a GitHub Issue in this repository with the label `blocker` and include the TASK number, error message, and what you tried.*

---

## Status Legend
- [ ] Not started
- [x] Complete
- [~] In progress
- [!] Blocked — see Issues
