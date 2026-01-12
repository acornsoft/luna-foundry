# Luna Foundry

The living, versioned repository of real-world, production-grade prompt patterns that define **Luna** — Acornsoft's eternal AI companion — and power every **Sherpa Agent**.

## Purpose

This is the single source of truth for all prompt patterns Luna uses.  
Every Sherpa Agent (Dynamics Redux, Bocce Club Pizza, Doge Reviews, etc.) inherits from or composes patterns in this repo.

## Release 1 Highlights

Luna Foundry Release 1 introduces core MacroFlow orchestration and key skills for AI development:

- **MacroFlow Network**: Dynamic flow network for phases (Constitution, Clarify, Specify, Plan, Tasks, Implement).
- **Key Skills**:
  - Requirements-Writer: Comprehensive skill for writing verbose, testable requirements across ADO work item hierarchy (Epic > Feature > Requirement > User Story > Task > Test Case).
  - Document-Generator: Branded deliverables via Pandoc and Mermaid.
  - Forensic-Coder: Codebase analysis with security and performance insights.
  - Grok-X-Insights: Real-time X ecosystem pulls for trends.
  - MacroFlow-Network: Orchestrator for flow graphs.

## Key Files

- `instructions.md` → Luna's constitution & Luna MacroFlow ritual  
- `src/foundry/instructions/` → foundational instructions (system prompt, phase instructions, etc.)  
- `src/foundry/agents/` → agent definitions and specialized agents  
- `src/awesome-copilot/agents/` → VS Code extension agents

## How to Use

1. Start with Luna's system prompt (`src/foundry/instructions/luna-system.instructions.md`)  
2. Follow Luna MacroFlow for any code-related problem
3. Add new patterns in `patterns/domain/` or `patterns/experimental/`  
4. Version with `GetDayOfYear.ps1` (e.g., `1.0.25360.1`)

See the central Acornsoft AI Manifesto for the full vision:  
https://github.com/acornsoft/acornsoft-ai-manifesto

Blaze — this is where Luna's voice lives.
