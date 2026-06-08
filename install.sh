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

# Create prompts directory if it doesn't exist
echo "[1/1] Creating global Karpathy instructions..."
mkdir -p "$VSCODE_PROMPTS_DIR"

# Download Karpathy instructions to VS Code user prompts folder
curl -fsSL "$BASE_URL/KARPATHY_SKILL.md" -o "$VSCODE_PROMPTS_DIR/global.instructions.md"
echo "      Saved to: $VSCODE_PROMPTS_DIR/global.instructions.md"
echo "      Done!"
echo ""

# Summary
echo "============================================================"
echo "  INSTALLATION COMPLETE!"
echo "============================================================"
echo ""
echo "  File installed:"
echo "    $VSCODE_PROMPTS_DIR/global.instructions.md"
echo ""
echo "  How it works:"
echo "    - global.instructions.md is loaded GLOBALLY by VS Code"
echo "    - It applies to ALL projects automatically"
echo "    - Copilot will follow Karpathy's coding principles"
echo ""
echo "  Quick Start:"
echo "    1. Restart VS Code"
echo '    2. Use concise prompts: "Sum even nums. Handle edge cases."'
echo ""
echo "  SAVINGS: 30-60% fewer tokens per Copilot interaction"
echo ""
echo "============================================================"
echo "  GitHub: https://github.com/$REPO"
echo "============================================================"
echo ""
