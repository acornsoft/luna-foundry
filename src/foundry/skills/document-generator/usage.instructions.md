# Document Generation Instructions

## Overview

Follow these instructions to generate professional, branded documents using the Document Generator skill.

## Prerequisites

1. Ensure Pandoc is installed
2. Set up Custom Office Templates directory
3. Place Markdown source in project directory

## Steps

1. **Prepare Content**: Create or generate Markdown with content
2. **Select Templates**: Identify client/partner for branding
3. **Configure Output**: Choose formats (DOCX, PDF, HTML)
4. **Run Conversion**: Execute the PowerShell script
5. **Review Output**: Validate branded documents

## Command Examples

```powershell
# Use default user profile templates
.\Convert-Document.ps1 -InputFile 'report.md' -Client 'ecolab' -Formats 'docx'

# Override with custom template directory
.\Convert-Document.ps1 -InputFile 'analysis.md' -TemplateDir 'C:\Custom\ClientTemplates' -Client 'clientname'

# Full-featured with template override to shared location
.\Convert-Document.ps1 -InputFile 'doc.md' -Formats 'docx','pdf' -Partner 'accenture' -IncludeToc -TemplateDir 'K:\com.acornsoft365\dreamcatcher\lib\Custom Office Templates'
```

## Integration with MacroFlow

- Use in Implement phase for final deliverables
- Input from previous phases (Specify, Plan)
- Output ready for client sharing

## Troubleshooting

- Check Pandoc installation
- Verify template paths
- Ensure Markdown syntax is valid
- Review error logs for Mermaid processing