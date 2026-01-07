param(
    [string]$InputFile,
    [string]$OutputFolder,
    [string[]]$Formats = @("pdf"),
    [string]$Template = "default",
    [switch]$IncludeToc,
    [string]$Watermark = ""
)

# Ensure Pandoc is available
if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Error "Pandoc is not installed. Please install Pandoc to use this script."
    exit 1
}

# Create output folder if it doesn't exist
if (-not (Test-Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
}

# Base name for output files
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)

# Pandoc options
$pandocOptions = @(
    "--from", "markdown",
    "--to", "html",
    "--self-contained",
    "--css", "https://cdn.jsdelivr.net/npm/github-markdown-css/github-markdown.css"
)

if ($IncludeToc) {
    $pandocOptions += "--toc"
}

if ($Watermark) {
    # Add watermark as a header or footer
    $pandocOptions += "--include-in-header", "<div style='position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%) rotate(-45deg); font-size: 72px; color: rgba(255,0,0,0.1); z-index: -1;'>$Watermark</div>"
}

foreach ($format in $Formats) {
    $outputFile = Join-Path $OutputFolder "$baseName.$format"
    $formatOptions = $pandocOptions + @("--output", $outputFile)

    switch ($format) {
        "pdf" {
            $formatOptions = $pandocOptions + @("--pdf-engine", "wkhtmltopdf", "--output", $outputFile)
        }
        "docx" {
            $formatOptions = $pandocOptions + @("--to", "docx", "--output", $outputFile)
        }
        "pptx" {
            $formatOptions = $pandocOptions + @("--to", "pptx", "--output", $outputFile)
        }
        "html" {
            $formatOptions = $pandocOptions + @("--to", "html", "--output", $outputFile)
        }
    }

    & pandoc $formatOptions $InputFile
    Write-Host "Generated $outputFile"
}