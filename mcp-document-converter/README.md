# MCP Document Converter

An MCP (Model Context Protocol) server that provides a tool for converting Markdown documents to DOCX and PDF using pandoc and custom Office templates.

## Features

- Convert Markdown to DOCX or PDF
- Leverage custom branded Office templates
- Agentic-aware: Designed for use by AI agents

## Installation

1. Clone or download this repository.
2. Run 
pm install to install dependencies.
3. Update the path to Convert-Document.ps1 in index.js.

## Usage

### For Internal Projects

Run the server locally:

`ash
npm start
`

Configure your AI agent or MCP client to connect to this server.

### For Public Use via acornsoft.ai

- Deploy the server to a cloud platform (e.g., Azure Functions, AWS Lambda).
- Provide access through acornsoft.ai's MCP registry or API.

## Tool: convert_document

- **inputFile**: Path to the Markdown file
- **outputFormat**: 'docx' or 'pdf'
- **templatePath**: (Optional) Path to custom template
- **outputDir**: (Optional) Output directory

## Requirements

- Node.js
- PowerShell
- pandoc
- Your Convert-Document.ps1 script

## License

MIT