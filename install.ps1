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

# VS Code user data path on Windows
$VscUserData = "$env:APPDATA\Code\User"
$VscPromptsDir = "$VscUserData\prompts"
$SkillsDir = "$env:USERPROFILE\.copilot\skills\optimize"

Write-Host "[1/4] Installing Karpathy's coding guidelines (global)..." -ForegroundColor Yellow
if (!(Test-Path $VscPromptsDir)) {
    New-Item -ItemType Directory -Path $VscPromptsDir -Force | Out-Null
}
Invoke-WebRequest -Uri "$BaseUrl/KARPATHY_SKILL.md" -OutFile "$VscPromptsDir\global.instructions.md"
Write-Host "      Saved to: $VscPromptsDir\global.instructions.md" -ForegroundColor Gray
Write-Host "      Done!" -ForegroundColor Green

Write-Host "[2/4] Creating .github directory..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path ".github" -Force | Out-Null

Write-Host "[3/4] Installing Copilot custom instructions..." -ForegroundColor Yellow
Invoke-WebRequest -Uri "$BaseUrl/copilot-instructions.md" -OutFile ".github\copilot-instructions.md"
Write-Host "      Saved to: .github\copilot-instructions.md" -ForegroundColor Gray
Write-Host "      Done!" -ForegroundColor Green

Write-Host "[4/4] Installing /optimize slash command..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path $SkillsDir -Force | Out-Null
Invoke-WebRequest -Uri "$BaseUrl/skills/optimize/SKILL.md" -OutFile "$SkillsDir\SKILL.md"
Invoke-WebRequest -Uri "$BaseUrl/skills/optimize/compress_context.py" -OutFile "$SkillsDir\compress_context.py"
Write-Host "      Saved to: $SkillsDir\" -ForegroundColor Gray
Write-Host "      Done!" -ForegroundColor Green

# Summary
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  INSTALLATION COMPLETE" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Files installed:" -ForegroundColor White
Write-Host "    Global: $VscPromptsDir\global.instructions.md" -ForegroundColor Gray
Write-Host "    Project: .github\copilot-instructions.md" -ForegroundColor Gray
Write-Host "    Skill:   $SkillsDir\" -ForegroundColor Gray
Write-Host ""
Write-Host "  Quick Start:" -ForegroundColor White
Write-Host "    1. Restart VS Code" -ForegroundColor Gray
Write-Host "    2. In Copilot Chat, type: /optimize" -ForegroundColor Gray
Write-Host "    3. Code normally. Every file question auto-compresses." -ForegroundColor Gray
Write-Host ""
Write-Host "  SAVINGS: 30-60% fewer tokens per Copilot interaction" -ForegroundColor Green
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  GitHub: https://github.com/$Repo" -ForegroundColor Blue
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
