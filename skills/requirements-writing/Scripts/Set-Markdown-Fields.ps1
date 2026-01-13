# Enhanced Markdown Enforcement Script for Requirements Writing
# Uses the Azure CLI Markdown Enforcer extension for reliable formatting

param(
    [Parameter(Mandatory=$false)]
    [string]$Organization = "https://dev.azure.com/acornsoft",

    [Parameter(Mandatory=$false)]
    [string]$Project = "com.acornsoft365",

    [Parameter(Mandatory=$false)]
    [string]$WIQL,

    [Parameter(Mandatory=$false)]
    [int[]]$WorkItemIds,

    [Parameter(Mandatory=$false)]
    [string]$IterationPath,

    [Parameter(Mandatory=$false)]
    [switch]$DryRun,

    [Parameter(Mandatory=$false)]
    [switch]$Force
)

# Set default configuration
az devops configure --defaults organization=$Organization project=$Project

Write-Host "🔍 Luna Foundry - Enhanced Markdown Enforcement" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Cyan

# Check if extension is installed
$extensionCheck = az extension list --output json | ConvertFrom-Json | Where-Object { $_.name -eq "markdown-enforcer" }
if (-not $extensionCheck) {
    Write-Host "❌ Azure CLI Markdown Enforcer extension not found!" -ForegroundColor Red
    Write-Host "Please install it first:" -ForegroundColor Yellow
    Write-Host "  az extension add --source markdown-enforcer-0.1.0.tar.gz" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Markdown Enforcer extension found" -ForegroundColor Green

# Build WIQL query based on parameters
if (-not $WIQL -and -not $WorkItemIds -and -not $IterationPath) {
    Write-Host "❌ Must specify one of: -WIQL, -WorkItemIds, or -IterationPath" -ForegroundColor Red
    Write-Host "Examples:" -ForegroundColor Yellow
    Write-Host "  .\Set-Markdown-Fields.ps1 -IterationPath 'Luna Foundry Release 1'" -ForegroundColor Yellow
    Write-Host "  .\Set-Markdown-Fields.ps1 -WIQL 'SELECT [System.Id] FROM WorkItems WHERE [System.WorkItemType] = ""User Story""'" -ForegroundColor Yellow
    Write-Host "  .\Set-Markdown-Fields.ps1 -WorkItemIds 123, 456, 789" -ForegroundColor Yellow
    exit 1
}

# Construct the command arguments
$commandArgs = @("boards", "work-item", "markdown-enforce", "enforce")

if ($WIQL) {
    $commandArgs += @("--wiql", "`"$WIQL`"")
    Write-Host "📋 Using WIQL query: $WIQL" -ForegroundColor Blue
}

if ($WorkItemIds) {
    $idsString = $WorkItemIds -join ", "
    $commandArgs += @("--ids", $idsString)
    Write-Host "📋 Processing specific work items: $idsString" -ForegroundColor Blue
}

if ($IterationPath) {
    $wiql = "SELECT [System.Id] FROM WorkItems WHERE [System.IterationPath] UNDER '$IterationPath'"
    $commandArgs += @("--wiql", "`"$wiql`"")
    Write-Host "📋 Processing work items under iteration: $IterationPath" -ForegroundColor Blue
}

if ($DryRun) {
    $commandArgs += @("--dry-run")
    Write-Host "🔍 DRY RUN MODE - No changes will be made" -ForegroundColor Yellow
}

# Add fields to enforce (System.Description is default, add others as needed)
$commandArgs += @("--fields", "System.Description", "Microsoft.VSTS.Common.AcceptanceCriteria", "Microsoft.VSTS.TCM.ReproSteps")

Write-Host "🎯 Enforcing Markdown format on: System.Description, Acceptance Criteria, Repro Steps" -ForegroundColor Blue
Write-Host ""

# Execute the command
$commandString = "az " + ($commandArgs -join " ")
Write-Host "🚀 Executing: $commandString" -ForegroundColor Green
Write-Host ""

try {
    # Run the command and capture output
    $process = Start-Process -FilePath "az" -ArgumentList $commandArgs -NoNewWindow -Wait -PassThru -RedirectStandardOutput "temp_output.txt" -RedirectStandardError "temp_error.txt"

    $output = Get-Content "temp_output.txt" -Raw
    $errorOutput = Get-Content "temp_error.txt" -Raw

    # Clean up temp files
    Remove-Item "temp_output.txt" -ErrorAction SilentlyContinue
    Remove-Item "temp_error.txt" -ErrorAction SilentlyContinue

    if ($process.ExitCode -eq 0) {
        Write-Host "✅ Markdown enforcement completed successfully!" -ForegroundColor Green
        if ($output) {
            Write-Host "📊 Results:" -ForegroundColor Blue
            Write-Host $output
        }
    } else {
        Write-Host "❌ Markdown enforcement failed!" -ForegroundColor Red
        if ($errorOutput) {
            Write-Host "Error details:" -ForegroundColor Red
            Write-Host $errorOutput
        }
        exit $process.ExitCode
    }

} catch {
    Write-Host "❌ Error executing command: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "📝 Next Steps:" -ForegroundColor Cyan
Write-Host "  1. Review work items in Azure DevOps to verify Markdown formatting" -ForegroundColor White
Write-Host "  2. Use the validation scripts to check compliance:" -ForegroundColor White
Write-Host "     python validate_release_markdown.py" -ForegroundColor White
Write-Host "  3. Re-run this script if new work items are added" -ForegroundColor White