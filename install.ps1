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

# Download Karpathy's guidelines to home directory
Write-Host "[1/3] Downloading Karpathy's coding guidelines..." -ForegroundColor Yellow
$KarpathyFile = "$env:USERPROFILE\.karpathy-coding-guidelines.md"
Invoke-WebRequest -Uri "$BaseUrl/KARPATHY_SKILL.md" -OutFile $KarpathyFile
Write-Host "      Saved to: $KarpathyFile" -ForegroundColor Gray
Write-Host "      Done!" -ForegroundColor Green

# Create global AGENTS.md in user home (Copilot reads this globally)
Write-Host "[2/3] Creating global AGENTS.md in user home..." -ForegroundColor Yellow
$AgentsFile = "$env:USERPROFILE\AGENTS.md"
Invoke-WebRequest -Uri "$BaseUrl/copilot-instructions.md" -OutFile $AgentsFile
Write-Host "      Saved to: $AgentsFile" -ForegroundColor Gray
Write-Host "      Done!" -ForegroundColor Green

# Update VS Code settings
Write-Host "[3/3] Updating VS Code settings..." -ForegroundColor Yellow

$VscSettingsPath = "$env:APPDATA\Code\User\settings.json"

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
$settings | Add-Member -NotePropertyName "chat.useAgentsMdFile" -NotePropertyValue $true -Force

# Write back
$settings | ConvertTo-Json -Depth 10 | Out-File -FilePath $VscSettingsPath -Encoding UTF8

Write-Host "      VS Code settings updated!" -ForegroundColor Green

# Summary
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  INSTALLATION COMPLETE!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Files installed:" -ForegroundColor White
Write-Host "    ~/AGENTS.md                       (global Copilot instructions)" -ForegroundColor Gray
Write-Host "    ~/.karpathy-coding-guidelines.md  (Karpathy's coding principles)" -ForegroundColor Gray
Write-Host ""
Write-Host "  VS Code settings updated:" -ForegroundColor White
Write-Host "    github.copilot.advanced.length = 500" -ForegroundColor Gray
Write-Host "    github.copilot.chat.codeGeneration.useInstructionFiles = true" -ForegroundColor Gray
Write-Host "    chat.useAgentsMdFile = true" -ForegroundColor Gray
Write-Host ""
Write-Host "  How it works:" -ForegroundColor White
Write-Host "    - AGENTS.md in your home directory is loaded GLOBALLY" -ForegroundColor Gray
Write-Host "    - It applies to ALL projects in VS Code" -ForegroundColor Gray
Write-Host "    - It tells Copilot to follow Karpathy's guidelines" -ForegroundColor Gray
Write-Host ""
Write-Host "  Quick Start:" -ForegroundColor White
Write-Host "    1. Restart VS Code" -ForegroundColor Gray
Write-Host '    2. Use concise prompts: "Sum even nums. Handle edge cases."' -ForegroundColor Gray
Write-Host "    3. Check guidelines: cat ~/.karpathy-coding-guidelines.md" -ForegroundColor Gray
Write-Host ""
Write-Host "  SAVINGS: 30-60% fewer tokens per Copilot interaction" -ForegroundColor Green
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  GitHub: https://github.com/$Repo" -ForegroundColor Blue
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
