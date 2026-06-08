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
echo "[1/5] Creating .github directory..."
mkdir -p .github

# Download copilot-instructions.md
echo "[2/5] Downloading Copilot custom instructions..."
curl -fsSL "$BASE_URL/copilot-instructions.md" -o .github/copilot-instructions.md
echo "      Done!"

# Download Karpathy's coding guidelines
echo "[3/5] Downloading Karpathy's coding guidelines..."
curl -fsSL "$BASE_URL/KARPATHY_SKILL.md" -o .github/KARPATHY_SKILL.md
echo "      Done!"

# Update VS Code settings
echo "[4/5] Updating VS Code settings..."

# Detect VS Code settings path
if [[ "$OSTYPE" == "darwin"* ]]; then
    VSCODE_SETTINGS="$HOME/Library/Application Support/Code/User/settings.json"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
    VSCODE_SETTINGS="$APPDATA/Code/User/settings.json"
else
    VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json"
fi

# Create settings file if it doesn't exist
if [ ! -f "$VSCODE_SETTINGS" ]; then
    echo "{}" > "$VSCODE_SETTINGS"
fi

# Check if python3 is available for JSON merging
if command -v python3 &> /dev/null; then
    python3 -c "
import json
import sys

settings_path = '$VSCODE_SETTINGS'
try:
    with open(settings_path, 'r') as f:
        settings = json.load(f)
except:
    settings = {}

settings['github.copilot.advanced.length'] = 500
settings['github.copilot.chat.codeGeneration.useInstructionFiles'] = True
settings['github.copilot.advanced.inlineSuggestCount'] = 3

with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)

print('      VS Code settings updated!')
"
elif command -v python &> /dev/null; then
    python -c "
import json
import sys

settings_path = '$VSCODE_SETTINGS'
try:
    with open(settings_path, 'r') as f:
        settings = json.load(f)
except:
    settings = {}

settings['github.copilot.advanced.length'] = 500
settings['github.copilot.chat.codeGeneration.useInstructionFiles'] = True
settings['github.copilot.advanced.inlineSuggestCount'] = 3

with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)

print('      VS Code settings updated!')
"
else
    echo "      WARNING: Python not found. Please add these settings manually:"
    echo '      {'
    echo '        "github.copilot.advanced.length": 500,'
    echo '        "github.copilot.chat.codeGeneration.useInstructionFiles": true,'
    echo '        "github.copilot.advanced.inlineSuggestCount": 3'
    echo '      }'
fi

# Summary
echo ""
echo "[5/5] Installation Complete!"
echo ""
echo "============================================================"
echo "  WHAT WAS INSTALLED"
echo "============================================================"
echo ""
echo "  Files installed:"
echo "    .github/copilot-instructions.md  (token optimization + loads Karpathy)"
echo "    .github/KARPATHY_SKILL.md        (Karpathy's coding principles)"
echo ""
echo "  VS Code settings updated:"
echo "    github.copilot.advanced.length = 500"
echo "    github.copilot.chat.codeGeneration.useInstructionFiles = true"
echo "    github.copilot.advanced.inlineSuggestCount = 3"
echo ""
echo "  Quick Start:"
echo "    1. Restart VS Code"
echo '    2. Use concise prompts: "Sum even nums. Handle edge cases."'
echo "    3. Check guidelines: cat .github/KARPATHY_SKILL.md"
echo ""
echo "  SAVINGS: 30-60% fewer tokens per Copilot interaction"
echo ""
echo "============================================================"
echo "  GitHub: https://github.com/$REPO"
echo "============================================================"
echo ""
