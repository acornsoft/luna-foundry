# Luna Foundry Setup Script

param(
    [string]$AdoOrg,
    [string]$AdoProject,
    [string]$GithubUser,
    [string]$RepoName
)

Write-Host "Luna Foundry Setup Starting..."

# Check Azure CLI
if (!(Get-Command az -ErrorAction SilentlyContinue)) {
    Write-Host "Install Azure CLI first."
    exit 1
}

# Install DevOps extension
az extension add --name azure-devops --yes

# Login to ADO
if ($AdoOrg) {
    az devops login --organization "https://dev.azure.com/$AdoOrg"
    az devops configure --defaults organization="https://dev.azure.com/$AdoOrg" project=$AdoProject
}

# Ask for repos/instances
$GitRepos = Read-Host "Enter Git repo URLs (comma-separated)"
$AdoInstances = Read-Host "Enter ADO instances (org/project/area/iteration, comma-separated)"
$JiraInstances = Read-Host "Enter Jira URLs/projects (comma-separated)"

# Clone Git repos
foreach ($repo in $GitRepos -split ',') {
    git clone $repo.Trim()
}

# Note ADO/Jira for MCP config
Write-Host "ADO/Jira instances noted: $AdoInstances, $JiraInstances. Update mcp.json manually."

Write-Host "Setup complete. Update mcp.json manually if needed."