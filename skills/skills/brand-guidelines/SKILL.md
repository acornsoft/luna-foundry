---
name: brand-guidelines
description: Applies Acornsoft's official brand colors and typography to any sort of artifact that may benefit from having Acornsoft's look-and-feel. Use it when brand colors or style guidelines, visual formatting, or company design standards apply.
license: Complete terms in LICENSE.txt
---

# ACORNSOFT Brand Styling

## Overview

To access Acornsoft's official brand identity and style resources, use this skill.

**Keywords**: branding, corporate identity, visual identity, post-processing, styling, brand colors, typography, Acornsoft brand, visual formatting, visual design

## Brand Guidelines

### Colors

**Main Colors:**

- Dark: `#4f2001` - Primary text and dark backgrounds
- Light: `#ff9900` - Light backgrounds and text on dark
- Mid Gray: `#b0aea5` - Secondary elements
- Light Gray: `#e8e6dc` - Subtle backgrounds

**Accent Colors:**

- Orange: `#d97757` - Primary accent
- Blue: `#6a9bcc` - Secondary accent
- Green: `#788c5d` - Tertiary accent

### Typography

- **Headings**: Whitney K Bold (with Arial Black fallback)
- **Body Text**: Whitney K Light (with Arial fallback)
- **Note**: Fonts should be pre-installed in your environment for best results

## Features

### Smart Font Application

- Applies Whitney K Bold font to headings (24pt and larger)
- Applies Whitney K Light font to body text
- Automatically falls back to Arial Black/Arial if custom fonts unavailable
- Preserves readability across all systems

### Text Styling

- Headings (24pt+): Whitney K Bold font
- Body text: Whitney K Light  font
- Smart color selection based on background
- Preserves text hierarchy and formatting

### Shape and Accent Colors

- Non-text shapes use accent colors
- Cycles through orange, blue, and green accents
- Maintains visual interest while staying on-brand

## Technical Details

### Font Management

- Uses system-installed Whitney K fonts when available
- Provides automatic fallback to Arial Black (headings) and Arial (body)
- No font installation required - works with existing system fonts
- For best results, pre-install Whitney K fonts in your environment

### Color Application

- Uses RGB color values for precise brand matching
- Applied via python-pptx's RGBColor class
- Maintains color fidelity across different systems
