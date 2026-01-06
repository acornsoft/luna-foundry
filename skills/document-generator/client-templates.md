# Client Template Setup

## Overview

Clients can override or augment default templates by adding their branded templates to the Custom Office Templates directory.

## Directory Structure

```text
$env:USERPROFILE\Documents\Custom Office Templates\
├── accenture\
│   └── template.docx
├── ecolab\
│   ├── template.docx
│   └── template.css (for HTML/PDF)
└── [client-name]\
    ├── template.docx
    └── template.css
```

## Adding Client Templates

1. Create a subfolder named after the client (e.g., `ecolab`)
2. Add `template.docx` for Word documents
3. Optionally add `template.css` for HTML/PDF styling
4. The script will automatically prioritize client templates over defaults

## Template Priority

1. Client-specific templates (highest priority)
2. Partner templates
3. Default templates (lowest priority)

## Usage

Specify the client name in the conversion command:

```powershell
.\Convert-Document.ps1 -InputFile 'report.md' -Client 'ecolab' -Formats 'docx'
```

This will use `ecolab/template.docx` if it exists, otherwise fall back to defaults.