# Sync-Deployment.ps1
param(
    [string]$RepoRoot = "K:\com.acornsoft365\luna-foundry"
)

$LocalGitHub = "$RepoRoot\.github"

$FoldersToCopy = @("agents", "chatmodes", "instructions", "prompts", "skills")

foreach ($folder in $FoldersToCopy) {
    $source = Join-Path $LocalGitHub $folder
    $dest = Join-Path $RepoRoot $folder
    if (Test-Path $source) {
        if (!(Test-Path $dest)) {
            New-Item -ItemType Directory -Path $dest
        }
        Copy-Item -Path "$source\*" -Destination $dest -Recurse -Force
        Write-Host "Copied $folder to $dest"
    }
}

# Commit and push
Set-Location $RepoRoot
git add .
git commit -m "Sync local ~/.github development to repo"
git push origin develop