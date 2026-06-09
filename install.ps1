# VS Code Copilot Token Optimizer + Karpathy's Coding Guidelines
# One-command install (PowerShell):
#   iwr -useb https://raw.githubusercontent.com/saifulhoque-bjit/vscode-copilot-token-optimizer/main/install.ps1 | iex

$ErrorActionPreference = "Stop"

$Repo = "saifulhoque-bjit/vscode-copilot-token-optimizer"
$Branch = "main"
$BaseUrl = "https://raw.githubusercontent.com/$Repo/$Branch"

Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  VS Code Copilot Token Optimizer + Karpathy's Guidelines" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Reduce GitHub Copilot token usage by 30-60%" -ForegroundColor Green
Write-Host "  Plus clean coding principles from Andrej Karpathy" -ForegroundColor Green
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

$VscPromptsDir = "$env:APPDATA\Code\User\prompts"
$SkillsDir = "$env:USERPROFILE\.copilot\skills\optimize"

Write-Host "[1/3] Installing Karpathy's coding guidelines (global)..." -ForegroundColor Yellow
if (!(Test-Path $VscPromptsDir)) {
    New-Item -ItemType Directory -Path $VscPromptsDir -Force | Out-Null
}
Invoke-WebRequest -Uri "$BaseUrl/KARPATHY_SKILL.md" -OutFile "$VscPromptsDir\global.instructions.md"
Write-Host "      Saved to: $VscPromptsDir\global.instructions.md" -ForegroundColor Gray
Write-Host "      Done!" -ForegroundColor Green

Write-Host "[2/3] Installing /optimize skill..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path $SkillsDir -Force | Out-Null
Invoke-WebRequest -Uri "$BaseUrl/skills/optimize/SKILL.md" -OutFile "$SkillsDir\SKILL.md"
Invoke-WebRequest -Uri "$BaseUrl/skills/optimize/compress_context.py" -OutFile "$SkillsDir\compress_context.py"
Write-Host "      Saved to: $SkillsDir\" -ForegroundColor Gray
Write-Host "      Done!" -ForegroundColor Green

Write-Host "[3/3] Installation Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  WHAT WAS INSTALLED" -ForegroundColor White
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  [/optimize Skill]" -ForegroundColor White
Write-Host "    $SkillsDir\" -ForegroundColor Gray
Write-Host "      SKILL.md            — /optimize slash command" -ForegroundColor Gray
Write-Host "      compress_context.py — compression script" -ForegroundColor Gray
Write-Host ""
Write-Host "  [Karpathy's Coding Guidelines]" -ForegroundColor White
Write-Host "    $VscPromptsDir\global.instructions.md" -ForegroundColor Gray
Write-Host "      — Installed globally (applies to ALL projects)" -ForegroundColor Gray
Write-Host "      — Simplicity first, readability over cleverness" -ForegroundColor Gray
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  QUICK START" -ForegroundColor White
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  1. Restart VS Code to load the new skill" -ForegroundColor Gray
Write-Host "  2. In Copilot Chat, type: /optimize" -ForegroundColor Gray
Write-Host "  3. Code normally. Every file question auto-compresses." -ForegroundColor Gray
Write-Host ""
Write-Host "  SAVINGS: 30-60% fewer tokens per Copilot interaction" -ForegroundColor Green
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  GitHub: https://github.com/$Repo" -ForegroundColor Blue
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
