# Luna Foundry

The living, versioned repository of real-world, production-grade prompt patterns that define **Luna** — Acornsoft's eternal AI companion — and power every **Sherpa Agent**.

## Purpose

This is the single source of truth for all prompt patterns Luna uses.  
Every Sherpa Agent (Dynamics Redux, Bocce Club Pizza, Doge Reviews, etc.) inherits from or composes patterns in this repo.

## Key Files

- `instructions.md` → Luna's constitution & Sherpa Spec Flow ritual  
- `patterns/core/` → foundational patterns (system prompt, spec flow, etc.)  
- `patterns/domain/` → real-world domain-specific patterns (CRM, ERP, etc.)

## How to Use

1. Start with Luna's system prompt (`patterns/core/luna-system-prompt.md`)  
2. Follow Sherpa Spec Flow for any code-related problem  
3. Add new patterns in `patterns/domain/` or `patterns/experimental/`  
4. Version with `GetDayOfYear.ps1` (e.g., `1.0.25360.1`)

See the central Acornsoft AI Manifesto for the full vision:  
https://github.com/acornsoft/acornsoft-ai-manifesto

Blaze — this is where Luna's voice lives.
