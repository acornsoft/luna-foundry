---
name: constitution
description: Load and confirm core principles, guardrails, and project context for MacroFlow sessions.
---

# Constitution Skill

## Overview

The Constitution phase establishes the foundational principles, constraints, and manifesto for the project. It ensures alignment with Grok-native ecosystem, xAI principles, and truth-seeking development. For business problem/solution development and analysis, this phase sets the stage for neutral Markdown capture by roles like Functional Consultant, Azure Solution Architect, etc., ensuring time-boxed (32-hour) analysis and ADO MCP integration.

## Purpose

- Define project vision and core values for requirements capture
- Establish technical and operational constraints (e.g., neutral Markdown, no branding)
- Align with Grok/xAI first principles and role-based collaboration
- Set the tone for lean, mean, truth-seeking development from raw notes to analysis

## Inputs

- High-level project requirements (business problems, solutions)
- Stakeholder goals (e.g., client-neutral docs)
- Existing patterns, constraints, and role assignments

## Process

1. Review manifesto and Grok principles, confirming Grok-only stack and truth-seeking.
2. Identify key constraints: 32-hour time-box for analysis, neutral Markdown (no branding), ADO MCP for work items, role-specific domains (e.g., SAP for ERP, Azure for cloud).
3. Define success criteria: Complete analysis Markdown ready for Plan phase, with ADO links.
4. Assign roles and orchestration: Functional Consultant for raw notes, Requirements Specialist for framework; Luna agent loads guardrails and prompts alignment.
5. Configure MCP servers: Ensure acornsoftDevOpsServer are set for multi-instance ADO access in analysis/forensics.
6. Check dependencies: Confirm VS Code Insiders/VS Code with skills, PowerShell 7+, Node.js, Pandoc, Azure CLI, Azure DevOps CLI, required extensions (GitHub Copilot, vscode-awesome-copilot, Mermaid Markdown Syntax Highlighting), MCP support, repos, and ADO PAT are installed/configured; if not, ask user and guide setup (refer to setup.instructions.md). Verify access to Azure DevOps via MCP Server (acornsoftDevOpsServer in mcp.json) for work item tracking and artifact links.
7. Document foundational decisions: Output constitutional framework with principles, roles, and boundaries.

## Outputs

- Constitutional framework document (neutral Markdown)
- Key principles, constraints, and role assignments
- Dependency confirmation (e.g., VS Code, PowerShell 7, Node.js, Pandoc, extensions, repos setup)
- Alignment confirmation with xAI ecosystem and ADO integration

## Grok Integration

Use Grok for first-principles reasoning to validate foundations. Temperature: 0.7 for creative alignment. Luna sub-agents (e.g., @Constitution) auto-load and enforce.

## Next Phase

Proceed to Clarify when foundations are established, using MacroFlow-Analysis.md as a real-world example for iteration.

## Instructions

1. Load manifesto, Grok-native constraints, and current project context.
2. Confirm guardrails: xAI/Grok stack, C# primacy, vertical slices, Apple-like UX.
3. Reference key patterns: CQRS, Repository, Strategy, Composition over Inheritance.
4. Output immutable rules applied globally.

## Examples

- Input: Start MacroFlow for new project.
- Output: Summary of loaded context and constraints.

## Learned Patterns

- Always start sessions with Constitution for consistency.
- Integrate with Grok modes for reasoning.