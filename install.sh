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

echo "[1/3] Installing Karpathy's coding guidelines (global)..."
mkdir -p "$VSCODE_PROMPTS_DIR"
curl -fsSL "$BASE_URL/KARPATHY_SKILL.md" -o "$VSCODE_PROMPTS_DIR/global.instructions.md"
echo "      Saved to: $VSCODE_PROMPTS_DIR/global.instructions.md"
echo "      Done!"

echo "[2/3] Installing /optimize skill..."
mkdir -p "$SKILLS_DIR"
curl -fsSL "$BASE_URL/skills/optimize/SKILL.md" -o "$SKILLS_DIR/SKILL.md"
curl -fsSL "$BASE_URL/skills/optimize/compress_context.py" -o "$SKILLS_DIR/compress_context.py"
echo "      Saved to: $SKILLS_DIR/"
echo "      Done!"

echo "[3/3] Installation Complete!"
echo ""
echo "============================================================"
echo "  WHAT WAS INSTALLED"
echo "============================================================"
echo ""
echo "  [/optimize Skill]"
echo "    $SKILLS_DIR/"
echo "      SKILL.md            — /optimize slash command"
echo "      compress_context.py — compression script"
echo ""
echo "  [Karpathy's Coding Guidelines]"
echo "    $VSCODE_PROMPTS_DIR/global.instructions.md"
echo "      — Installed globally (applies to ALL projects)"
echo "      — Simplicity first, readability over cleverness"
echo ""
echo "============================================================"
echo "  QUICK START"
echo "============================================================"
echo ""
echo "  1. Restart VS Code to load the new skill"
echo "  2. In Copilot Chat, type: /optimize"
echo "  3. Code normally. Every file question auto-compresses."
echo ""
echo "  SAVINGS: 30-60% fewer tokens per Copilot interaction"
echo ""
echo "============================================================"
echo "  GitHub: https://github.com/$REPO"
echo "============================================================"
echo ""
