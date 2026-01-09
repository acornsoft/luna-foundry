# Work Items for Sub-Agent Development in Luna Foundry

## Feature: Develop MacroFlow Sub-Agents
**ID**: Feature-002  
**Title**: Develop and Refine MacroFlow Sub-Agents  
**Description**: Create and refine each MacroFlow sub-agent (Constitution, Clarify, Specify, Plan, Tasks, Implement) with skills, ensuring they support Luna Foundry's structured development.  
**Priority**: High  
**Assigned To**: David Blaszyk  
**State**: Active  

### User Story: As a developer, I want to develop the Constitution sub-agent so that it loads manifesto, patterns, constraints, and checks setup.
**ID**: US-002  
**Title**: Develop Constitution Sub-Agent  
**Description**: Build the Constitution sub-agent to handle initial setup and guardrails.  
**Acceptance Criteria**:  
- SKILL.md created/updated with full details.  
- Integrates with Luna agent handoffs.  
- Tested for loading context and setup checks.  
- Ensures prerequisites installed (VS Code, PowerShell, Node.js, etc.) and access to Azure DevOps via MCP Server (acornsoftDevOpsServer in mcp.json).  
- Neutral and Grok-native.  

#### Tasks:
- **Task-008**: Define Constitution requirements.  
  **Description**: Outline what Constitution does (load manifesto, check setup).  
  **State**: Pending  

- **Task-009**: Create/Update Constitution SKILL.md.  
  **Description**: Write detailed instructions, examples, learned patterns.  
  **State**: Pending  

- **Task-010**: Integrate with Luna agent.  
  **Description**: Ensure handoff works in Luna.agent.md.  
  **State**: Pending  

- **Task-011**: Test Constitution sub-agent.  
  **Description**: Run and verify it loads context correctly.  
  **State**: Pending  

### User Story: As a developer, I want to develop the Clarify sub-agent so that it refines user intent through questions and context gathering.
**ID**: US-003  
**Title**: Develop Clarify Sub-Agent  
**Description**: Build the Clarify sub-agent for gathering details and resolving ambiguities.  
**Acceptance Criteria**:  
- SKILL.md created/updated with full details.  
- Supports parallel execution with Constitution.  
- Tested for questioning and context pulls.  
- Neutral and Grok-native.  

#### Tasks:
- **Task-012**: Define Clarify requirements.  
  **Description**: Outline questioning strategies, repo/instance setup.  
  **State**: Pending  

- **Task-013**: Create/Update Clarify SKILL.md.  
  **Description**: Write detailed instructions, examples, learned patterns.  
  **State**: Pending  

- **Task-014**: Integrate with Luna agent.  
  **Description**: Ensure handoff works in Luna.agent.md.  
  **State**: Pending  

- **Task-015**: Test Clarify sub-agent.  
  **Description**: Run and verify it gathers context correctly.  
  **State**: Pending  

### User Story: As a developer, I want to develop the Specify sub-agent so that it defines functional/non-functional specs.
**ID**: US-004  
**Title**: Develop Specify Sub-Agent  
**Description**: Build the Specify sub-agent for structured specs and schemas.  
**Acceptance Criteria**:  
- SKILL.md created/updated with full details.  
- Produces Markdown + JSON outputs.  
- Tested for spec generation.  
- Neutral and Grok-native.  

#### Tasks:
- **Task-016**: Define Specify requirements.  
  **Description**: Outline spec creation, ADR trade-offs.  
  **State**: Pending  

- **Task-017**: Create/Update Specify SKILL.md.  
  **Description**: Write detailed instructions, examples, learned patterns.  
  **State**: Pending  

- **Task-018**: Integrate with Luna agent.  
  **Description**: Ensure handoff works in Luna.agent.md.  
  **State**: Pending  

- **Task-019**: Test Specify sub-agent.  
  **Description**: Run and verify it generates specs correctly.  
  **State**: Pending  

### User Story: As a developer, I want to develop the Plan sub-agent so that it chooses architecture, patterns, tech stack, trade-offs.
**ID**: US-005  
**Title**: Develop Plan Sub-Agent  
**Description**: Build the Plan sub-agent for planning and ADR decisions.  
**Acceptance Criteria**:  
- SKILL.md created/updated with full details.  
- Includes architecture options (CQRS, Minimal API, etc.).  
- Tested for trade-off analysis.  
- Neutral and Grok-native.  

#### Tasks:
- **Task-020**: Define Plan requirements.  
  **Description**: Outline architecture selection, implementation sequences.  
  **State**: Pending  

- **Task-021**: Create/Update Plan SKILL.md.  
  **Description**: Write detailed instructions, examples, learned patterns.  
  **State**: Pending  

- **Task-022**: Integrate with Luna agent.  
  **Description**: Ensure handoff works in Luna.agent.md.  
  **State**: Pending  

- **Task-023**: Test Plan sub-agent.  
  **Description**: Run and verify it plans correctly.  
  **State**: Pending  

### User Story: As a developer, I want to develop the Tasks sub-agent so that it breaks into vertical slices, user stories, concrete tasks.
**ID**: US-006  
**Title**: Develop Tasks Sub-Agent  
**Description**: Build the Tasks sub-agent for decomposition and prioritization.  
**Acceptance Criteria**:  
- SKILL.md created/updated with full details.  
- Creates task breakdowns and backlogs.  
- Tested for task generation.  
- Neutral and Grok-native.  

#### Tasks:
- **Task-024**: Define Tasks requirements.  
  **Description**: Outline vertical slices, user stories, estimates.  
  **State**: Pending  

- **Task-025**: Create/Update Tasks SKILL.md.  
  **Description**: Write detailed instructions, examples, learned patterns.  
  **State**: Pending  

- **Task-026**: Integrate with Luna agent.  
  **Description**: Ensure handoff works in Luna.agent.md.  
  **State**: Pending  

- **Task-027**: Test Tasks sub-agent.  
  **Description**: Run and verify it decomposes correctly.  
  **State**: Pending  

### User Story: As a developer, I want to develop the Implement sub-agent so that it generates clean C# code and artifacts.
**ID**: US-007  
**Title**: Develop Implement Sub-Agent  
**Description**: Build the Implement sub-agent for code generation and deployment.  
**Acceptance Criteria**:  
- SKILL.md created/updated with full details.  
- Generates production-ready code with #region.  
- Tested for code output.  
- Neutral and Grok-native.  

#### Tasks:
- **Task-028**: Define Implement requirements.  
  **Description**: Outline code generation, testing, deployment.  
  **State**: Pending  

- **Task-029**: Create/Update Implement SKILL.md.  
  **Description**: Write detailed instructions, examples, learned patterns.  
  **State**: Pending  

- **Task-030**: Integrate with Luna agent.  
  **Description**: Ensure handoff works in Luna.agent.md.  
  **State**: Pending  

- **Task-031**: Test Implement sub-agent.  
  **Description**: Run and verify it generates code correctly.  
  **State**: Pending