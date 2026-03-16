#!/bin/bash
# =============================================================================
# test_integration.sh
# Smoke test for Claude Code + Agent Zero integration
# Usage: bash scripts/test_integration.sh
# =============================================================================

set -e
PASS=0
FAIL=0

check() {
    if [ $? -eq 0 ]; then
        echo "✅ PASS: $1"
        ((PASS++))
    else
        echo "❌ FAIL: $1"
        ((FAIL++))
    fi
}

echo "=== Agent Zero + Claude Code Integration Test ==="
echo ""

# Test 1: Node.js available
node --version > /dev/null 2>&1
check "Node.js is installed"

# Test 2: npm available
npm --version > /dev/null 2>&1
check "npm is available"

# Test 3: Claude Code CLI installed
claude --version > /dev/null 2>&1
check "Claude Code CLI is installed"

# Test 4: API key set
[ -n "$ANTHROPIC_API_KEY" ]
check "ANTHROPIC_API_KEY environment variable is set"

# Test 5: Claude Code responds
RESPONSE=$(claude --print "Reply with only the words: INTEGRATION TEST SUCCESSFUL" 2>&1)
echo "   Claude response: $RESPONSE"
echo "$RESPONSE" | grep -q "INTEGRATION TEST SUCCESSFUL"
check "Claude Code API call returns expected response"

# Test 6: GitHub token set
[ -n "$GITHUB_TOKEN" ]
check "GITHUB_TOKEN environment variable is set"

# Test 7: git available
git --version > /dev/null 2>&1
check "git is available"

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="

if [ $FAIL -gt 0 ]; then
    exit 1
fi
