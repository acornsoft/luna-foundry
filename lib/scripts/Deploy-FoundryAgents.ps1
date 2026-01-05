# Deploy-FoundryAgents.ps1

<#
.SYNOPSIS
    Automates deployment of Luna Foundry agents to GitHub Copilot profile.

.DESCRIPTION
    Copies agents from the Luna Foundry repository to the user's .github directory
    for automatic loading in VS Code Copilot.

.PARAMETER FoundryPath
    Path to the Luna Foundry src/foundry directory. Defaults to relative path.

.PARAMETER ProfilePath
    Path to the user's .github directory. Defaults to $env:USERPROFILE\.github.

.EXAMPLE
    .\Deploy-FoundryAgents.ps1

.EXAMPLE
    .\Deploy-FoundryAgents.ps1 -FoundryPath "K:\com.acornsoft365\luna-foundry\src\foundry"
#>

param(
    [string]$FoundryPath = "$PSScriptRoot\src\foundry",
    [string]$ProfilePath = "$env:USERPROFILE\.github"
)

# Ensure source exists
if (!(Test-Path $FoundryPath)) {
    Write-Error "Foundry path not found: $FoundryPath"
    exit 1
}

# Ensure destination exists
if (!(Test-Path $ProfilePath)) {
    New-Item -ItemType Directory -Path $ProfilePath -Force | Out-Null
}

# Copy agents
$agentsSource = Join-Path $FoundryPath "agents"
$agentsDest = Join-Path $ProfilePath "agents"

if (Test-Path $agentsSource) {
    Write-Host "Deploying agents from $agentsSource to $agentsDest" -ForegroundColor Cyan
    Copy-Item -Path $agentsSource -Destination $ProfilePath -Recurse -Force
    Write-Host "Agents deployed successfully. Reload VS Code to activate." -ForegroundColor Green
} else {
    Write-Error "Agents source not found: $agentsSource"
    exit 1
}

# Optional: Copy skills or other components if needed
$skillsSource = Join-Path $FoundryPath "skills"
if (Test-Path $skillsSource) {
    $skillsDest = Join-Path $ProfilePath "skills"
    Write-Host "Copying skills for reference..." -ForegroundColor Gray
    Copy-Item -Path $skillsSource -Destination $skillsDest -Recurse -Force
}

Write-Host "Deployment complete. Your Luna Foundry agents are now configured for GitHub Copilot." -ForegroundColor Green