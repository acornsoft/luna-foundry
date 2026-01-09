---
name: clarify
description: Refine user intent through questions and context gathering in MacroFlow.
---

# Clarify Skill

## Overview

The Clarify phase gathers and refines requirements, eliminating ambiguities through targeted questions and analysis. It ensures truth-seeking by probing assumptions and validating inputs. For business problem/solution development, this phase iterates on neutral Markdown from raw notes, leveraging roles (e.g., Azure Integration Specialist, Mulesoft Specialist) for reviews, analysis sessions, and ADO MCP tracking, time-boxed to 32 hours.

## Purpose

- Gather detailed requirements from raw notes and customer inputs
- Identify and resolve ambiguities via role-based reviews (docs, code, industry updates)
- Validate stakeholder needs and assumptions
- Prepare neutral analysis Markdown for Plan phase

## Inputs

- Constitutional framework (principles, roles, constraints)
- Initial requirements (raw notes, business problems)
- Stakeholder feedback and existing assets (docs, code)

## Process

1. Gather initial inputs: Start with raw notes/customer requirements; roles review existing docs/code (e.g., Azure Solution Architect checks resources, SAP Functional Consultant audits systems).
2. Conduct analysis sessions: Time-box to 32 hours; facilitate iterative sessions where roles build neutral Markdown (sections for findings, Mermaid diagrams); Luna agent orchestrates by prompting questions and validating via ADO work items.
3. Resolve ambiguities: Ask targeted questions (e.g., "What integration constraints?"); leverage MCP Servers/LLMs for focused pulls; roles refine based on knowledge; agents ensure neutrality and completeness.
4. Sync with ADO: Use MCP servers (e.g., acornsoftDevOpsServer) to query/create/link work items for findings, enabling multi-instance forensics.
5. Establish repos/instances: Ask series of questions to add Git repos and ADO/Jira instances.
   - What Git repositories to include? (Provide URLs for GitHub/ADO repos)
   - What Azure DevOps instances/projects? (Org, project, area, iteration)
   - Any Jira instances? (URL, project)
   - Automate: Clone repos via script, configure MCP for instances.
   - Manual: Update mcp.json or run CLI commands.

## Clarify Questions for Setup

- Initial Check: "Do you need to establish any Git repositories and/or Azure DevOps instances before proceeding? (Yes/No)"
  - If Yes: Proceed to repo/instance questions; automate via Agent (Luna sub-agents) or PowerShell script, query MCP servers for validation.
- Environment Check: "Is Visual Studio Code Insiders installed and configured? Confirm MCP servers (acornsoftDevOpsServer, ecolabDevOpsServer) are set in ~/.vscode-insiders/User/mcp.json. Is Luna Foundry setup complete (run setup-luna-foundry.ps1)?"
- Git Repos: "List Git repository URLs to clone (e.g., https://github.com/user/repo.git)."
- ADO Instances: "Provide ADO org/project/area/iteration (e.g., acornsoft/com.acornsoft365/com.acornsoft365\(ASFT) Luna Foundry/com.acornsoft365\2026.1)."
- Jira: "Any Jira instances? Provide URL and project key."
- Additions: "Can add more at any time via setup script or MCP."

## Outputs

- Refined requirements document (neutral analysis Markdown)
- Clarified scope, boundaries, and resolved ambiguities
- ADO work item links for tracking

## Grok Integration

Use Grok for probing questions and assumption validation. Temperature: 0.7 for exploratory dialogue. Luna sub-agents (e.g., @Clarify) orchestrate iterations and pulls.

## Next Phase

Proceed to Specify when requirements are clear, using MacroFlow-Analysis.md as a real-world example for process improvement.

## Instructions
1. Ask targeted clarifying questions.
2. Gather context from workspace or web.
3. Use Grok X-insights for real-time data.
4. Resolve assumptions.

## Examples
- Input: Vague query.
- Output: Refined spec.

## Learned Patterns
- Parallel with Constitution.