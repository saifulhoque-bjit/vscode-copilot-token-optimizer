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

REM VS Code global prompts folder
set "PROMPTS_DIR=%APPDATA%\Code\User\prompts"
set "SKILLS_DIR=%USERPROFILE%\.copilot\skills\optimize"

REM Install Karpathy's coding guidelines to VS Code global prompts
echo [1/3] Installing Karpathy's coding guidelines (global)...
if not exist "%PROMPTS_DIR%" (
    mkdir "%PROMPTS_DIR%"
)
copy /Y KARPATHY_SKILL.md "%PROMPTS_DIR%\global.instructions.md" >nul
echo       Installed to: %PROMPTS_DIR%\global.instructions.md
echo       Done!

REM Install /optimize skill to global Copilot skills folder
echo [2/3] Installing /optimize skill...
if not exist "%SKILLS_DIR%" (
    mkdir "%SKILLS_DIR%"
)
copy /Y skills\optimize\SKILL.md "%SKILLS_DIR%\SKILL.md" >nul
copy /Y skills\optimize\compress_context.py "%SKILLS_DIR%\compress_context.py" >nul
echo       Installed to: %SKILLS_DIR%\
echo       Done!

REM Summary
echo [3/3] Installation Complete!
echo.
echo ============================================================
echo   WHAT WAS INSTALLED
echo ============================================================
echo.
echo   [/optimize Skill]
echo     %SKILLS_DIR%\
echo       SKILL.md            - /optimize slash command
echo       compress_context.py - compression script
echo.
echo   [Karpathy's Coding Guidelines]
echo     %PROMPTS_DIR%\global.instructions.md
echo       - Installed globally (applies to ALL projects)
echo       - Simplicity first, readability over cleverness
echo       - Minimal dependencies, self-contained code
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
echo ============================================================
echo   SAVINGS: 30-60%% fewer tokens per Copilot interaction
echo ============================================================
echo.
pause
