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
$VscSettingsPath = "$VscUserData\settings.json"

# Create prompts directory if it doesn't exist
Write-Host "[1/2] Creating global Karpathy instructions..." -ForegroundColor Yellow
if (!(Test-Path $VscPromptsDir)) {
    New-Item -ItemType Directory -Path $VscPromptsDir -Force | Out-Null
}

# Download Karpathy instructions to VS Code user prompts folder
Invoke-WebRequest -Uri "$BaseUrl/KARPATHY_SKILL.md" -OutFile "$VscPromptsDir\global.instructions.md"
Write-Host "      Saved to: $VscPromptsDir\global.instructions.md" -ForegroundColor Gray
Write-Host "      Done!" -ForegroundColor Green

# Update VS Code settings
Write-Host "[2/2] Updating VS Code settings..." -ForegroundColor Yellow

# Create settings file if it doesn't exist
if (!(Test-Path $VscSettingsPath)) {
    New-Item -ItemType Directory -Path (Split-Path $VscSettingsPath) -Force | Out-Null
    "{}" | Out-File -FilePath $VscSettingsPath -Encoding UTF8
}

# Read existing settings
try {
    $settings = Get-Content $VscSettingsPath -Raw | ConvertFrom-Json
} catch {
    $settings = New-Object PSObject
}

# Add/update settings
$settings | Add-Member -NotePropertyName "github.copilot.advanced.length" -NotePropertyValue 500 -Force
$settings | Add-Member -NotePropertyName "github.copilot.chat.codeGeneration.useInstructionFiles" -NotePropertyValue $true -Force

# Write back
$settings | ConvertTo-Json -Depth 10 | Out-File -FilePath $VscSettingsPath -Encoding UTF8

Write-Host "      VS Code settings updated!" -ForegroundColor Green

# Summary
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  INSTALLATION COMPLETE!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  File installed:" -ForegroundColor White
Write-Host "    $VscPromptsDir\global.instructions.md" -ForegroundColor Gray
Write-Host ""
Write-Host "  VS Code settings updated:" -ForegroundColor White
Write-Host "    github.copilot.advanced.length = 500" -ForegroundColor Gray
Write-Host "    github.copilot.chat.codeGeneration.useInstructionFiles = true" -ForegroundColor Gray
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
