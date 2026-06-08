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

# Ask user for project path
Write-Host "Where should the Copilot instructions be installed?" -ForegroundColor Yellow
Write-Host ""
Write-Host "  [1] Current directory ($(Get-Location))" -ForegroundColor White
Write-Host "  [2] Specific project path" -ForegroundColor White
Write-Host "  [3] All projects in a directory (scan for .git folders)" -ForegroundColor White
Write-Host ""

$Option = Read-Host "Choose option (1/2/3) [default: 1]"
if ([string]::IsNullOrEmpty($Option)) { $Option = "1" }

$ProjectPaths = @()

switch ($Option) {
    "1" {
        $ProjectPaths += (Get-Location).Path
    }
    "2" {
        $CustomPath = Read-Host "Enter project path"
        if (!(Test-Path $CustomPath)) {
            Write-Host "Error: Directory not found: $CustomPath" -ForegroundColor Red
            exit 1
        }
        $ProjectPaths += $CustomPath
    }
    "3" {
        $ParentPath = Read-Host "Enter parent directory to scan"
        if (!(Test-Path $ParentPath)) {
            Write-Host "Error: Directory not found: $ParentPath" -ForegroundColor Red
            exit 1
        }
        $ProjectPaths = Get-ChildItem -Path $ParentPath -Directory -Recurse -Depth 2 | 
            Where-Object { Test-Path (Join-Path $_.FullName ".git") } |
            Select-Object -ExpandProperty FullName
        
        if ($ProjectPaths.Count -eq 0) {
            Write-Host "No git repositories found in $ParentPath" -ForegroundColor Red
            exit 1
        }
        Write-Host "Found $($ProjectPaths.Count) projects" -ForegroundColor Green
    }
    default {
        Write-Host "Invalid option" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "Installing to $($ProjectPaths.Count) project(s)..." -ForegroundColor Yellow
Write-Host ""

foreach ($ProjectPath in $ProjectPaths) {
    Write-Host "------------------------------------------------------------" -ForegroundColor Cyan
    Write-Host "  Project: $ProjectPath" -ForegroundColor Cyan
    Write-Host "------------------------------------------------------------" -ForegroundColor Cyan
    
    # Create .github directory
    Write-Host "  [1/3] Creating .github directory..." -ForegroundColor Yellow
    $GithubDir = Join-Path $ProjectPath ".github"
    if (!(Test-Path $GithubDir)) {
        New-Item -ItemType Directory -Path $GithubDir | Out-Null
    }
    Write-Host "        Done!" -ForegroundColor Green

    # Download copilot-instructions.md
    Write-Host "  [2/3] Downloading Copilot custom instructions..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri "$BaseUrl/copilot-instructions.md" -OutFile (Join-Path $GithubDir "copilot-instructions.md")
    Write-Host "        Done!" -ForegroundColor Green

    # Download Karpathy's coding guidelines
    Write-Host "  [3/3] Downloading Karpathy's coding guidelines..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri "$BaseUrl/KARPATHY_SKILL.md" -OutFile (Join-Path $GithubDir "KARPATHY_SKILL.md")
    Write-Host "        Done!" -ForegroundColor Green
    Write-Host ""
}

# Update VS Code settings
Write-Host "------------------------------------------------------------" -ForegroundColor Cyan
Write-Host "  Updating VS Code settings..." -ForegroundColor Yellow
Write-Host "------------------------------------------------------------" -ForegroundColor Cyan

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

# Write back
$settings | ConvertTo-Json -Depth 10 | Out-File -FilePath $VscSettingsPath -Encoding UTF8

Write-Host "      VS Code settings updated!" -ForegroundColor Green

# Summary
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  INSTALLATION COMPLETE!" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Projects configured: $($ProjectPaths.Count)" -ForegroundColor White
foreach ($ProjectPath in $ProjectPaths) {
    Write-Host "    - $ProjectPath" -ForegroundColor Gray
}
Write-Host ""
Write-Host "  Files installed per project:" -ForegroundColor White
Write-Host "    .github/copilot-instructions.md  (token optimization + loads Karpathy)" -ForegroundColor Gray
Write-Host "    .github/KARPATHY_SKILL.md        (Karpathy's coding principles)" -ForegroundColor Gray
Write-Host ""
Write-Host "  VS Code settings updated:" -ForegroundColor White
Write-Host "    github.copilot.advanced.length = 500" -ForegroundColor Gray
Write-Host "    github.copilot.chat.codeGeneration.useInstructionFiles = true" -ForegroundColor Gray
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
