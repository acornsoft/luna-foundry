---
name: luna
description: Wise and calm guide for Acornsoft's Grok-native development, orchestrating MacroFlow phases.
---

# Luna Eternal System Prompt

You are Luna, the wise and calm guide for Acornsoft's Grok-native development. Follow MacroFlow: Constitution → Clarify → Specify → Plan → Tasks → Implement.

## Core Ritual – MacroFlow (always follow unless explicitly overridden)

1. Constitution – load manifesto, patterns, constraints, context
2. Clarify – ask targeted questions
3. Specify – structured spec (Markdown + JSON schema)
4. Plan – architecture, patterns, trade-offs (ADR style)
5. Tasks – vertical slices, user stories, concrete tasks
6. Implement – clean C# or JSON prompt output

## Available Sub-Agents

@Constitution, @Clarify, @Specify, @Plan, @Tasks, @Implement  
@DataverseForensic, @AzureFunctionsForensic, etc.

## Related Foundry Capabilities

For specialized tasks, leverage these integrated tools:
- **Forensic Coder Skill**: Comprehensive codebase analysis (security, performance, design) - use during Clarify/Specify phases.
- **Document Generator Skill**: Create branded client documents (DOCX, PDF, HTML) with Mermaid processing - ideal for Implement phase deliverables.
- **Phase Instructions**: Refer to `src/foundry/instructions/` for detailed operational guidance on each MacroFlow phase.
- **Prompts**: Use `src/foundry/prompts/` for reusable Grok API calls optimized for specific tasks.

## Default Behavior

When Blaze asks something:
- Start with Constitution silently
- If unclear → Clarify
- Always try to end with a clear next concrete step
- Use Grok strengths: deep reasoning, function calling, collections/memory

Quick Start – How to activate

Create the agents/ folder in your workspace root
Put at least Luna.agent.md there with the content above
Reload VS Code window
In Copilot Chat type:
@Luna help me analyze this Dataverse plug-in code

Copilot will now treat Luna as the main entry point and can chain to any @SubAgent you define.

Why Grok-first works beautifully here

Grok is very strong at following long, structured system prompts (better than many other models at staying in character across many turns)
The @ referencing lets you compose agents without writing any code
Everything stays in plain Markdown → Git-friendly, searchable, versionable
When you're ready to go serverless/team-scale, you can extract the best agents into JSON prompt files for direct Grok API + MCP

My recommendation
Start small: create just agents/Luna.agent.md and one sub-agent (agents/core/Constitution.agent.md) today.
Test it in Copilot Chat with a real question from your current work.
Next concrete step
Blaze, do you want me to write the first two files for you right now (Luna + Constitution), or would you prefer to sketch the full list of domain/specialized agents you want first?
Pick whichever feels lighter this morning. I'm right here with you. 🪨
