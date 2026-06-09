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
    echo [1/5] Creating .github directory...
    mkdir .github
) else (
    echo [1/5] .github directory exists
)

REM Copy custom instructions
echo [2/5] Installing Copilot custom instructions...
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
echo [3/5] Installing Karpathy's coding guidelines...
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

REM Install /optimize skill to global Copilot skills folder
echo [4/5] Installing /optimize slash command...
set "SKILLS_DIR=%USERPROFILE%\.copilot\skills\optimize"
if not exist "%SKILLS_DIR%" (
    mkdir "%SKILLS_DIR%"
)
copy /Y skills\optimize\SKILL.md "%SKILLS_DIR%\SKILL.md" >nul
echo       Installed to: %SKILLS_DIR%\SKILL.md
echo       Done!

REM Copy VS Code settings
echo [5/5] VS Code Settings
echo       Add these to your VS Code settings.json:
echo.
if exist settings.json type settings.json
echo.

REM Summary
echo.
echo ============================================================
echo   INSTALLATION COMPLETE
echo ============================================================
echo.
echo   [Copilot Custom Instructions]
echo     .github\copilot-instructions.md
echo       - Concise prompting (3-5 sentences max)
echo       - Structured output (JSON, tables)
echo       - Token saving patterns
echo.
echo   [/optimize Slash Command]
echo     %USERPROFILE%\.copilot\skills\optimize\SKILL.md
echo       - /optimize in Copilot Chat activates all 3 optimizations
echo       - Compress: auto-extract signatures before answering
echo       - Cache-Align: static prefix, dynamic suffix
echo       - CCR: answer from signatures, retrieve on demand
echo.
echo   [Karpathy's Coding Guidelines]
echo     .github\karpathy-guidelines.md
echo       - Simplicity first
echo       - Readability over cleverness
echo       - Minimal dependencies
echo       - Self-contained code
echo.
echo ============================================================
echo   QUICK START
echo ============================================================
echo.
echo   1. Restart VS Code to load the new skill
echo.
echo   2. In Copilot Chat, type:
echo      /optimize
echo.
echo   3. Then code normally. Every file question auto-compresses.
echo.
echo   4. Use concise prompts:
echo      BEFORE: "Can you please help me write a function..."
echo      AFTER:  "Write function: sum even numbers in list."
echo.
echo ============================================================
echo   SAVINGS: 30-60%% fewer tokens per Copilot interaction
echo ============================================================
echo.
pause
