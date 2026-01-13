# Azure CLI Markdown Enforcer Integration Guide

## Overview
The Requirements Writing skill now integrates with the Azure CLI Markdown Enforcer extension to ensure all work items maintain proper Markdown formatting. This integration provides automated enforcement of Markdown standards across all Luna Foundry work items.

## Integration Points

### 1. Work Item Creation (`New-WorkItemWithMarkdown.ps1`)
- **Purpose**: Creates work items with automatic Markdown enforcement
- **Features**:
  - Template validation
  - Automatic Markdown formatting
  - Parent-child relationship support
  - Type-specific field handling

### 2. Bulk Enforcement (`Set-Markdown-Fields.ps1`)
- **Purpose**: Enforces Markdown on existing work items
- **Features**:
  - Iteration-based processing
  - WIQL query support
  - Specific work item ID targeting
  - Dry-run mode for validation

### 3. Validation Scripts (Python)
- **Purpose**: Validates Markdown compliance across releases
- **Features**:
  - Automated compliance checking
  - Detailed issue reporting
  - CI/CD integration support

## Best Practices

### 1. Use Templates Consistently
```powershell
# Always use the provided templates for consistent formatting
$story = .\Scripts\New-WorkItemWithMarkdown.ps1 -WorkItemType UserStory -Title "..." -Description $templateContent
```

### 2. Enforce Markdown After Bulk Operations
```powershell
# After importing work items or bulk updates
.\Scripts\Set-Markdown-Fields.ps1 -IterationPath "Luna Foundry Release 1"
```

### 3. Validate Regularly
```powershell
# Check compliance before releases
python ..\..\src\azext_markdown_enforcer\validate_release_markdown.py
```

### 4. Integrate with CI/CD
```yaml
# Azure DevOps Pipeline
- task: PowerShell@2
  displayName: 'Create Work Items'
  inputs:
    targetType: 'inline'
    script: |
      .\Scripts\New-WorkItemWithMarkdown.ps1 -WorkItemType UserStory -Title "$(WorkItemTitle)" -Description "$(WorkItemDescription)"

- task: PowerShell@2
  displayName: 'Enforce Markdown Format'
  inputs:
    targetType: 'inline'
    script: |
      .\Scripts\Set-Markdown-Fields.ps1 -IterationPath "$(Release.ReleaseName)"
```

## Field Coverage

The extension enforces Markdown format on these critical fields:
- `System.Description` - Main work item content
- `Microsoft.VSTS.Common.AcceptanceCriteria` - Story/requirement criteria
- `Microsoft.VSTS.TCM.ReproSteps` - Test reproduction steps

## Error Handling

### Extension Not Installed
```
❌ Azure CLI Markdown Enforcer extension not found!
```
**Solution**: Install the extension
```bash
az extension add --source markdown-enforcer-0.1.0.tar.gz
```

### Permission Issues
```
Error: Insufficient permissions to update work items
```
**Solution**: Ensure proper Azure DevOps permissions and CLI authentication

### Template Validation Warnings
```
⚠️  User Story description doesn't follow template format
```
**Solution**: Use the provided templates from the skill documentation

## Performance Considerations

- **Batch Processing**: Process work items in batches rather than individually
- **Selective Enforcement**: Use WIQL queries to target specific work item types
- **Dry Run First**: Always test with `-DryRun` before applying changes

## Monitoring and Maintenance

### Regular Validation
Set up scheduled validation checks:
```powershell
# Weekly compliance check
.\Scripts\Set-Markdown-Fields.ps1 -IterationPath "Luna Foundry Release 1" -DryRun
```

### CI/CD Integration
Ensure all pipelines include Markdown validation:
```yaml
- task: Bash@3
  displayName: 'Validate Markdown Compliance'
  inputs:
    targetType: 'inline'
    script: |
      cd $(Build.SourcesDirectory)/.github/skills/requirements-writing
      python ../../src/azext_markdown_enforcer/validate_release_markdown.py
```

## Troubleshooting Common Issues

### Work Items Not Found
- Verify iteration path exists
- Check work item permissions
- Validate WIQL syntax

### Formatting Not Applied
- Ensure extension is installed and updated
- Check Azure DevOps API permissions
- Verify work item is not locked/readonly

### Template Validation Errors
- Review the template formats in SKILL.md
- Ensure required sections are present
- Check Markdown syntax validity

## Future Enhancements

### Planned Improvements
- Custom field support beyond default fields
- Template auto-generation from work item content
- Integration with GitHub Copilot for content suggestions
- Automated template compliance scoring

### Extension Roadmap
- Enhanced error reporting and recovery
- Support for additional work item field types
- Integration with Azure DevOps web hooks
- Performance optimizations for large work item sets