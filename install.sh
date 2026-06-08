#!/bin/bash
# VS Code Copilot Token Optimizer + Karpathy's Coding Guidelines
# Usage: bash install.sh

set -e

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

# Check if .github directory exists
if [ ! -d ".github" ]; then
    echo "[1/5] Creating .github directory..."
    mkdir -p .github
else
    echo "[1/5] .github directory exists"
fi

# Copy custom instructions
echo "[2/5] Installing Copilot custom instructions..."
if [ -f ".github/copilot-instructions.md" ]; then
    echo "      .github/copilot-instructions.md already exists"
    read -p "      Overwrite? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp copilot-instructions.md .github/
        echo "      Done!"
    else
        echo "      Skipped"
    fi
else
    cp copilot-instructions.md .github/
    echo "      Done!"
fi

# Copy Karpathy's coding guidelines
echo "[3/5] Installing Karpathy's coding guidelines..."
if [ -f ".github/karpathy-guidelines.md" ]; then
    echo "      .github/karpathy-guidelines.md already exists"
    read -p "      Overwrite? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp karpathy-coding-guidelines.md .github/karpathy-guidelines.md
        echo "      Done!"
    else
        echo "      Skipped"
    fi
else
    cp karpathy-coding-guidelines.md .github/karpathy-guidelines.md
    echo "      Done!"
fi

# Copy VS Code settings
echo "[4/5] VS Code Settings"
echo "      Add these to your VS Code settings.json:"
echo ""
cat settings.json
echo ""

# Summary
echo "[5/5] Installation Complete!"
echo ""
echo "============================================================"
echo "  WHAT WAS INSTALLED"
echo "============================================================"
echo ""
echo "  [Copilot Optimization]"
echo "    .github/copilot-instructions.md"
echo "      - Concise prompting (3-5 sentences max)"
echo "      - Structured output (JSON, tables)"
echo "      - Token saving patterns"
echo ""
echo "  [Karpathy's Coding Guidelines]"
echo "    .github/karpathy-guidelines.md"
echo "      - Simplicity first"
echo "      - Readability over cleverness"
echo "      - Minimal dependencies"
echo "      - Self-contained code"
echo ""
echo "  [VS Code Settings]"
echo "    - Response length limit (500 tokens)"
echo "    - Custom instructions enabled"
echo "    - Reduced context window"
echo ""
echo "============================================================"
echo "  QUICK START"
echo "============================================================"
echo ""
echo "  1. Restart VS Code to load custom instructions"
echo ""
echo "  2. Use concise prompts:"
echo "     BEFORE: \"Can you please help me write a function...\""
echo "     AFTER:  \"Write function: sum even numbers in list.\""
echo ""
echo "  3. Compress code before asking:"
echo "     python scripts/compress_context.py myfile.py"
echo ""
echo "  4. Check Karpathy's guidelines:"
echo "     cat .github/karpathy-guidelines.md"
echo ""
echo "============================================================"
echo "  SAVINGS: 30-60% fewer tokens per Copilot interaction"
echo "============================================================"
echo ""
