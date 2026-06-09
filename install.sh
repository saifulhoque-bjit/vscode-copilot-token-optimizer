#!/usr/bin/env bash
# VS Code Copilot Token Optimizer + Karpathy's Coding Guidelines
# One-command install: curl -fsSL https://raw.githubusercontent.com/saifulhoque-bjit/vscode-copilot-token-optimizer/main/install.sh | bash
set -e

REPO="saifulhoque-bjit/vscode-copilot-token-optimizer"
BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/$REPO/$BRANCH"

echo ""
echo "============================================================"
echo "  VS Code Copilot Token Optimizer + Karpathy's Guidelines"
echo "============================================================"
echo ""
echo "  Reduce GitHub Copilot token usage by 30-60%"
echo "  Plus clean coding principles from Andrej Karpathy"
echo ""
echo "============================================================"
echo ""

# Detect VS Code user data path
if [[ "$OSTYPE" == "darwin"* ]]; then
    VSCODE_USER_DATA="$HOME/Library/Application Support/Code/User"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    VSCODE_USER_DATA="$HOME/.config/Code/User"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    VSCODE_USER_DATA="$APPDATA/Code/User"
else
    VSCODE_USER_DATA="$HOME/.config/Code/User"
fi

VSCODE_PROMPTS_DIR="$VSCODE_USER_DATA/prompts"
SKILLS_DIR="$HOME/.copilot/skills/optimize"

echo "[1/4] Installing Karpathy's coding guidelines (global)..."
mkdir -p "$VSCODE_PROMPTS_DIR"
curl -fsSL "$BASE_URL/KARPATHY_SKILL.md" -o "$VSCODE_PROMPTS_DIR/global.instructions.md"
echo "      Saved to: $VSCODE_PROMPTS_DIR/global.instructions.md"
echo "      Done!"

echo "[2/4] Creating .github directory..."
mkdir -p .github

echo "[3/4] Installing Copilot custom instructions..."
curl -fsSL "$BASE_URL/copilot-instructions.md" -o ".github/copilot-instructions.md"
echo "      Saved to: .github/copilot-instructions.md"
echo "      Done!"

echo "[4/4] Installing /optimize slash command..."
mkdir -p "$SKILLS_DIR"
curl -fsSL "$BASE_URL/skills/optimize/SKILL.md" -o "$SKILLS_DIR/SKILL.md"
curl -fsSL "$BASE_URL/skills/optimize/compress_context.py" -o "$SKILLS_DIR/compress_context.py"
echo "      Saved to: $SKILLS_DIR/"
echo "      Done!"

# Summary
echo ""
echo "============================================================"
echo "  INSTALLATION COMPLETE"
echo "============================================================"
echo ""
echo "  Files installed:"
echo "    Global: $VSCODE_PROMPTS_DIR/global.instructions.md"
echo "    Project: .github/copilot-instructions.md"
echo "    Skill:   $SKILLS_DIR/"
echo ""
echo "  Quick Start:"
echo "    1. Restart VS Code"
echo "    2. In Copilot Chat, type: /optimize"
echo "    3. Code normally. Every file question auto-compresses."
echo ""
echo "  SAVINGS: 30-60% fewer tokens per Copilot interaction"
echo ""
echo "============================================================"
echo "  GitHub: https://github.com/$REPO"
echo "============================================================"
echo ""
