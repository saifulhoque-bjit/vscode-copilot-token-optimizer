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

# Ask user for project path
echo "Where should the Copilot instructions be installed?"
echo ""
echo "  [1] Current directory ($(pwd))"
echo "  [2] Specific project path"
echo "  [3] All projects in a directory (scan for .git folders)"
echo ""
read -p "Choose option (1/2/3) [default: 1]: " OPTION
OPTION=${OPTION:-1}

PROJECT_PATHS=()

case $OPTION in
    1)
        PROJECT_PATHS=("$(pwd)")
        ;;
    2)
        read -p "Enter project path: " CUSTOM_PATH
        if [ ! -d "$CUSTOM_PATH" ]; then
            echo "Error: Directory not found: $CUSTOM_PATH"
            exit 1
        fi
        PROJECT_PATHS=("$CUSTOM_PATH")
        ;;
    3)
        read -p "Enter parent directory to scan: " PARENT_PATH
        if [ ! -d "$PARENT_PATH" ]; then
            echo "Error: Directory not found: $PARENT_PATH"
            exit 1
        fi
        # Find all directories with .git (git repos)
        while IFS= read -r dir; do
            PROJECT_PATHS+=("$(dirname "$dir")")
        done < <(find "$PARENT_PATH" -maxdepth 2 -name ".git" -type d 2>/dev/null)
        
        if [ ${#PROJECT_PATHS[@]} -eq 0 ]; then
            echo "No git repositories found in $PARENT_PATH"
            exit 1
        fi
        echo "Found ${#PROJECT_PATHS[@]} projects"
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac

echo ""
echo "Installing to ${#PROJECT_PATHS[@]} project(s)..."
echo ""

for PROJECT_PATH in "${PROJECT_PATHS[@]}"; do
    echo "------------------------------------------------------------"
    echo "  Project: $PROJECT_PATH"
    echo "------------------------------------------------------------"
    
    # Create .github directory
    echo "  [1/3] Creating .github directory..."
    mkdir -p "$PROJECT_PATH/.github"

    # Download copilot-instructions.md
    echo "  [2/3] Downloading Copilot custom instructions..."
    curl -fsSL "$BASE_URL/copilot-instructions.md" -o "$PROJECT_PATH/.github/copilot-instructions.md"
    echo "        Done!"

    # Download Karpathy's coding guidelines
    echo "  [3/3] Downloading Karpathy's coding guidelines..."
    curl -fsSL "$BASE_URL/KARPATHY_SKILL.md" -o "$PROJECT_PATH/.github/KARPATHY_SKILL.md"
    echo "        Done!"
    echo ""
done

# Update VS Code settings
echo "------------------------------------------------------------"
echo "  Updating VS Code settings..."
echo "------------------------------------------------------------"

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
    mkdir -p "$(dirname "$VSCODE_SETTINGS")"
    echo "{}" > "$VSCODE_SETTINGS"
fi

# Update settings with Python
python3 -c "
import json

settings_path = r'$VSCODE_SETTINGS'
try:
    with open(settings_path, 'r') as f:
        settings = json.load(f)
except:
    settings = {}

settings['github.copilot.advanced.length'] = 500
settings['github.copilot.chat.codeGeneration.useInstructionFiles'] = True

with open(settings_path, 'w') as f:
    json.dump(settings, f, indent=2)

print('  VS Code settings updated!')
" 2>&1 || {
    echo "  WARNING: Python not found. Please add these settings manually:"
    echo '  {'
    echo '    "github.copilot.advanced.length": 500,'
    echo '    "github.copilot.chat.codeGeneration.useInstructionFiles": true'
    echo '  }'
}

# Summary
echo ""
echo "============================================================"
echo "  INSTALLATION COMPLETE!"
echo "============================================================"
echo ""
echo "  Projects configured: ${#PROJECT_PATHS[@]}"
for PROJECT_PATH in "${PROJECT_PATHS[@]}"; do
    echo "    - $PROJECT_PATH"
done
echo ""
echo "  Files installed per project:"
echo "    .github/copilot-instructions.md  (token optimization + loads Karpathy)"
echo "    .github/KARPATHY_SKILL.md        (Karpathy's coding principles)"
echo ""
echo "  VS Code settings updated:"
echo "    github.copilot.advanced.length = 500"
echo "    github.copilot.chat.codeGeneration.useInstructionFiles = true"
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
