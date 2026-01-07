---
name: document-generator
description: Specialized skill for generating client-focused documents from Markdown files, converting to professional formats like DOCX, PDF, HTML with branding. Use this when asked to create branded client deliverables from existing Markdown content.
---

# Document Generator Skill

## Overview

The Document Generator is a specialized skill for creating client-focused, branded documents from existing Markdown files. It converts Markdown content into professional formats (DOCX, PDF, HTML) using PowerShell scripts and Pandoc, with automatic output placement in designated directories.

## Purpose

- Generate branded client documents from Markdown sources
- Convert to multiple formats (DOCX, PDF, HTML) for client delivery
- Automatically place outputs in appropriate directories
- Support client-specific branding and templates

## Scope

- Input: Existing Markdown file path
- Output: Branded documents in requested formats
- Placement: `~/{project-name}/docs/Analysis/outputs` if exists, otherwise same directory as input
- Formats: DOCX (primary), PDF, HTML
- Branding: Client-specific templates and watermarks

## Key Features

1. **Client-Focused Conversion**: Tailored for professional client deliverables
2. **Automatic Output Placement**: Smart directory selection based on project structure
3. **Multi-Format Generation**: DOCX, PDF, HTML outputs
4. **Template Integration**: Client/partner branding support
5. **Mermaid Processing**: Automatic diagram conversion

## Inputs

- Markdown file path (required)
- Client name for branding (optional, defaults to generic)
- Output formats (optional, defaults to DOCX)
- Custom title (optional)

## Outputs

- Generated documents in specified formats
- Placed in `~/{project-name}/docs/Analysis/outputs` or input directory
- Confirmation of file locations

## Process Flow

1. Validate input Markdown file exists
2. Determine output directory (check `~/{project-name}/docs/Analysis/outputs`, fallback to input dir)
3. Select client template if specified
4. Call `scripts/Convert-Document.ps1` with parameters
5. Generate documents with branding
6. Return success with file paths

## Usage

Invoke when user requests client document creation from Markdown. Examples:

- "Generate a client document from MacroFlow-Analysis.md for xAI"
- "Create branded DOCX from report.md"

The skill will automatically:

- Use client-specific branding
- Place output in correct directory
- Generate multiple formats if requested

## Script Integration

Calls `scripts/Convert-Document.ps1` with:

- `-InputFile`: Path to Markdown
- `-Client`: Client name for branding
- `-Formats`: Array of output formats
- `-Title`: Custom document title
- `-OutputDir`: Determined output directory

## Dependencies

- Pandoc installed
- `scripts/Convert-Document.ps1` script
- Client templates in appropriate directories
- PowerShell execution environment
