---
name: pptx
description: Specialized skill for converting Markdown documents into PowerPoint presentations (PPTX) with support for Mermaid diagrams and branding. Use this when asked to generate PPTX from Markdown.
---

# PPTX Generator Skill

## Overview

The PPTX Generator is a specialized skill for converting Markdown documents into professional PowerPoint presentations (PPTX). It leverages PowerShell scripting and Pandoc to produce slide-based deliverables, with optional Mermaid diagram processing.

## Purpose

- Convert Markdown to PPTX format
- Process Mermaid diagrams into images for slides
- Apply basic branding or templates if available
- Generate presentation-ready files

## Scope

- Input: Markdown files with optional Mermaid diagrams
- Output: PPTX presentation
- Integration: PowerShell-based conversion with Pandoc

## Key Features

1. **PPTX Conversion**: Direct Markdown to PowerPoint
2. **Mermaid Processing**: Automatic diagram-to-image conversion
3. **Slide Generation**: Markdown headers become slides
4. **Resource Handling**: Images and diagrams embedded

## Inputs

- Markdown file path
- Output path for PPTX
- Optional: Template for PPTX

## Outputs

- Generated PPTX file
- Processed images/diagrams

## Process Flow

1. Validate input Markdown file
2. Process Mermaid diagrams if present
3. Convert using Pandoc to PPTX
4. Handle resource paths

## Usage

Invoke to create PPTX presentations from Markdown. Output folder is automatically determined: uses `~/project-root/docs/Analysis/outputs` if it exists, otherwise the input file's directory.

Example:

```powershell
.\convert-document.ps1 -InputFile 'MacroFlow-Analysis.md' -Formats pptx
```

Or specify custom output:

```powershell
.\convert-document.ps1 -InputFile 'MacroFlow-Analysis.md' -Formats pptx -OutputFolder 'custom'
```

## Dependencies

- Pandoc installed
- PowerShell execution
- Mermaid CLI (optional)