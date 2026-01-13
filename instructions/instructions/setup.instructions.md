# Luna Foundry Setup Instructions

## Overview

Before starting analysis in Luna Foundry, establish source code repositories (Git-based on Azure DevOps/GitHub) and Azure DevOps instances for work items. This setup ensures multi-instance access for forensics and syncing.

## Pre-Requisites

- VS Code Insiders (or VS Code with skills support) with required extensions.
- PowerShell 7+ installed (pwsh --version).
- Node.js installed (node --version).
- Azure CLI installed (az --version).
- Azure DevOps CLI extension installed (az devops --help).
- Pandoc installed (pandoc --version).
- MCP Server capability supported in VS Code.
- Access to Azure DevOps organizations (e.g., acornsoft, ecolab) and GitHub.

## Setup Steps

### 1. Setup VS Code Insiders / VS Code with Skills
- Install VS Code Insiders from https://code.visualstudio.com/insiders.
- Verify skills support: Open Copilot Chat and check for @/# invocations.
- Install required extensions: GitHub Copilot, vscode-awesome-copilot (from https://github.com/acornsoft/vscode-awesome-copilot), and Mermaid Markdown Syntax Highlighting (bpruitt-goddard.mermaid-markdown-syntax-highlighting) for diagram rendering in preview.
- Verify MCP Server capability: Check if MCP servers can be configured in settings.

### 2. Setup PowerShell 7
- Install PowerShell 7: `winget install --id Microsoft.PowerShell --source winget`.
- Verify: `pwsh --version` (should be 7.x).
- Set as default if needed.

### 3. Setup Node.js
- Install Node.js: `winget install --id OpenJS.NodeJS --source winget`.
- Verify: `node --version`.

### 4. Setup Azure CLI
- Install: `winget install --id Microsoft.AzureCLI --source winget`.
- Verify: `az --version`.

### 5. Setup Azure DevOps CLI
- Install extension: `az extension add --name azure-devops`.
- Obtain Personal Access Token (PAT) from https://dev.azure.com/YOUR_ORG/_usersSettings/tokens (scope: Work Items, Code, Build).
- Login: `az devops login --organization https://dev.azure.com/YOUR_ORG`.
- Configure defaults: `az devops configure --defaults organization=https://dev.azure.com/YOUR_ORG project=YOUR_PROJECT`.

### 6. Setup Pandoc
- Install Pandoc: `winget install --id JohnMacFarlane.Pandoc --source winget` (Windows).
- Verify: `pandoc --version`.

### 7. Establish Repositories
- Luna Foundry repo: https://github.com/acornsoft/luna-foundry
- Clone locally: `git clone https://github.com/acornsoft/luna-foundry.git`
- Anthropics Skills repo: https://github.com/anthropics/skills
- Clone locally: `git clone https://github.com/anthropics/skills.git`
- For ADO repos: Use MCP to list/create repos in project https://dev.azure.com/acornsoft/com.acornsoft365

### 8. Setup Work Items
- Project: https://dev.azure.com/acornsoft/com.acornsoft365
- Area: com.acornsoft365\(ASFT) Luna Foundry
- Iteration: com.acornsoft365\2026.1
- Use MCP (mcp_acornsoftdevo_wit_create_work_item) or CLI to create items in this area/iteration.

### 9. Automated User Walkthrough
- Run script: `./setup-luna-foundry.ps1` (checks installations, prompts for configs, updates mcp.json, installs extensions/repos).
- Luna agent will guide post-setup.
- Run script: `./setup-luna-foundry.ps1` (checks installations, prompts for configs, updates mcp.json).
- Luna agent will guide post-setup.

## Validation

- Test MCP: Query work items with mcp_acornsoftdevo_wit_my_work_items.
- Test CLI: `az repos list`.
- Confirm repos cloned and accessible.

## Next Phase

Proceed to Constitution once setup is complete.