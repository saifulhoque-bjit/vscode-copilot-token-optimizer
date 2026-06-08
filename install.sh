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

# Create .github directory
echo "[1/4] Creating .github directory..."
mkdir -p .github

# Download copilot-instructions.md
echo "[2/4] Downloading Copilot custom instructions..."
curl -fsSL "$BASE_URL/copilot-instructions.md" -o .github/copilot-instructions.md
echo "      Done!"

# Download Karpathy's coding guidelines
echo "[3/4] Downloading Karpathy's coding guidelines..."
curl -fsSL "$BASE_URL/KARPATHY_SKILL.md" -o .github/KARPATHY_SKILL.md
echo "      Done!"

# Show VS Code settings
echo "[4/4] VS Code Settings"
echo "      Add these to your VS Code settings.json:"
echo ""
echo '      {'
echo '        "github.copilot.advanced.length": 500,'
echo '        "github.copilot.chat.codeGeneration.useInstructionFiles": true,'
echo '        "github.copilot.advanced.inlineSuggestCount": 3'
echo '      }'
echo ""

# Summary
echo "============================================================"
echo "  INSTALLATION COMPLETE!"
echo "============================================================"
echo ""
echo "  Files installed:"
echo "    .github/copilot-instructions.md  (token optimization + loads Karpathy)"
echo "    .github/KARPATHY_SKILL.md        (Karpathy's coding principles)"
echo ""
echo "  Quick Start:"
echo "    1. Restart VS Code"
echo '    2. Use concise prompts: "Sum even nums. Handle edge cases."'
echo "    3. Check guidelines: cat .github/karpathy-guidelines.md"
echo ""
echo "  SAVINGS: 30-60% fewer tokens per Copilot interaction"
echo ""
echo "============================================================"
echo "  GitHub: https://github.com/$REPO"
echo "============================================================"
echo ""
