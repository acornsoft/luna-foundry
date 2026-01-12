# Luna Foundry Release 1 - Markdown Validation & Enforcement

This directory contains scripts to validate and enforce Markdown format on all work items in the "Luna Foundry Release 1" iteration.

## Scripts Overview

### `validate_release_markdown.py`
**Purpose**: Checks that all work items in Luna Foundry Release 1 are using Markdown format for multiline fields.

**What it does**:
- Queries Azure DevOps for all work items under "Luna Foundry Release 1" iteration
- Checks `System.Description` and `Microsoft.VSTS.TCM.ReproSteps` fields
- Validates they are set to `markdown` format (not `html`)
- Reports compliance status

**Usage**:
```bash
python validate_release_markdown.py
```

**Exit Codes**:
- `0`: All work items are compliant
- `1`: Some work items need updating

### `enforce_release_markdown.py`
**Purpose**: Automatically enforces Markdown format on all work items in Luna Foundry Release 1.

**What it does**:
- First runs validation to check current state
- If any work items need updating, uses the Azure CLI extension to enforce Markdown format
- Re-validates after enforcement
- Reports final status

**Usage**:
```bash
python enforce_release_markdown.py
```

## Prerequisites

1. **Azure CLI installed** and authenticated
2. **Markdown Enforcer extension installed**:
   ```bash
   az extension add --source markdown-enforcer-0.1.0.tar.gz
   ```
3. **Access to Luna Foundry Azure DevOps project**
4. **Proper permissions** to read/update work items

## Azure DevOps Setup

The scripts look for an iteration path containing "Luna Foundry Release 1". Make sure:

1. You have an iteration named "Luna Foundry Release 1" (or containing that text)
2. Work items are assigned to this iteration
3. You have permissions to query and update work items

## Example Output

### Validation (All Compliant)
```
🔍 Luna Foundry Release 1 - Markdown Format Validation
============================================================
Found 15 work items to check

Checking work item 123...
Checking work item 456...
...

📊 Validation Results
============================================================
✅ Work Item 123 (Task): Implement user authentication...
✅ Work Item 456 (Bug): Fix login button styling...
...

📈 Summary: 15/15 work items are compliant
🎉 All work items are using Markdown format!
```

### Validation (Issues Found)
```
📊 Validation Results
============================================================
✅ Work Item 123 (Task): Implement user authentication...
❌ Work Item 456 (Bug): Fix login button styling...
   - Field 'System.Description' is 'html' (should be 'markdown')

📈 Summary: 14/15 work items are compliant
⚠️  Some work items need to be updated to use Markdown format.
   Run the following command to fix them:
   az boards work-item markdown-enforce enforce --wiql "SELECT [System.Id] FROM WorkItems WHERE [System.IterationPath] UNDER 'Luna Foundry Release 1'"
```

## Integration with CI/CD

These scripts can be integrated into your release pipeline:

```yaml
# Azure DevOps Pipeline step
- task: Bash@3
  displayName: 'Validate Markdown Format'
  inputs:
    targetType: 'inline'
    script: |
      cd $(Build.SourcesDirectory)/src/azext_markdown_enforcer
      python validate_release_markdown.py
  continueOnError: false

- task: Bash@3
  displayName: 'Enforce Markdown Format'
  inputs:
    targetType: 'inline'
    script: |
      cd $(Build.SourcesDirectory)/src/azext_markdown_enforcer
      python enforce_release_markdown.py
  continueOnError: true  # Allow enforcement to fail without breaking build
```

## Troubleshooting

### "Could not find iteration containing 'Luna Foundry Release 1'"
- Check that the iteration exists in your Azure DevOps project
- Verify the iteration name contains the exact text "Luna Foundry Release 1"
- Ensure you have permissions to view iterations

### "Extension not found"
- Install the extension: `az extension add --source markdown-enforcer-0.1.0.tar.gz`
- Verify installation: `az extension list`

### Permission Errors
- Ensure your Azure CLI is authenticated: `az login`
- Check that your account has permissions to update work items in the project
- Verify the project and organization are correctly configured

## Related Documentation

- [ADR 001: Defer API Integration Tests](../docs/ADRs/001-defer-api-integration-tests.md)
- [Extension README](../README.md)
- [Azure DevOps Work Item Markdown](https://docs.microsoft.com/en-us/azure/devops/boards/queries/markdown-support)