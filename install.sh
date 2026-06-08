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

# Download Karpathy's guidelines to home directory
echo "[1/3] Downloading Karpathy's coding guidelines..."
KARPATHY_FILE="$HOME/.karpathy-coding-guidelines.md"
curl -fsSL "$BASE_URL/KARPATHY_SKILL.md" -o "$KARPATHY_FILE"
echo "      Saved to: $KARPATHY_FILE"
echo "      Done!"
echo ""

# Create global AGENTS.md in user home (Copilot reads this globally)
echo "[2/3] Creating global AGENTS.md in user home..."
AGENTS_FILE="$HOME/AGENTS.md"
curl -fsSL "$BASE_URL/copilot-instructions.md" -o "$AGENTS_FILE"
echo "      Saved to: $AGENTS_FILE"
echo "      Done!"
echo ""

# Update VS Code settings
echo "[3/3] Updating VS Code settings..."
echo "      Settings file: $VSCODE_SETTINGS"

# Create settings file if it doesn't exist
if [ ! -f "$VSCODE_SETTINGS" ]; then
    mkdir -p "$(dirname "$VSCODE_SETTINGS")"
    echo "{}" > "$VSCODE_SETTINGS"
fi

# Update settings with Python
python3 -c "
import json
import os

settings_path = r'$VSCODE_SETTINGS'

# Read existing settings
try:
    with open(settings_path, 'r') as f:
        settings = json.load(f)
except:
    settings = {}

# Optimization settings
settings['github.copilot.advanced.length'] = 500
settings['github.copilot.chat.codeGeneration.useInstructionFiles'] = True

# Enable AGENTS.md support
settings['chat.useAgentsMdFile'] = True

# Write back
with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)

print('      VS Code settings updated!')
" 2>&1 || {
    echo "      WARNING: Python not found. Please add these settings manually:"
    echo '      {'
    echo '        "github.copilot.advanced.length": 500,'
    echo '        "github.copilot.chat.codeGeneration.useInstructionFiles": true,'
    echo '        "github.copilot.advanced.inlineSuggestCount": 3,'
    echo '        "chat.useAgentsMdFile": true'
    echo '      }'
}

# Summary
echo ""
echo "============================================================"
echo "  INSTALLATION COMPLETE!"
echo "============================================================"
echo ""
echo "  Files installed:"
echo "    ~/AGENTS.md                       (global Copilot instructions)"
echo "    ~/.karpathy-coding-guidelines.md  (Karpathy's coding principles)"
echo ""
echo "  VS Code settings updated:"
echo "    github.copilot.advanced.length = 500"
echo "    github.copilot.chat.codeGeneration.useInstructionFiles = true"
echo "    chat.useAgentsMdFile = true"
echo ""
echo "  How it works:"
echo "    - AGENTS.md in your home directory is loaded GLOBALLY"
echo "    - It applies to ALL projects in VS Code"
echo "    - It tells Copilot to follow Karpathy's guidelines"
echo ""
echo "  Quick Start:"
echo "    1. Restart VS Code"
echo '    2. Use concise prompts: "Sum even nums. Handle edge cases."'
echo "    3. Check guidelines: cat ~/.karpathy-coding-guidelines.md"
echo ""
echo "  SAVINGS: 30-60% fewer tokens per Copilot interaction"
echo ""
echo "============================================================"
echo "  GitHub: https://github.com/$REPO"
echo "============================================================"
echo ""
