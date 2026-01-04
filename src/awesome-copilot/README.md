# MacroFlow Customizations

A created collection of custom agents, prompts, and instructions to supercharge your xAI Grok experience across different domains, languages, and use cases. Built on the MacroFlow Foundry foundation and optimized for Grok's unique multi-modal capabilities, real-time research, and xAI intelligence.

## What is MacroFlow?

This repository provides a comprehensive toolkit for enhancing xAI Grok with specialized:

- **[MacroFlow Agents](docs/README.agents.md)** - Specialized Grok agents that leverage xAI's multi-modal tools (voice, images, real-time search) for enhanced capabilities in specific workflows
- **[MacroFlow Prompts](docs/README.prompts.md)** - Focused, task-specific prompts optimized for Grok's intelligent analysis and code generation
- **[MacroFlow Instructions](docs/README.instructions.md)** - Comprehensive coding standards and best practices enhanced with Grok's predictive insights
- **[MacroFlow Skills](docs/README.skills.md)** - Self-contained folders with instructions and bundled resources that maximize Grok's specialized task capabilities
- **[MacroFlow Collections](docs/README.collections.md)** - Curated collections of related prompts, instructions, and chat modes organized around specific themes and workflows, powered by Grok's intelligence

## Grok-Specific Advantages

- **Multi-Modal Integration**: Voice synthesis for demos, image generation for diagrams, real-time web search
- **Real-Time Intelligence**: Access to current documentation, community knowledge, and live data
- **Predictive Analysis**: AI-powered insights for fit-gap analysis, risk assessment, and optimization
- **Intelligent Code Generation**: Context-aware code snippets with Grok's deep understanding
- **xAI Knowledge Base**: Leverages xAI's comprehensive training data for superior responses

## MacroFlow Integration

This repository integrates with Luna MacroFlow Foundry - a Grok-powered development orchestration system that uses these agents and prompts to systematically build software through structured phases.

**Key Features:**

- **Phased Development**: Constitution → Clarify → Specify → Plan → Tasks → Implement → AgentCreation
- **Grok-Optimized**: Leverages xAI's multi-modal capabilities throughout the development process
- **Agent Factory**: Automatically generates new Grok agents using the AgentCreation phase
- **D365 Expertise**: Specialized D365Consult phase for Dynamics 365 implementations

### Using MacroFlow with MacroFlow Grok

1. **Run MacroFlow** with a use case to generate agents:

   ```json
   {
     "useCase": "Create Agent",
     "context": "expert React developer with modern hooks and performance optimization"
   }
   ```

2. **The system will**:
   - Use Grok's intelligence to analyze requirements
   - Generate comprehensive agent documentation
   - Output in MacroFlow-grok compatible Markdown format
   - Add to the agents collection automatically

## Featured Collections

Discover our curated collections of prompts, instructions, and agents organized around specific themes and workflows.

TBD

## MCP Server (Grok-Optimized)

To make it easy to add these Grok customizations to your editor, we have adapted the MCP Server for xAI integration. You'll need Docker and access to Grok API.

<details>
<summary>Show MCP Server JSON configuration</summary>

```json
{
  "servers": {
    "MacroFlow-grok": {
      "type": "stdio",
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "ghcr.io/microsoft/mcp-dotnet-samples/awesome-copilot:latest"
      ]
    }
  }
}
```

</details>

## Why Use MacroFlow?

- **Productivity**: Pre-built agents, prompts and instructions save time and provide consistent results.
- **Best Practices**: Benefit from community-curated coding standards and patterns.
- **Specialized Assistance**: Access expert-level guidance through specialized custom agents.
- **Continuous Learning**: Stay updated with the latest patterns and practices across technologies.

## 📖 Repository Structure

```plaintext
├── prompts/          # Task-specific prompts (.prompt.md)
├── instructions/     # Coding standards and best practices (.instructions.md)
├── agents/           # AI personas and specialized modes (.agent.md)
├── collections/      # Curated collections of related items (.collection.yml)
└── scripts/          # Utility scripts for maintenance
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ℹ️ Disclaimer

The customizations in this repository are sourced from and created by third-party developers. GitHub does not verify, endorse, or guarantee the functionality or security of these agents. Please carefully inspect any agent and its documentation before installing to understand permissions it may require and actions it may perform.

