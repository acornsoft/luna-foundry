# Forensic Coder Skill

## Overview

The Forensic Coder is a specialized skill for conducting comprehensive analysis of existing codebases. It performs high-level overviews followed by deep dives across security, authentication, authorization, design patterns, error handling, performance, and other critical aspects.

## Purpose

- Analyze existing codebases from git/GitHub/Azure DevOps
- Identify security vulnerabilities, auth issues, and performance bottlenecks
- Evaluate design patterns, error handling, and code quality
- Provide actionable insights for refactoring or maintenance

## Scope

- Multi-repo analysis
- Integration with code analysis tools via MCP
- Grok-first reasoning for unbiased assessments
- Markdown reports with structured findings

## Phases

1. **High-Level Analysis**: Overview of codebase structure, dependencies, and key metrics
2. **Deep Dive Analysis**:
   - Security: Vuln scanning, auth/authz flows
   - Design Patterns: Architecture evaluation
   - Error Handling: Exception management
   - Performance: Bottlenecks and optimizations
   - Code Quality: Standards compliance

## Inputs

- Repository URLs or local paths
- Analysis scope (full or targeted)
- Specific concerns (e.g., security-only)

## Outputs

- Comprehensive analysis report in Markdown
- Actionable recommendations
- Risk assessments and priorities

## Tools Integration

- MCP servers for static analysis (e.g., ESLint, SonarQube)
- Git APIs for repo access
- Custom prompts for Grok analysis

## Usage

Invoke via MacroFlow Clarify or Specify phases for codebase evaluation. Use sub-skills for focused analyses.
