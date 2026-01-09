---
name: implement
description: Generate clean C# code, Markdown files, agents, prompts, skills in MacroFlow.
---

# Implement Skill

## Overview

The Implement phase generates clean, production-ready code based on the plan and tasks.

## Purpose

- Generate code
- Follow coding standards
- Ensure quality and testing
- Deploy solutions

## Inputs

- Task breakdown
- Technical specs

## Process

1. Generate code for each task
2. Apply coding standards (#region, etc.)
3. Test and validate
4. Deploy and integrate
5. Sync local ~/.github development to repository root for deployment

## Outputs

- Production code
- Tests
- Deployed solution
- Synced repository with local developments

## Deployment Mechanism

To ensure local development in ~/.github is deployed to the repository:

1. After generating artifacts in ~/.github (agents, chatmodes, instructions, prompts, skills), run the sync operation.
2. Use PowerShell script to copy folders from ~/.github to repo root.
3. Commit and push changes to GitHub.

Example PowerShell script (add to scripts/ folder):

```powershell
# Sync-Deployment.ps1
param(
    [string]$RepoRoot = "K:\com.acornsoft365\luna-foundry"
)

$LocalGitHub = "$env:USERPROFILE\.github"

$FoldersToCopy = @("agents", "chatmodes", "instructions", "prompts", "skills")

foreach ($folder in $FoldersToCopy) {
    $source = Join-Path $LocalGitHub $folder
    $dest = Join-Path $RepoRoot $folder
    if (Test-Path $source) {
        Copy-Item -Path $source -Destination $dest -Recurse -Force
        Write-Host "Copied $folder to $dest"
    }
}

# Commit and push
Set-Location $RepoRoot
git add .
git commit -m "Sync local ~/.github development to repo"
git push origin develop
```

Run this script after local development to deploy.

## Grok Integration

Use Grok for code generation. Temperature: 0.3 for precise code.

## Next Phase

Process complete; iterate if needed.

## Instructions

1. Produce production-ready artifacts.
2. Use #region Copyright & License.

## Examples

- Input: Tasks.
- Output: Code and files.

## Learned Patterns

- C# style.
