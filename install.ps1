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

# Create prompts directory if it doesn't exist
Write-Host "[1/1] Creating global Karpathy instructions..." -ForegroundColor Yellow
if (!(Test-Path $VscPromptsDir)) {
    New-Item -ItemType Directory -Path $VscPromptsDir -Force | Out-Null
}

# Download Karpathy instructions to VS Code user prompts folder
Invoke-WebRequest -Uri "$BaseUrl/KARPATHY_SKILL.md" -OutFile "$VscPromptsDir\global.instructions.md"
Write-Host "      Saved to: $VscPromptsDir\global.instructions.md" -ForegroundColor Gray
Write-Host "      Done!" -ForegroundColor Green

# Summary
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  INSTALLATION COMPLETE!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  File installed:" -ForegroundColor White
Write-Host "    $VscPromptsDir\global.instructions.md" -ForegroundColor Gray
Write-Host ""
Write-Host "  How it works:" -ForegroundColor White
Write-Host "    - global.instructions.md is loaded GLOBALLY by VS Code" -ForegroundColor Gray
Write-Host "    - It applies to ALL projects automatically" -ForegroundColor Gray
Write-Host "    - Copilot will follow Karpathy's coding principles" -ForegroundColor Gray
Write-Host ""
Write-Host "  Quick Start:" -ForegroundColor White
Write-Host "    1. Restart VS Code" -ForegroundColor Gray
Write-Host '    2. Use concise prompts: "Sum even nums. Handle edge cases."' -ForegroundColor Gray
Write-Host ""
Write-Host "  SAVINGS: 30-60% fewer tokens per Copilot interaction" -ForegroundColor Green
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  GitHub: https://github.com/$Repo" -ForegroundColor Blue
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
