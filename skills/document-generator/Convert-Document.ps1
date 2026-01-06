# Check for help request before anything else
if ($args -contains "-h" -or $args -contains "--help" -or $args -contains "-Help") {
    $ScriptVersion = "1.0.25311.1"
    Write-Host "Document Generation Tool v$ScriptVersion" -ForegroundColor Cyan
    Write-Host "=====================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Usage Examples:" -ForegroundColor Cyan
    Write-Host "  .\Convert-Document.ps1 -InputFile 'analysis.md' -Client 'ecolab'  # Uses ecolab template (overrides default accenture)" -ForegroundColor White
    Write-Host "  .\Convert-Document.ps1 -InputFile 'report.md' -Partner 'accenture'  # Uses accenture template" -ForegroundColor White
    Write-Host "  .\Convert-Document.ps1 -InputFile 'doc.md' -Formats 'docx','pdf' -IncludeToc  # DOCX automatically processes Mermaid diagrams" -ForegroundColor White
    Write-Host "  .\Convert-Document.ps1 -InputFile 'doc.md' -OutputFile 'final-report' -ResourcePath 'images'" -ForegroundColor White
    Write-Host "  .\Convert-Document.ps1 -InputFile 'doc.md' -TemplateDir 'C:\Custom\Templates'" -ForegroundColor White
    Write-Host "  .\Convert-Document.ps1 -InputFile 'doc.md' -ProcessMermaid  # Convert Mermaid diagrams to PNG images (manual for non-DOCX)" -ForegroundColor White
    Write-Host "  .\Convert-Document.ps1 -InputFile 'doc.md' -ProcessMermaid -MermaidFormats 'svg','png'  # Generate both SVG and PNG formats" -ForegroundColor White
    Write-Host ""
    Write-Host "DOCX Format Notes:" -ForegroundColor Yellow
    Write-Host "  - Mermaid diagrams are automatically converted to PNG images for DOCX files" -ForegroundColor White
    Write-Host "  - PNG images are sized to fit within page margins (max width: 600px)" -ForegroundColor White
    Write-Host "  - No need to specify -ProcessMermaid for DOCX output" -ForegroundColor White
    Write-Host "  - Images are saved to the ResourcePath directory" -ForegroundColor White
    Write-Host ""
    Write-Host "For full parameter documentation, use: Get-Help .\Convert-Document.ps1" -ForegroundColor Yellow
    exit 0
}

# Parse InputFile manually to validate immediately
$InputFile = $null
for ($i = 0; $i -lt $args.Count; $i++) {
    if ($args[$i] -eq "-InputFile" -and $i + 1 -lt $args.Count) {
        $InputFile = $args[$i + 1]
        break
    }
}

# Immediate validation of InputFile
if ([string]::IsNullOrWhiteSpace($InputFile)) {
    Write-Host "Error: InputFile parameter is required." -ForegroundColor Red
    Write-Host "For help, run: .\Convert-Document.ps1 -h" -ForegroundColor Yellow
    exit 1
}

if (!(Test-Path $InputFile)) {
    Write-Host "Error: Supplied Markdown file does not exist: '$InputFile'" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please ensure the file exists and the path is correct." -ForegroundColor Yellow
    Write-Host "Examples of valid paths:" -ForegroundColor Cyan
    Write-Host "  .\Convert-Document.ps1 -InputFile 'C:\docs\analysis.md'" -ForegroundColor White
    Write-Host "  .\Convert-Document.ps1 -InputFile '.\docs\analysis.md'" -ForegroundColor White
    Write-Host "  .\Convert-Document.ps1 -InputFile 'analysis.md'  # if in current directory" -ForegroundColor White
    Write-Host ""
    Write-Host "For help, run: .\Convert-Document.ps1 -h" -ForegroundColor Yellow
    exit 1
}

# Now parse the rest of the parameters manually
$OutputFile = $null
$Formats = @("docx")
$Partner = "accenture"
$Client = $null
$IncludeToc = $false
$TocDepth = 3
$ResourcePath = $null
$TemplateDir = $null
$ProcessMermaid = $false
$MermaidFormats = @("png")

for ($i = 0; $i -lt $args.Count; $i++) {
    switch ($args[$i]) {
        "-OutputFile" {
            if ($i + 1 -lt $args.Count) {
                $OutputFile = $args[$i + 1]
                $i++
            }
        }
        "-Formats" {
            if ($i + 1 -lt $args.Count) {
                $Formats = $args[$i + 1] -split ','
                $i++
            }
        }
        "-Partner" {
            if ($i + 1 -lt $args.Count) {
                $Partner = $args[$i + 1]
                $i++
            }
        }
        "-Client" {
            if ($i + 1 -lt $args.Count) {
                $Client = $args[$i + 1]
                $i++
            }
        }
        "-IncludeToc" {
            $IncludeToc = $true
        }
        "-TocDepth" {
            if ($i + 1 -lt $args.Count) {
                $TocDepth = [int]$args[$i + 1]
                $i++
            }
        }
        "-ResourcePath" {
            if ($i + 1 -lt $args.Count) {
                $ResourcePath = $args[$i + 1]
                $i++
            }
        }
        "-TemplateDir" {
            if ($i + 1 -lt $args.Count) {
                $TemplateDir = $args[$i + 1]
                $i++
            }
        }
        "-ProcessMermaid" {
            $ProcessMermaid = $true
        }
        "-MermaidFormats" {
            if ($i + 1 -lt $args.Count) {
                $MermaidFormats = $args[$i + 1] -split ','
                $i++
            }
        }
    }
}

# Set default values after param block
if (-not $Formats) { $Formats = @("docx") }
if (-not $Partner) { $Partner = "accenture" }
if (-not $TocDepth) { $TocDepth = 3 }
if (-not $MermaidFormats) { $MermaidFormats = @("png") }

# Script version
$ScriptVersion = "1.0.25311.1"
if ($Partner) {
    $Partner = $Partner.Substring(0,1).ToUpper() + $Partner.Substring(1).ToLower()
}
if ($Client) {
    $Client = $Client.Substring(0,1).ToUpper() + $Client.Substring(1).ToLower()
}

# Set default TemplateDir to user profile Custom Office Templates
if (!$TemplateDir) {
    $TemplateDir = "$env:USERPROFILE\Documents\Custom Office Templates"
}

# Function to get unique file name
function Get-UniqueFileName {
    param([string]$basePath, [string]$extension)
    $counter = 0
    $filePath = "$basePath$extension"
    while (Test-Path $filePath) {
        $counter++
        $filePath = "$basePath_$counter$extension"
    }
    return $filePath
}

# Set default ResourcePath for images
$projectRoot = Split-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) -Parent
$imagesDir = Join-Path $projectRoot "docs\Analysis\images"
if (!$ResourcePath) {
    $ResourcePath = $imagesDir
}
if (!(Test-Path $ResourcePath)) {
    New-Item -ItemType Directory -Path $ResourcePath -Force | Out-Null
}

# Set default OutputFile in outputs directory
$outputsDir = Join-Path $projectRoot "docs\Analysis\outputs"
if (!(Test-Path $outputsDir)) {
    New-Item -ItemType Directory -Path $outputsDir -Force | Out-Null
}
if (!$OutputFile) {
    $inputBaseName = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)
    $OutputFile = Join-Path $outputsDir "$inputBaseName-output"
}

# Function to find reference template
function Find-ReferenceTemplate {
    param(
        [string]$TemplateDir,
        [string]$Partner,
        [string]$Client
    )

    $templatePaths = @()

    # Priority order: client > partner
    if ($Client) {
        $clientFolder = Join-Path $TemplateDir $Client
        $clientTemplate = Join-Path $clientFolder "template.docx"
        $templatePaths += $clientTemplate
    }

    if ($Partner) {
        $partnerFolder = Join-Path $TemplateDir $Partner
        $partnerTemplate = Join-Path $partnerFolder "template.docx"
        $templatePaths += $partnerTemplate
    }

    # Check each path in priority order
    foreach ($path in $templatePaths) {
        if (Test-Path $path) {
            return $path
        }
    }

    return $null
}

# Function to process Mermaid diagrams
function Convert-MermaidDiagrams {
    param(
        [string]$InputFile,
        [string]$ResourcePath,
        [string[]]$Formats = @("svg", "png"),
        [int]$MaxWidth = 600
    )

    Write-Host "Processing Mermaid diagrams from: $InputFile" -ForegroundColor Cyan
    Write-Host "Output directory: $ResourcePath" -ForegroundColor White
    Write-Host "Formats: $($Formats -join ', ')" -ForegroundColor White

    # Read the content
    $content = Get-Content $InputFile -Raw
    if ($content -notmatch '```mermaid') {
        Write-Host "No Mermaid diagrams found, returning original file" -ForegroundColor Yellow
        return $InputFile
    }

    # Create output directory if it doesn't exist
    if (!(Test-Path $ResourcePath)) {
        New-Item -ItemType Directory -Path $ResourcePath -Force | Out-Null
    }

    # Extract Mermaid blocks using regex
    $mermaidPattern = '(?s)```mermaid\s*\n(.*?)\n```'
    $mermaidMatches = Select-String -InputObject $content -Pattern $mermaidPattern -AllMatches

    if ($mermaidMatches.Matches.Count -eq 0) {
        Write-Host "No Mermaid diagrams found, returning original file" -ForegroundColor Yellow
        return $InputFile
    }

    Write-Host "Found $($mermaidMatches.Matches.Count) Mermaid diagram(s)" -ForegroundColor Green

    # Process each Mermaid block
    $processedContent = $content
    $diagramIndex = 0

    foreach ($match in $mermaidMatches.Matches) {
        $diagramIndex++
        $mermaidCode = $match.Groups[1].Value.Trim()

        # Generate unique filename using SHA256 hash
        $sha256 = [System.Security.Cryptography.SHA256]::Create()
        $hashBytes = $sha256.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($mermaidCode))
        $hashString = [BitConverter]::ToString($hashBytes).Replace("-", "").ToLower()

        Write-Host "Processing diagram $diagramIndex (hash: $($hashString.Substring(0,8))...)" -ForegroundColor White

        # Generate images for each format
        $imageReferences = @()
        foreach ($format in $Formats) {
            $imageFileName = "mermaid_diagram_$($hashString.Substring(0,16)).$format"
            $imagePath = Join-Path $ResourcePath $imageFileName

            # Check if image already exists
            if (!(Test-Path $imagePath)) {
                # Create temporary file for Mermaid input
                $tempFile = [System.IO.Path]::GetTempFileName() + ".mmd"
                try {
                    # Write Mermaid code to temp file
                    $mermaidCode | Out-File -FilePath $tempFile -Encoding UTF8

                    if ($format -eq "svg") {
                        # Generate SVG directly with mmdc
                        $mmdcArgs = @(
                            "-i", $tempFile,
                            "-o", $imagePath,
                            "-t", "default",
                            "-b", "transparent"
                        )

                        Write-Host "  Running: mmdc $($mmdcArgs -join ' ')" -ForegroundColor Gray
                        $allArgs = @("/c", "mmdc") + $mmdcArgs
                        $process = Start-Process -FilePath "cmd.exe" -ArgumentList $allArgs -NoNewWindow -Wait
                        $exitCode = $process.ExitCode
                        Write-Host "  Exit code: $exitCode" -ForegroundColor Gray

                        # Check if file was actually created (mmdc sometimes creates files despite errors)
                        if (!(Test-Path $imagePath)) {
                            Write-Warning "Failed to generate SVG image for diagram $diagramIndex (Exit code: $exitCode)"
                            continue
                        }
                    }
                    elseif ($format -eq "png") {
                        # Generate PNG directly with mmdc
                        $mmdcArgs = @(
                            "-i", $tempFile,
                            "-o", $imagePath,
                            "-t", "default",
                            "-b", "transparent",
                            "-w", $MaxWidth
                        )

                        Write-Host "  Running: mmdc $($mmdcArgs -join ' ')" -ForegroundColor Gray
                        $allArgs = @("/c", "mmdc") + $mmdcArgs
                        $process = Start-Process -FilePath "cmd.exe" -ArgumentList $allArgs -NoNewWindow -Wait
                        $exitCode = $process.ExitCode
                        Write-Host "  Exit code: $exitCode" -ForegroundColor Gray

                        # Check if file was actually created (mmdc sometimes creates files despite errors)
                        if (!(Test-Path $imagePath)) {
                            Write-Warning "Failed to generate PNG image for diagram $diagramIndex (Exit code: $exitCode)"
                            continue
                        }
                    }

                    Write-Host "  Generated $format image: $imageFileName" -ForegroundColor Green
                }
                catch {
                    Write-Warning "Error processing diagram $diagramIndex ($format): $($_.Exception.Message)"
                    continue
                }
                finally {
                    # Clean up temp file
                    if (Test-Path $tempFile) {
                        Remove-Item $tempFile -Force
                    }
                }
            } else {
                Write-Host "  Using existing $format image: $imageFileName" -ForegroundColor Yellow
            }

            # Add image reference (prefer PNG for Pandoc compatibility, fallback to SVG)
            if ($format -eq "png") {
                $imageReferences += "![Mermaid Diagram $diagramIndex]($imageFileName)"
            }
            elseif ($format -eq "svg" -and $imageReferences.Count -eq 0) {
                # Only use SVG if no PNG was generated
                $imageReferences += "![Mermaid Diagram $diagramIndex]($imageFileName)"
            }
        }

        # Replace Mermaid block with image reference (use first available format)
        if ($imageReferences.Count -gt 0) {
            $replacement = $imageReferences[0]
            $processedContent = $processedContent.Replace($match.Value, $replacement)
            Write-Host "  Replaced Mermaid block with image reference" -ForegroundColor Green
        }
    }

    # Write processed content to a temporary file
    $processedFile = [System.IO.Path]::GetTempFileName() + ".md"
    $processedContent | Out-File -FilePath $processedFile -Encoding UTF8

    Write-Host "Mermaid processing complete. Processed file: $processedFile" -ForegroundColor Green
    return $processedFile
}
function Find-CssFile {
    param(
        [string]$TemplateDir,
        [string]$Partner,
        [string]$Client
    )

    $cssPaths = @()

    # Priority order: client > partner
    if ($Client) {
        $clientFolder = Join-Path $TemplateDir $Client
        $clientCss = Join-Path $clientFolder "template.css"
        $cssPaths += $clientCss
    }

    if ($Partner) {
        $partnerFolder = Join-Path $TemplateDir $Partner
        $partnerCss = Join-Path $partnerFolder "template.css"
        $cssPaths += $partnerCss
    }

    # Check each path in priority order
    foreach ($path in $cssPaths) {
        if (Test-Path $path) {
            return $path
        }
    }

    return $null
}

# Function to generate document
function Convert-ToDocument {
    param(
        [string]$InputPath,
        [string]$OutputPath,
        [string]$Format,
        [string]$TemplateDir,
        [string]$Partner,
        [string]$Client,
        [switch]$IncludeToc,
        [int]$TocDepth,
        [string]$ResourcePath,
        [string]$Title,
        [switch]$ProcessMermaid,
        [string[]]$MermaidFormats
    )

    if (!(Test-Path $InputPath)) {
        Write-Error "Input file not found: $InputPath"
        return $false
    }

    # Process Mermaid diagrams if requested
    $actualInputPath = $InputPath
    if ($ProcessMermaid -and $ResourcePath) {
        $maxWidth = if ($Format -eq "docx") { 600 } else { 800 }
        $processedInputPath = Convert-MermaidDiagrams -InputFile $InputPath -ResourcePath $ResourcePath -Formats $MermaidFormats -MaxWidth $maxWidth
        if ($processedInputPath -and (Test-Path $processedInputPath)) {
            $actualInputPath = $processedInputPath
            Write-Host "Using processed Markdown file: $actualInputPath" -ForegroundColor Green
        } else {
            Write-Warning "Mermaid diagram processing failed, continuing with original document..."
        }
    }

    # Ensure output directory exists
    $outputDir = Split-Path $OutputPath -Parent
    if ([string]::IsNullOrEmpty($outputDir)) {
        $outputDir = Get-Location
    }
    if (!(Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }

    $pandocArgs = @($actualInputPath, "-o", $OutputPath)

    # Add title if specified
    if ($Title) {
        $pandocArgs += @("--metadata", "title=$Title")
    }

    # Add format-specific options
    switch ($Format) {
        "docx" {
            if ($IncludeToc) {
                $pandocArgs += @("--toc", "--toc-depth=$TocDepth")
            }

            # Find reference template
            $referenceDoc = Find-ReferenceTemplate -TemplateDir $TemplateDir -Partner $Partner -Client $Client
            if ($referenceDoc) {
                $pandocArgs += "--reference-doc=$referenceDoc"
                Write-Host "Using reference template: $referenceDoc" -ForegroundColor Blue
            } else {
                Write-Host "No reference template found. Using default DOCX formatting." -ForegroundColor Yellow
            }

            # Additional DOCX formatting options
            $pandocArgs += @(
                "--syntax-highlighting=tango",
                "-V", "geometry:margin=1in",
                "-V", "fontsize=11pt",
                "-V", "fontfamily=arial"
            )

            # Add resource path for images
            if ($ResourcePath -and (Test-Path $ResourcePath)) {
                $pandocArgs += "--resource-path=$ResourcePath"
                $pandocArgs += "--extract-media=$ResourcePath"
            }
        }
        "html" {
            # Find CSS file
            $cssFile = Find-CssFile -TemplateDir $TemplateDir -Partner $Partner -Client $Client
            if ($cssFile) {
                $pandocArgs += @("--css=$cssFile", "--embed-resources", "--standalone")
                Write-Host "Using CSS file: $cssFile" -ForegroundColor Blue
            } else {
                $pandocArgs += @("--embed-resources", "--standalone")
                Write-Host "No CSS file found. Using default HTML formatting." -ForegroundColor Yellow
            }

            # Add resource path for images
            if ($ResourcePath -and (Test-Path $ResourcePath)) {
                $pandocArgs += "--resource-path=$ResourcePath"
            }
        }
        "pdf" {
            # Find reference template (same as DOCX)
            $referenceDoc = Find-ReferenceTemplate -TemplateDir $TemplateDir -Partner $Partner -Client $Client
            if ($referenceDoc) {
                $pandocArgs += "--reference-doc=$referenceDoc"
                Write-Host "Using reference template: $referenceDoc" -ForegroundColor Blue
            } else {
                Write-Host "No reference template found. Using default PDF formatting." -ForegroundColor Yellow
            }

            # Try different PDF engines in order of preference
            $pdfEngines = @("lualatex", "xelatex", "pdflatex")
            $engineFound = $false

            foreach ($engine in $pdfEngines) {
                if (Get-Command $engine -ErrorAction SilentlyContinue) {
                    $pandocArgs += @("--pdf-engine=$engine", "-V", "geometry:margin=1in")
                    if ($IncludeToc) {
                        $pandocArgs += "--toc"
                    }
                    $engineFound = $true
                    break
                }
            }

            if (-not $engineFound) {
                Write-Warning "No PDF engine found (pdflatex, lualatex, or xelatex). PDF generation will be skipped."
                Write-Warning "To enable PDF generation, install a LaTeX distribution like MiKTeX or TeX Live."
                return $false
            }
        }
    }

    Write-Host "Converting $InputPath to $Format..." -ForegroundColor Cyan
    # Use full path to latest pandoc if available, otherwise use pandoc command
    # Check user directory for latest version first
    $pandocPaths = @(
        "$env:USERPROFILE\Pandoc-3.8.2.1\pandoc.exe",  # Latest hardcoded version
        "$env:USERPROFILE\AppData\Local\Pandoc\pandoc.exe"  # Fallback
    )

    $pandocExe = $null
    foreach ($path in $pandocPaths) {
        if (Test-Path $path) {
            $pandocExe = $path
            break
        }
    }

    if ($pandocExe) {
        Write-Host "Using Pandoc: $pandocExe" -ForegroundColor Gray
        & $pandocExe $pandocArgs
    } else {
        Write-Host "Using Pandoc from PATH" -ForegroundColor Gray
        & pandoc $pandocArgs
    }

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Successfully generated $Format document: $OutputPath" -ForegroundColor Green
        return $true
    } else {
        Write-Host "Failed to generate $Format document" -ForegroundColor Red
        return $false
    }
}

# Main script logic
Write-Host "Document Generation Tool" -ForegroundColor Cyan
Write-Host "=======================" -ForegroundColor Cyan

# Validate file extension
$inputExtension = [System.IO.Path]::GetExtension($InputFile).ToLower()
if ($inputExtension -ne '.md' -and $inputExtension -ne '.markdown') {
    Write-Host "Error: Input file '$InputFile' is not a Markdown file." -ForegroundColor Red
    Write-Host "This script only supports .md and .markdown files." -ForegroundColor Red
    Write-Host ""
    Write-Host "Supported file types:" -ForegroundColor Yellow
    Write-Host "  - .md files" -ForegroundColor White
    Write-Host "  - .markdown files" -ForegroundColor White
    Write-Host ""
    Write-Host "For help, run: .\Convert-Document.ps1 -h" -ForegroundColor Yellow
    exit 1
}

# Determine output file if not specified
if (!$OutputFile) {
    $inputDir = Split-Path $InputFile -Parent
    $inputBaseName = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)

    # If inputDir is empty (file in current directory), use current directory
    if ([string]::IsNullOrEmpty($inputDir)) {
        $inputDir = Get-Location
    }

    $OutputFile = Join-Path $inputDir "$inputBaseName-output"
}

# Display configuration
Write-Host "Configuration:" -ForegroundColor Cyan
Write-Host "  Input File: $InputFile" -ForegroundColor White
Write-Host "  Output Directory: $outputsDir" -ForegroundColor White
Write-Host "  Formats: $($Formats -join ', ')" -ForegroundColor White
Write-Host "  Template Directory: $TemplateDir" -ForegroundColor White
Write-Host "  Partner: $Partner" -ForegroundColor White
if ($Client) { Write-Host "  Client: $Client" -ForegroundColor White }
if ($IncludeToc) { Write-Host "  Include TOC: Yes (depth: $TocDepth)" -ForegroundColor White }
if ($ResourcePath) { Write-Host "  Resource Path: $ResourcePath" -ForegroundColor White }
if ($Title) { Write-Host "  Title: $Title" -ForegroundColor White }
if ($ProcessMermaid) { Write-Host "  Process Mermaid: Yes (formats: $($MermaidFormats -join ', '))" -ForegroundColor White }
if ($Formats -contains "docx") { Write-Host "  DOCX Mermaid Processing: Automatically enabled (PNG & SVG, max width: 600px)" -ForegroundColor Blue }

# Check if template directory exists
if (!(Test-Path $TemplateDir)) {
    Write-Warning "Template directory not found: $TemplateDir"
    Write-Warning "Create it with: New-Item -ItemType Directory -Path '$TemplateDir\[partner-name]', '$TemplateDir\[client-name]' -Force"
    Write-Warning "For deployment, copy templates to: $env:USERPROFILE\Documents"
}

# Generate documents in requested formats
$successCount = 0
$generatedFiles = @()
foreach ($format in $Formats) {
    $proposedPath = "$OutputFile.$format"
    if (Test-Path $proposedPath) {
        $response = Read-Host "File $proposedPath exists. Overwrite (Y/n) or create incremental (i)?"
        if ($response -eq 'i' -or $response -eq 'I') {
            $outputFilePath = Get-UniqueFileName $OutputFile ".$format"
        } elseif ($response -match '^(y|Y|)$') {
            $outputFilePath = $proposedPath
        } else {
            Write-Host "Skipping $format" -ForegroundColor Yellow
            continue
        }
    } else {
        $outputFilePath = $proposedPath
    }

    # Automatically enable Mermaid processing for DOCX files
    $processMermaidForFormat = $ProcessMermaid
    if ($format -eq "docx") {
        $processMermaidForFormat = $true
        Write-Host "Automatically enabling Mermaid diagram processing for DOCX format" -ForegroundColor Blue
    }

    $success = Convert-ToDocument `
        -InputPath $InputFile `
        -OutputPath $outputFilePath `
        -Format $format `
        -TemplateDir $TemplateDir `
        -Partner $Partner `
        -Client $Client `
        -IncludeToc:$IncludeToc `
        -TocDepth $TocDepth `
        -ResourcePath $ResourcePath `
        -Title $Title `
        -ProcessMermaid:$processMermaidForFormat `
        -MermaidFormats $MermaidFormats

    if ($success) {
        $successCount++
        $generatedFiles += $outputFilePath
    }
}

Write-Host "`nDocument Generation Complete!" -ForegroundColor Green
Write-Host "Successfully generated $successCount of $($Formats.Count) formats." -ForegroundColor Cyan

if ($successCount -gt 0) {
    Write-Host "`nGenerated files:" -ForegroundColor Cyan
    foreach ($file in $generatedFiles) {
        Write-Host "  - $file" -ForegroundColor White
    }
}

Write-Host "`nDocument Generation Tool v$ScriptVersion" -ForegroundColor Cyan
Write-Host "For usage examples, run: .\Convert-Document.ps1 -Help" -ForegroundColor Yellow