# Document Generator Skill

## Overview

The Document Generator is a specialized skill for converting Markdown documents into professional, branded formats including DOCX, PDF, HTML, and processing Mermaid diagrams. It leverages PowerShell scripting and Custom Office Templates to produce client-ready deliverables.

## Purpose

- Convert Markdown to multiple formats (DOCX, PDF, HTML)
- Apply client/partner branding via templates
- Process Mermaid diagrams into images
- Generate final-form documents for sharing

## Scope

- Input: Markdown files with optional Mermaid diagrams
- Output: Branded documents in requested formats
- Templates: Custom Office Templates for branding
- Integration: PowerShell-based conversion with Pandoc

## Key Features

1. **Multi-Format Conversion**: DOCX, PDF, HTML outputs
2. **Mermaid Processing**: Automatic diagram-to-image conversion
3. **Template Support**: Client/partner-specific branding
4. **Resource Management**: Image and resource path handling
5. **TOC Generation**: Optional table of contents

## Inputs

- Markdown file path
- Output formats (array)
- Partner/Client for template selection
- Resource path for images
- Optional: TOC depth, title

## Outputs

- Generated documents in specified formats
- Processed images/diagrams
- Success/failure status

## Process Flow

1. Validate input Markdown file
2. Select appropriate template (client > partner priority)
3. Process Mermaid diagrams if present
4. Convert using Pandoc with template
5. Handle resource paths and images
6. Generate output files

## Template Management

- **Defaults**: Templates stored in `$env:USERPROFILE\Documents\Custom Office Templates` (user profile)
- **Priority**: Client templates > Partner templates > Defaults
- **Override**: Use `-TemplateDir` parameter for custom locations (e.g., shared dreamcatcher templates)
- **Augmentation**: Clients can add subfolders (e.g., `ecolab/template.docx`) to override defaults

## Usage

Invoke during Implement phase to create branded client documents. Example:

```powershell
.\Convert-Document.ps1 -InputFile 'report.md' -Formats 'docx','pdf' -Client 'ecolab' -IncludeToc
```

## Dependencies

- Pandoc installed
- PowerShell execution
- Custom Office Templates directory
- Mermaid CLI (optional for diagram processing)
