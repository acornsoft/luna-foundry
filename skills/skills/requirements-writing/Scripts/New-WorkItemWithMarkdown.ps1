# Integrated Work Item Creation and Markdown Enforcement Script
# Creates work items using templates and ensures proper Markdown formatting

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("Epic", "Feature", "Requirement", "UserStory", "Task", "TestCase")]
    [string]$WorkItemType,

    [Parameter(Mandatory=$true)]
    [string]$Title,

    [Parameter(Mandatory=$false)]
    [string]$Description,

    [Parameter(Mandatory=$false)]
    [string]$AcceptanceCriteria,

    [Parameter(Mandatory=$false)]
    [string]$AssignedTo,

    [Parameter(Mandatory=$false)]
    [ValidateSet("Critical", "High", "Medium", "Low")]
    [string]$Priority = "Medium",

    [Parameter(Mandatory=$false)]
    [string]$ParentId,

    [Parameter(Mandatory=$false)]
    [string]$IterationPath,

    [Parameter(Mandatory=$false)]
    [string]$AreaPath,

    [Parameter(Mandatory=$false)]
    [switch]$SkipMarkdownEnforcement
)

# Import required modules
Import-Module Az.Accounts
Import-Module Az.DevOps

Write-Host "📝 Luna Foundry - Integrated Work Item Creation" -ForegroundColor Cyan
Write-Host "=" * 60 -ForegroundColor Cyan

# Check if extension is installed
$extensionCheck = az extension list --output json | ConvertFrom-Json | Where-Object { $_.name -eq "markdown-enforcer" }
if (-not $extensionCheck -and -not $SkipMarkdownEnforcement) {
    Write-Host "⚠️  Azure CLI Markdown Enforcer extension not found!" -ForegroundColor Yellow
    Write-Host "Work item will be created but Markdown formatting won't be enforced." -ForegroundColor Yellow
    Write-Host "To install: az extension add --source markdown-enforcer-0.1.0.tar.gz" -ForegroundColor Yellow
    $SkipMarkdownEnforcement = $true
}

# Build work item fields based on type
$fields = @{}

# Common fields
$fields["System.Title"] = $Title
if ($Description) { $fields["System.Description"] = $Description }
if ($AssignedTo) { $fields["System.AssignedTo"] = $AssignedTo }
if ($Priority) { $fields["Microsoft.VSTS.Common.Priority"] = $Priority }
if ($IterationPath) { $fields["System.IterationPath"] = $IterationPath }
if ($AreaPath) { $fields["System.AreaPath"] = $AreaPath }

# Type-specific fields
switch ($WorkItemType) {
    "Epic" {
        $actualType = "Epic"
        if ($Description) {
            # Ensure Epic description follows template format
            if ($Description -notmatch "### Business Objectives") {
                Write-Host "⚠️  Epic description doesn't follow template format. Consider using the Epic template." -ForegroundColor Yellow
            }
        }
    }
    "Feature" {
        $actualType = "Feature"
        if ($Description) {
            if ($Description -notmatch "### Business Context") {
                Write-Host "⚠️  Feature description doesn't follow template format. Consider using the Feature template." -ForegroundColor Yellow
            }
        }
    }
    "Requirement" {
        $actualType = "Requirement"
        if ($Description) {
            if ($Description -notmatch "### Business Objective") {
                Write-Host "⚠️  Requirement description doesn't follow template format. Consider using the Requirement template." -ForegroundColor Yellow
            }
        }
    }
    "UserStory" {
        $actualType = "User Story"
        if ($AcceptanceCriteria) {
            $fields["Microsoft.VSTS.Common.AcceptanceCriteria"] = $AcceptanceCriteria
        }
        if ($Description) {
            if ($Description -notmatch "## User Story: As a") {
                Write-Host "⚠️  User Story description doesn't follow template format. Consider using the User Story template." -ForegroundColor Yellow
            }
        }
    }
    "Task" {
        $actualType = "Task"
        if ($Description) {
            if ($Description -notmatch "## Task:") {
                Write-Host "⚠️  Task description doesn't follow template format. Consider using the Task template." -ForegroundColor Yellow
            }
        }
    }
    "TestCase" {
        $actualType = "Test Case"
        if ($Description) {
            if ($Description -notmatch "## Test Case:") {
                Write-Host "⚠️  Test Case description doesn't follow template format. Consider using the Test Case template." -ForegroundColor Yellow
            }
        }
    }
}

# Add parent link if specified
if ($ParentId) {
    $fields["System.Parent"] = $ParentId
}

Write-Host "🔨 Creating $WorkItemType..." -ForegroundColor Blue
Write-Host "Title: $Title" -ForegroundColor White
if ($AssignedTo) { Write-Host "Assigned To: $AssignedTo" -ForegroundColor White }
if ($Priority) { Write-Host "Priority: $Priority" -ForegroundColor White }
Write-Host ""

# Build az command arguments
$commandArgs = @("boards", "work-item", "create", "--type", "`"$actualType`"", "--title", "`"$Title`"")

foreach ($field in $fields.GetEnumerator()) {
    if ($field.Key -ne "System.Title") {
        $commandArgs += @("--fields", "$($field.Key)=$($field.Value)")
    }
}

# Execute work item creation
$commandString = "az " + ($commandArgs -join " ")
Write-Host "🚀 Executing: $commandString" -ForegroundColor Green

try {
    $result = & az @commandArgs --output json | ConvertFrom-Json

    if ($result.id) {
        Write-Host "✅ Work item created successfully!" -ForegroundColor Green
        Write-Host "ID: $($result.id)" -ForegroundColor Green
        Write-Host "URL: $($result.url)" -ForegroundColor Green

        $workItemId = $result.id

        # Enforce Markdown formatting if extension is available
        if (-not $SkipMarkdownEnforcement) {
            Write-Host ""
            Write-Host "🎯 Enforcing Markdown formatting..." -ForegroundColor Blue

            $markdownArgs = @("boards", "work-item", "markdown-enforce", "enforce", "--ids", $workItemId)
            $markdownResult = & az @markdownArgs

            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ Markdown formatting enforced!" -ForegroundColor Green
            } else {
                Write-Host "⚠️  Markdown enforcement completed with warnings. Check output above." -ForegroundColor Yellow
            }
        }

        Write-Host ""
        Write-Host "📋 Work Item Summary:" -ForegroundColor Cyan
        Write-Host "  Type: $WorkItemType" -ForegroundColor White
        Write-Host "  ID: $workItemId" -ForegroundColor White
        Write-Host "  Title: $Title" -ForegroundColor White
        if ($AssignedTo) { Write-Host "  Assigned To: $AssignedTo" -ForegroundColor White }
        Write-Host "  Status: $($result.fields.'System.State')" -ForegroundColor White

        return $workItemId

    } else {
        Write-Host "❌ Failed to create work item" -ForegroundColor Red
        exit 1
    }

} catch {
    Write-Host "❌ Error creating work item: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}