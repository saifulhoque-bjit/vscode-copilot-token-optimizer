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

# Create .github directory
Write-Host "[1/5] Creating .github directory..." -ForegroundColor Yellow
if (!(Test-Path ".github")) {
    New-Item -ItemType Directory -Path ".github" | Out-Null
}
Write-Host "      Done!" -ForegroundColor Green

# Download copilot-instructions.md
Write-Host "[2/5] Downloading Copilot custom instructions..." -ForegroundColor Yellow
Invoke-WebRequest -Uri "$BaseUrl/copilot-instructions.md" -OutFile ".github/copilot-instructions.md"
Write-Host "      Done!" -ForegroundColor Green

# Download Karpathy's coding guidelines
Write-Host "[3/5] Downloading Karpathy's coding guidelines..." -ForegroundColor Yellow
Invoke-WebRequest -Uri "$BaseUrl/KARPATHY_SKILL.md" -OutFile ".github/KARPATHY_SKILL.md"
Write-Host "      Done!" -ForegroundColor Green

# Update VS Code settings
Write-Host "[4/5] Updating VS Code settings..." -ForegroundColor Yellow

$VscSettingsPath = "$env:APPDATA\Code\User\settings.json"

# Create settings file if it doesn't exist
if (!(Test-Path $VscSettingsPath)) {
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
$settings | Add-Member -NotePropertyName "github.copilot.advanced.inlineSuggestCount" -NotePropertyValue 3 -Force

# Write back
$settings | ConvertTo-Json -Depth 10 | Out-File -FilePath $VscSettingsPath -Encoding UTF8

Write-Host "      VS Code settings updated!" -ForegroundColor Green

# Summary
Write-Host ""
Write-Host "[5/5] Installation Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  WHAT WAS INSTALLED" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Files installed:" -ForegroundColor White
Write-Host "    .github/copilot-instructions.md  (token optimization + loads Karpathy)" -ForegroundColor Gray
Write-Host "    .github/KARPATHY_SKILL.md        (Karpathy's coding principles)" -ForegroundColor Gray
Write-Host ""
Write-Host "  VS Code settings updated:" -ForegroundColor White
Write-Host "    github.copilot.advanced.length = 500" -ForegroundColor Gray
Write-Host "    github.copilot.chat.codeGeneration.useInstructionFiles = true" -ForegroundColor Gray
Write-Host "    github.copilot.advanced.inlineSuggestCount = 3" -ForegroundColor Gray
Write-Host ""
Write-Host "  Quick Start:" -ForegroundColor White
Write-Host "    1. Restart VS Code" -ForegroundColor Gray
Write-Host '    2. Use concise prompts: "Sum even nums. Handle edge cases."' -ForegroundColor Gray
Write-Host "    3. Check guidelines: cat .github/KARPATHY_SKILL.md" -ForegroundColor Gray
Write-Host ""
Write-Host "  SAVINGS: 30-60% fewer tokens per Copilot interaction" -ForegroundColor Green
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  GitHub: https://github.com/$Repo" -ForegroundColor Blue
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
