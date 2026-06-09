@echo off
REM VS Code Copilot Token Optimizer + Karpathy's Coding Guidelines
REM Usage: install.bat

echo.
echo ============================================================
echo   VS Code Copilot Token Optimizer + Karpathy's Guidelines
echo ============================================================
echo.
echo   Reduce GitHub Copilot token usage by 30-60%%
echo   Plus clean coding principles from Andrej Karpathy
echo.
echo ============================================================
echo.

REM Check if .github directory exists
if not exist ".github" (
    echo [1/6] Creating .github directory...
    mkdir .github
) else (
    echo [1/6] .github directory exists
)

REM Check if .github/prompts directory exists
if not exist ".github\prompts" (
    echo [2/6] Creating .github\prompts directory...
    mkdir .github\prompts
) else (
    echo [2/6] .github\prompts directory exists
)

REM Copy custom instructions
echo [3/6] Installing Copilot custom instructions...
if exist ".github\copilot-instructions.md" (
    echo       .github\copilot-instructions.md already exists
    set /p overwrite="       Overwrite? (y/N): "
    if /i "%overwrite%"=="y" (
        copy /Y copilot-instructions.md .github\
        echo       Done!
    ) else (
        echo       Skipped
    )
) else (
    copy copilot-instructions.md .github\
    echo       Done!
)

REM Copy Karpathy's coding guidelines
echo [4/6] Installing Karpathy's coding guidelines...
if exist ".github\karpathy-guidelines.md" (
    echo       .github\karpathy-guidelines.md already exists
    set /p overwrite2="       Overwrite? (y/N): "
    if /i "%overwrite2%"=="y" (
        copy /Y KARPATHY_SKILL.md .github\karpathy-guidelines.md
        echo       Done!
    ) else (
        echo       Skipped
    )
) else (
    copy KARPATHY_SKILL.md .github\karpathy-guidelines.md
    echo       Done!
)

REM Copy prompt files (slash commands)
echo [5/6] Installing /optimize slash command...
copy /Y .github\prompts\*.prompt.md .github\prompts\ 2>nul
if errorlevel 1 (
    echo       Prompt files already in place
) else (
    echo       Done!
)

REM Copy VS Code settings
echo [6/6] VS Code Settings
echo       Add these to your VS Code settings.json:
echo.
type settings.json
echo.

REM Summary
echo [6/6] Installation Complete!
echo.
echo ============================================================
echo   WHAT WAS INSTALLED
echo ============================================================
echo.
echo   [Copilot Optimization]
echo     .github\copilot-instructions.md
echo       - Concise prompting (3-5 sentences max)
echo       - Structured output (JSON, tables)
echo       - Token saving patterns
echo.
echo   [Slash Command]
echo     .github\prompts\optimize.prompt.md    → /optimize (all 3, full session)
echo.
echo   [Karpathy's Coding Guidelines]
echo     .github\karpathy-guidelines.md
echo       - Simplicity first
echo       - Readability over cleverness
echo       - Minimal dependencies
echo       - Self-contained code
echo.
echo   [VS Code Settings]
echo     - Response length limit (500 tokens)
echo     - Custom instructions enabled
echo     - Reduced context window
echo.
echo ============================================================
echo   QUICK START
echo ============================================================
echo.
echo   1. Restart VS Code to load custom instructions
echo.
echo   2. Use concise prompts:
echo      BEFORE: "Can you please help me write a function..."
echo      AFTER:  "Write function: sum even numbers in list."
echo.
echo   3. Compress code before asking:
echo      python scripts\compress_context.py myfile.py
echo.
echo   4. Use /optimize in Copilot Chat:
echo      /optimize              ← enables all 3 optimizations for the whole session
echo.
echo   5. Check Karpathy's guidelines:
echo      type .github\karpathy-guidelines.md
echo.
echo ============================================================
echo   SAVINGS: 30-60%% fewer tokens per Copilot interaction
echo ============================================================
echo.
pause
