---
name: generate-client-report
description: Final branded client deliverables via Pandoc
---

# Generate Client Report Skill

## Instructions
1. Save enriched analysis as client-report-final.md
2. Prepend header.md, append footer.md
3. Run PowerShell conversion: ./convert-document.ps1 -Input client-report-final.md -Formats pdf,docx,pptx,html

Output confirmation with file list.

## Examples
- Input: Analysis markdown
- Output: PDF, DOCX, PPTX, HTML files

## Learned Patterns
- Clients love Mermaid diagrams in PDFs.
- Use custom templates for branding.