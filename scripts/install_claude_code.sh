#!/bin/bash
# =============================================================================
# install_claude_code.sh
# Installs Node.js and Claude Code CLI inside Agent Zero Docker container
# Usage: bash scripts/install_claude_code.sh
# =============================================================================

set -e

echo "[1/4] Checking for Node.js..."
if command -v node &> /dev/null; then
    echo "✅ Node.js already installed: $(node --version)"
else
    echo "⬇️  Installing Node.js 20.x LTS..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt-get install -y nodejs
    echo "✅ Node.js installed: $(node --version)"
fi

echo "[2/4] Checking for npm..."
if command -v npm &> /dev/null; then
    echo "✅ npm available: $(npm --version)"
else
    echo "❌ npm not found. Check Node.js installation."
    exit 1
fi

echo "[3/4] Installing Claude Code CLI globally..."
npm install -g @anthropic-ai/claude-code
echo "✅ Claude Code installed: $(claude --version)"

echo "[4/4] Verifying API key is set..."
if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "⚠️  WARNING: ANTHROPIC_API_KEY is not set."
    echo "   Set it with: export ANTHROPIC_API_KEY=your-key-here"
    echo "   Or configure OpenRouter: export ANTHROPIC_BASE_URL=https://openrouter.ai/api"
else
    echo "✅ ANTHROPIC_API_KEY is set (length: $(echo $ANTHROPIC_API_KEY | wc -c) chars)"
fi

echo ""
echo "============================================"
echo " Claude Code installation complete!"
echo " Test with: claude --print \"Hello world\""
echo "============================================"
