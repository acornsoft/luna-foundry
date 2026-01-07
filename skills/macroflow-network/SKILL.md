---
name: macroflow-network
description: Orchestrate MacroFlow as a flow network for dynamic AI orchestration.
---

# MacroFlow Network Skill

## Instructions
1. Load graph from graph.json (nodes: Constitution, Clarify, Specify, Plan, Tasks, Implement; edges with capacities).
2. Simulate max-flow using Ford-Fulkerson for optimization.
3. Traverse: Parallel start Constitution/Clarify, merge at Plan, etc.
4. Invoke sub-skills for each node with flow data.
5. Output: Final result at sink.

## Examples
- Input: Code gen query.
- Output: Orchestrated phases with Grok insights.

## Learned Patterns
- Parallel phases for speed; Grok X-insights in Clarify.