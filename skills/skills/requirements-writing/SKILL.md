# Requirements-Writing Skill

## Overview
This skill specializes in leveraging Azure DevOps Work Items to write comprehensive requirements. It supports the full hierarchy: Epic, Feature, Requirement (custom type), User Story, Task, and Test Case. The skill analyzes real-world examples from Azure DevOps instances to develop standards for content, detail, and specificity at each level.

## Purpose
- Analyze existing Work Item trees in read-only mode.
- Define templates and standards for each Work Item type based on real data.
- Generate processes for creating compliant Work Items that meet organizational standards.
- Integrate with MacroFlow for requirements gathering and refinement.

## Inputs
- Azure DevOps instance connection (e.g., ecolabDevelopmentServer).
- Specific releases or projects (e.g., FBU 1C Release 1 and 2).
- Work Item hierarchy data.

## Process
1. Query and extract Work Item trees using MCP servers.
2. Analyze content depth, specificity, and relationships.
3. Develop templates and checklists for each type.
4. Validate against MacroFlow principles.

## Outputs
- Standardized Work Item templates.
- Process documentation for requirements writing.
- Integration guides for ADO and MacroFlow.

## Dependencies
- Azure DevOps MCP access.
- Forensic analysis tools for data extraction.

## Markdown Enforcement Integration

### Overview
This skill now integrates with the Azure CLI Markdown Enforcer extension to automatically ensure all work items use proper Markdown formatting for multiline fields. This is critical for consistent rendering and readability across Azure DevOps.

### Prerequisites
1. **Install the Markdown Enforcer extension:**
   ```bash
   az extension add --source markdown-enforcer-0.1.0.tar.gz
   ```

2. **Verify installation:**
   ```bash
   az extension list | grep markdown-enforcer
   ```

### Automated Markdown Enforcement

#### For Release Iterations
```powershell
# Enforce Markdown on all work items in "Luna Foundry Release 1"
.\Scripts\Set-Markdown-Fields.ps1 -IterationPath "Luna Foundry Release 1"
```

#### For Specific Work Item Types
```powershell
# Enforce Markdown on all User Stories
.\Scripts\Set-Markdown-Fields.ps1 -WIQL "SELECT [System.Id] FROM WorkItems WHERE [System.WorkItemType] = 'User Story'"
```

#### For Specific Work Items
```powershell
# Enforce Markdown on specific work item IDs
.\Scripts\Set-Markdown-Fields.ps1 -WorkItemIds 123, 456, 789
```

#### Dry Run Mode
```powershell
# Preview changes without applying them
.\Scripts\Set-Markdown-Fields.ps1 -IterationPath "Luna Foundry Release 1" -DryRun
```

### Fields Enforced
The extension automatically enforces Markdown format on:
- `System.Description` - Main work item description
- `Microsoft.VSTS.Common.AcceptanceCriteria` - Acceptance criteria for requirements/stories
- `Microsoft.VSTS.TCM.ReproSteps` - Test case reproduction steps

### Integration with Work Item Creation Process

#### Recommended Workflow
1. **Create work items** using the templates provided in this skill
2. **Write content in Markdown** format from the start
3. **Run enforcement script** to ensure proper formatting:
   ```powershell
   .\Scripts\Set-Markdown-Fields.ps1 -IterationPath "Your Release Name"
   ```
4. **Validate compliance** using the extension's validation tools

### Integrated Work Item Creation with Markdown Enforcement

#### Automated Creation and Formatting
```powershell
# Create a User Story with automatic Markdown enforcement
.\Scripts\New-WorkItemWithMarkdown.ps1 `
    -WorkItemType UserStory `
    -Title "As a user, I want to login so that I can access my account" `
    -Description @"
## User Story: As a user, I want to login so that I can access my account

**Context**: Users need secure access to their accounts.

**Acceptance Criteria**:
- Scenario: Successful login
  Given the user has valid credentials
  When they enter username and password
  Then they should be logged in and redirected to dashboard
"@
    -AssignedTo "developer@company.com" `
    -IterationPath "Luna Foundry Release 1"
```

#### Batch Processing Examples
```powershell
# Create multiple work items for a feature
$featureId = .\Scripts\New-WorkItemWithMarkdown.ps1 -WorkItemType Feature -Title "User Authentication" -IterationPath "Luna Foundry Release 1"

# Create user stories under the feature
.\Scripts\New-WorkItemWithMarkdown.ps1 -WorkItemType UserStory -Title "Login Functionality" -ParentId $featureId -IterationPath "Luna Foundry Release 1"
.\Scripts\New-WorkItemWithMarkdown.ps1 -WorkItemType UserStory -Title "Password Reset" -ParentId $featureId -IterationPath "Luna Foundry Release 1"
```

#### Template Validation
The script automatically validates that your content follows the recommended templates and warns if it doesn't match expected formats.

### Complete Workflow Example

#### 1. Create Epic with Template
```powershell
# Create an Epic using the recommended template format
$epicId = .\Scripts\New-WorkItemWithMarkdown.ps1 `
    -WorkItemType Epic `
    -Title "Luna Foundry AI Integration Platform" `
    -Description @"
## Epic: Luna Foundry AI Integration Platform
**ID**: Epic-LF-001
**Title**: Luna Foundry AI Integration Platform

### Business Objectives
Enable seamless AI-powered development workflows across all Luna Foundry projects through integrated tooling and automation.

### Key Objectives
- Provide unified AI assistance for code generation and review
- Enable automated testing and validation
- Support multi-language development workflows

### Business Requirements
- Integration with VS Code and GitHub Copilot
- Support for .NET, Python, and TypeScript development
- Automated deployment and release management

### Technical Requirements
- RESTful API integration with GitHub
- Azure DevOps work item synchronization
- Markdown-based documentation generation

### Expected Deliverables
- Luna AI Agent framework
- Integrated development environment
- Automated release pipelines

### Acceptance Criteria
- All Luna Foundry projects use AI-assisted development
- 90% reduction in manual code review time
- Zero deployment failures in production
"@ `
    -AssignedTo "product-owner@company.com" `
    -Priority "Critical" `
    -IterationPath "Luna Foundry Release 1"
```

#### 2. Create Features Under Epic
```powershell
# Create Feature for AI Code Generation
$featureId = .\Scripts\New-WorkItemWithMarkdown.ps1 `
    -WorkItemType Feature `
    -Title "AI-Powered Code Generation" `
    -Description @"
## Feature: AI-Powered Code Generation
**ID**: Feature-LF-001
**Title**: AI-Powered Code Generation

### Business Context
Developers currently spend significant time writing boilerplate code and implementing common patterns.

### What This Feature Introduces
- Intelligent code completion based on project context
- Automated generation of unit tests
- Pattern recognition for best practices

### Business Requirements
- Support for C#, Python, and TypeScript
- Integration with existing IDE workflows
- Quality assurance through automated validation

### Technical Considerations
- Integration with GitHub Copilot API
- Context-aware code suggestions
- Performance optimization for large codebases

### Expected Deliverables
- Code generation service
- IDE integration plugins
- Quality validation pipeline

### Acceptance Criteria
- 50% reduction in boilerplate code
- Generated code passes all quality checks
- Seamless integration with development workflow
"@ `
    -ParentId $epicId `
    -AssignedTo "tech-lead@company.com" `
    -IterationPath "Luna Foundry Release 1"
```

#### 3. Create User Stories Under Feature
```powershell
# Create User Story for Code Generation
$storyId = .\Scripts\New-WorkItemWithMarkdown.ps1 `
    -WorkItemType UserStory `
    -Title "As a developer, I want AI-generated unit tests so that I can focus on business logic" `
    -Description @"
## User Story: As a developer, I want AI-generated unit tests so that I can focus on business logic

**Context**: Writing comprehensive unit tests is time-consuming and often repetitive.

**Acceptance Criteria**:
- Scenario: Generate unit tests for a class
  Given a C# class with public methods
  When I request test generation
  Then comprehensive unit tests are created
- Scenario: Test validation
  Given generated unit tests
  When tests are executed
  Then all tests pass with good coverage
"@ `
    -AcceptanceCriteria @"
- Scenario: Generate unit tests for a class
  Given a C# class with public methods
  When I request test generation
  Then comprehensive unit tests are created
- Scenario: Test validation
  Given generated unit tests
  When tests are executed
  Then all tests pass with good coverage
"@ `
    -ParentId $featureId `
    -AssignedTo "developer@company.com" `
    -IterationPath "Luna Foundry Release 1"
```

#### 4. Bulk Markdown Enforcement
```powershell
# Enforce Markdown formatting on entire release
.\Scripts\Set-Markdown-Fields.ps1 -IterationPath "Luna Foundry Release 1"
```

#### 5. Validation and Reporting
```powershell
# Validate all work items are properly formatted
python ..\..\src\azext_markdown_enforcer\validate_release_markdown.py
```

### Troubleshooting

#### Extension Not Found
```
❌ Azure CLI Markdown Enforcer extension not found!
```
**Solution:** Install the extension first:
```bash
az extension add --source markdown-enforcer-0.1.0.tar.gz
```

#### Permission Errors
```
Error: You do not have permissions to update work items
```
**Solution:** Ensure your Azure CLI is authenticated and you have appropriate permissions:
```bash
az login
az devops configure --defaults organization=https://dev.azure.com/your-org project=your-project
```

#### No Work Items Found
```
No work items found matching criteria
```
**Solution:** Verify your WIQL query or iteration path is correct:
```powershell
# Check available iterations
az boards iteration list --output table

# Test your WIQL query
az boards query --wiql "YOUR_QUERY_HERE" --output table
```

- **Epic Template**:
  ```
  ## Epic: [Title]
  **ID**: Epic-[Number]
  **Title**: [Title]
  **Description**: [High-level goal, business value.]
  **Priority**: [Critical/High/Medium/Low]
  **Assigned To**: [Team Lead]
  **State**: [New/Active/Resolved/Closed]
  **Discussion**: [Initial notes.]
  ```

- **Feature Template**:
  ```
  ## Feature: [Title]
  **ID**: Feature-[Number]
  **Title**: [Title]
  **Description**: [Detailed goal, deliverables.]
  **Priority**: [High/Medium/Low]
  **Assigned To**: [Owner]
  **State**: [Active]
  **Discussion**: [Input.]
  **Story Points**: [Estimate]
  ```

- **Requirement Template**:
  ```
  ### Requirement: [Title]
  **ID**: Req-[Number]
  **Title**: [Title]
  **Description**: [Specs, constraints.]
  **Acceptance Criteria**:
  - [Criteria 1]
  **Priority**: [High/Medium/Low]
  **Assigned To**: [Analyst]
  **State**: [Active]
  **Discussion**: [Clarifications.]
  **Story Points**: [Estimate]
  ```

- **User Story Template**:
  ```
  ### User Story: As a [user], I want [goal] so that [benefit].
  **ID**: US-[Number]
  **Title**: [Title]
  **Description**: [Context, dependencies.]
  **Acceptance Criteria**:
  - [Measurable criteria]
  **Priority**: [High/Medium/Low]
  **Assigned To**: [Developer]
  **State**: [Active]
  **Discussion**: [Questions.]
  **Story Points**: [Estimate]
  **Hours**: Original: [X], Remaining: [Y], Real: [Z]
  ```

- **Task Template**:
  ```
  - **Task-[Number]**: [Title]
    **Description**: [Steps.]
    **State**: [To Do/In Progress/Done]
    **Assigned To**: [Assignee]
    **Discussion**: [Notes.]
    **Hours**: Original: [X], Remaining: [Y], Real: [Z]
  ```

- **Test Case Template**:
  ```
  #### Test Case: [Title]
  **ID**: TC-[Number]
  **Title**: [Title]
  **Description**: [Steps, expected results.]
  **Priority**: [High/Medium/Low]
  **Assigned To**: [Tester]
  **State**: [Active]
  **Discussion**: [Edge cases.]
  ```

### Standards
- ID: Sequential.
- Titles: Descriptive.
- Descriptions: 100-300 words.
- AC: 3-5 SMART bullets.
- Priorities/States: Standard.
- Completeness: Require key fields.

### Best Practices
- Enforce hierarchy.
- Estimate accurately.
- Collaborate via Discussion.
- Link Test Cases.
- Review regularly.
- Track metrics.

## Epic-Writing Sub-Skill

### Overview
This sub-skill focuses on writing comprehensive Epic work items based on real-world examples from client projects. Epics serve as high-level containers for business objectives, grouping Features and Requirements. The approach is derived from analyzing Epics in Azure DevOps exports, ensuring verbose, testable content with clear acceptance criteria.

### Questions to Ask Clients
To gather necessary information for Epic creation:
- What is the overarching business objective for this Epic?
- What are the key objectives that must be achieved?
- What are the business requirements (functional and non-functional)?
- What are the technical requirements or considerations?
- What are the expected deliverables or outcomes?
- What are the acceptance criteria for considering the Epic complete?

### Time Breakdown
- 20% Discovery: Gather client requirements and objectives.
- 30% Planning: Structure the Epic content and outline sections.
- 30% Writing: Draft detailed descriptions, requirements, and criteria.
- 20% Review: Validate with stakeholders and refine.

### Content to Include
Each Epic should include the following sections in the Description field:
- **Business Objectives**: High-level goals and value propositions.
- **Key Objectives**: Specific, measurable outcomes.
- **Business Requirements**: Functional requirements from a business perspective.
- **Technical Requirements**: Technical constraints, integrations, or considerations.
- **Expected Deliverables**: Tangible outputs or milestones.
- **Acceptance Criteria**: Testable conditions for Epic completion, often 3-5 bullets.

### Documentation Approach
- Use Markdown for initial drafts to ensure structured formatting.
- Transfer to Azure DevOps work items using tools like `mcp_ecolabdevopss_wit_create_work_item`.
- Ensure descriptions are 200-500 words for depth, using active voice and clear rationale.

### Updated Epic Template
Based on real-world examples:
```
## Epic: [Title]
**ID**: Epic-[Number]
**Title**: [Descriptive Title Reflecting Business Objective]
**Description**:
### Business Objectives
[High-level goals, business value, and strategic alignment.]

### Key Objectives
- [Objective 1: Specific, measurable outcome]
- [Objective 2: ...]

### Business Requirements
- [Requirement 1: Functional or non-functional need]
- [Requirement 2: ...]

### Technical Requirements
- [Requirement 1: Technical constraint or integration]
- [Requirement 2: ...]

### Expected Deliverables
- [Deliverable 1: Tangible output or milestone]
- [Deliverable 2: ...]

### Acceptance Criteria
- [Criteria 1: Testable condition for completion]
- [Criteria 2: ...]
- [Criteria 3: ...]

**Priority**: [Critical/High/Medium/Low]
**Assigned To**: [Epic Owner or Team Lead]
**State**: [New/Active/Resolved/Closed]
**Discussion**: [Initial notes or questions.]
**Tags**: [Relevant tags for filtering]
```

### Integration with MacroFlow
- Use in the Specify phase to define Epic-level requirements.
- Link to Features and Requirements for hierarchical breakdown.
- Validate against client feedback in Clarify phase.

## Feature-Writing Sub-Skill

### Overview
This sub-skill focuses on writing comprehensive Feature work items based on real-world examples from client projects. Features represent specific capabilities or integrations within an Epic, detailing implementation approaches, testing scopes, and deliverables. The approach is derived from analyzing Features in Azure DevOps exports, ensuring verbose, testable content with clear acceptance criteria.

### Questions to Ask Clients
To gather necessary information for Feature creation:
- What is the business context for this Feature?
- What does this Feature introduce or change?
- What are the business requirements (functional and non-functional)?
- What are the technical considerations or integrations involved?
- What are the expected deliverables or outcomes?
- What are the acceptance criteria for considering the Feature complete?

### Time Breakdown
- 20% Discovery: Gather client requirements and context.
- 30% Planning: Structure the Feature content and outline sections.
- 30% Writing: Draft detailed descriptions, requirements, and criteria.
- 20% Review: Validate with stakeholders and refine.

### Content to Include
Each Feature should include the following sections in the Description field:
- **Business Context**: Background and rationale for the Feature.
- **What This Feature Introduces**: Key changes, additions, or integrations.
- **Business Requirements**: Functional requirements from a business perspective.
- **Technical Considerations**: Technical constraints, integrations, or dependencies.
- **Expected Deliverables**: Tangible outputs or milestones.
- **Acceptance Criteria**: Testable conditions for Feature completion, often 3-5 bullets.

### Documentation Approach
- Use Markdown for initial drafts to ensure structured formatting.
- Transfer to Azure DevOps work items using tools like `mcp_ecolabdevopss_wit_create_work_item`.
- Ensure descriptions are 300-600 words for depth, using active voice and clear rationale.

### Updated Feature Template
Based on real-world examples:
```
## Feature: [Title]
**ID**: Feature-[Number]
**Title**: [Descriptive Title Reflecting the Capability or Integration]
**Description**:
### Business Context
[Background, rationale, and strategic alignment for the Feature.]

### What This Feature Introduces
- [Key change or addition 1: Description of what is being introduced]
- [Key change or addition 2: ...]

### Business Requirements
- [Requirement 1: Functional or non-functional need]
- [Requirement 2: ...]

### Technical Considerations
- [Consideration 1: Technical constraint or integration]
- [Consideration 2: ...]

### Expected Deliverables
- [Deliverable 1: Tangible output or milestone]
- [Deliverable 2: ...]

### Acceptance Criteria
- [Criteria 1: Testable condition for completion]
- [Criteria 2: ...]
- [Criteria 3: ...]

**Priority**: [Critical/High/Medium/Low]
**Assigned To**: [Feature Owner or Lead Developer]
**State**: [New/Active/Resolved/Closed]
**Discussion**: [Initial notes or questions.]
**Tags**: [Relevant tags for filtering]
```

### Integration with MacroFlow
- Use in the Plan phase to decompose Epics into Features.
- Link to User Stories and Tasks for detailed implementation.
- Validate against Epic requirements in Specify phase.

## Requirement-Writing Sub-Skill

### Overview
This sub-skill focuses on writing comprehensive Requirement work items based on real-world examples from client projects. Requirements detail specific functional and technical needs within a Feature, often involving integrations, automations, and validations. The approach is derived from analyzing Requirements in Azure DevOps exports, ensuring verbose, testable content with structured sections like Business Objective, Business Requirements, Technical Considerations, and Expected Deliverables.

### Questions to Ask Clients
To gather necessary information for Requirement creation:
- What is the business objective for this Requirement?
- What are the key business requirements and functional details?
- What technical considerations need to be addressed (e.g., integrations, data mapping, error handling)?
- What deliverables are expected to fulfill this Requirement?
- What are the acceptance criteria for considering the Requirement complete?

### Time Breakdown
- 25% Discovery: Gather client requirements and objectives.
- 35% Planning: Structure the Requirement content and outline sections.
- 25% Writing: Draft detailed descriptions, requirements, and criteria.
- 15% Review: Validate with stakeholders and refine.

### Content to Include
Each Requirement should include the following sections in the Description field:
- **Business Objective**: High-level goal and purpose.
- **Business Requirements**: Detailed functional and non-functional requirements, often bulleted with specific conditions and expected outcomes.
- **Technical Considerations**: Cover integrations, data mapping, error handling, performance, and constraints.
- **Expected Deliverables**: Specify outputs like automated processes, documentation, or configurations.
- **Acceptance Criteria**: Testable conditions for Requirement completion, often 3-5 bullets.

### Documentation Approach
- Use Markdown for initial drafts to ensure structured formatting.
- Transfer to Azure DevOps work items using tools like `mcp_ecolabdevopss_wit_create_work_item`.
- Ensure descriptions are 400-800 words for depth, using active voice and clear rationale.

### Updated Requirement Template
Based on real-world examples:
```
## Requirement: [Title]
**ID**: Req-[Number]
**Title**: [Descriptive Title Reflecting the Specific Need or Integration]
**Description**:
### Business Objective
[High-level goal and purpose of the Requirement.]

### Business Requirements
- [Requirement 1: Detailed description with conditions and expected outcomes.]
- [Requirement 2: ...]

### Technical Considerations
- [Integration points, API consumption, data mapping.]
- [Error handling, retry mechanisms, and validation logic.]
- [Performance, security, or architectural constraints.]

### Expected Deliverables
- [Deliverable 1: e.g., Automated workflow or integration.]
- [Deliverable 2: e.g., Documentation and test cases.]

### Acceptance Criteria
- [Criteria 1: Testable condition for completion]
- [Criteria 2: ...]
- [Criteria 3: ...]

**Priority**: [Critical/High/Medium/Low]
**Assigned To**: [Requirement Owner or Analyst]
**State**: [New/Active/Resolved/Closed]
**Discussion**: [Initial notes or questions.]
**Tags**: [Relevant tags for filtering]
```

### Integration with MacroFlow
- Use in the Specify phase to detail Features into Requirements.
- Link to User Stories and Tasks for implementation.
- Validate against Feature context in Plan phase.

## User Story-Writing Sub-Skill

### Overview
This sub-skill focuses on writing comprehensive User Story work items based on real-world examples from client projects. User Stories describe behavioral requirements from the user's perspective, detailing interactions, outcomes, and acceptance criteria in Gherkin format. The approach is derived from analyzing User Stories in Azure DevOps exports, ensuring verbose, testable content with clear scenarios.

### Questions to Ask Clients
To gather necessary information for User Story creation:
- What is the user role or persona?
- What do they want to achieve?
- What is the benefit or value?
- What are the acceptance criteria (scenarios with Given/When/Then)?

### Time Breakdown
- 20% Discovery: Gather user needs and context.
- 40% Planning: Structure the story and outline scenarios.
- 30% Writing: Draft the story and detailed AC.
- 10% Review: Validate with stakeholders and refine.

### Content to Include
Each User Story should include the following sections in the Description field:
- **User Story**: "As a [user], I want [goal] so that [benefit]".
- **Acceptance Criteria**: Detailed scenarios in Gherkin format (Given/When/Then), often 3-5 bullets, covering happy path, edge cases, and error conditions.

### Documentation Approach
- Use Markdown for initial drafts to ensure structured formatting.
- Transfer to Azure DevOps work items using tools like `mcp_ecolabdevopss_wit_create_work_item`.
- Ensure descriptions are 200-500 words for depth, using active voice and clear rationale.

### Updated User Story Template
Based on real-world examples:
```
## User Story: As a [user role], I want [goal] so that [benefit].
**ID**: US-[Number]
**Title**: [Descriptive Title Reflecting the User Need]
**Description**:
[Context, dependencies, and rationale.]

**Acceptance Criteria**:
- Scenario: [Scenario Name]
  Given [initial context]
  When [action performed]
  Then [expected outcome]
- [Additional scenarios as needed]

**Priority**: [Critical/High/Medium/Low]
**Assigned To**: [Developer or Team]
**State**: [New/Active/Resolved/Closed]
**Discussion**: [Initial notes or questions.]
**Tags**: [Relevant tags for filtering]
```

### Integration with MacroFlow
- Use in the Tasks phase to break down Requirements into implementable stories.
- Link to Tasks for detailed steps.
- Validate against Requirement specifications in Specify phase.

## Task-Writing Sub-Skill

### Overview
This sub-skill focuses on writing comprehensive Task work items based on real-world examples from client projects. Tasks represent specific implementation steps within a User Story, detailing actions, deliverables, and validation. The approach is derived from analyzing Tasks in Azure DevOps exports, ensuring verbose, actionable content with clear steps.

### Questions to Ask Clients
To gather necessary information for Task creation:
- What is the specific task to accomplish?
- What are the steps or deliverables required?
- What are the acceptance criteria for task completion?

### Time Breakdown
- 20% Discovery: Gather task details and context.
- 40% Planning: Outline steps and deliverables.
- 30% Writing: Draft the task description and criteria.
- 10% Review: Validate with stakeholders and refine.

### Content to Include
Each Task should include the following sections in the Description field:
- **Task Description**: Specific action or deliverable.
- **Steps**: Detailed steps to complete the task.
- **Acceptance Criteria**: Testable conditions for task completion.

### Documentation Approach
- Use Markdown for initial drafts to ensure structured formatting.
- Transfer to Azure DevOps work items using tools like `mcp_ecolabdevopss_wit_create_work_item`.
- Ensure descriptions are 100-300 words for depth, using active voice and clear rationale.

### Updated Task Template
Based on real-world examples:
```
## Task: [Title]
**ID**: Task-[Number]
**Title**: [Descriptive Title Reflecting the Specific Action]
**Description**:
[Context and rationale for the task.]

**Steps**:
1. [Step 1: Detailed action.]
2. [Step 2: ...]

**Acceptance Criteria**:
- [Criteria 1: Testable condition for completion]
- [Criteria 2: ...]

**Priority**: [Critical/High/Medium/Low]
**Assigned To**: [Developer or Assignee]
**State**: [New/Active/Resolved/Closed]
**Discussion**: [Initial notes or questions.]
**Tags**: [Relevant tags for filtering]
```

### Integration with MacroFlow
- Use in the Implement phase to execute User Stories.
- Link to commits and builds for tracking.
- Validate against User Story scenarios in Tasks phase.

## Test Case-Writing Sub-Skill

### Overview
This sub-skill focuses on writing comprehensive Test Case work items based on real-world examples from client projects. Test Cases validate functionality, detailing steps, preconditions, and expected results. The approach is derived from analyzing Test Cases in Azure DevOps exports, ensuring testable, repeatable scenarios.

### Questions to Ask Clients
To gather necessary information for Test Case creation:
- What is the test scenario or functionality to validate?
- What are the preconditions and steps?
- What are the expected results or outcomes?

### Time Breakdown
- 20% Discovery: Gather test details and context.
- 40% Planning: Outline steps and expected results.
- 30% Writing: Draft the test case.
- 10% Review: Validate with stakeholders and refine.

### Content to Include
Each Test Case should include the following sections in the Description field:
- **Preconditions**: Setup required for the test.
- **Steps**: Detailed steps to execute the test.
- **Expected Results**: What should happen for the test to pass.

### Documentation Approach
- Use Markdown for initial drafts to ensure structured formatting.
- Transfer to Azure DevOps work items using tools like `mcp_ecolabdevopss_wit_create_work_item`.
- Ensure descriptions are 50-150 words for clarity, using clear, sequential steps.

### Updated Test Case Template
Based on real-world examples:
```
## Test Case: [Title]
**ID**: TC-[Number]
**Title**: [Descriptive Title Reflecting the Test Scenario]
**Description**:
[Context and rationale for the test.]

**Preconditions**:
- [Condition 1: Setup required.]
- [Condition 2: ...]

**Steps**:
1. [Step 1: Action to perform.]
2. [Step 2: ...]

**Expected Results**:
- [Result 1: Expected outcome.]
- [Result 2: ...]

**Priority**: [Critical/High/Medium/Low]
**Assigned To**: [Tester]
**State**: [New/Active/Resolved/Closed]
**Discussion**: [Initial notes or questions.]
**Tags**: [Relevant tags for filtering]
```

### Integration with MacroFlow
- Use in the Implement phase to validate Tasks and User Stories.
- Link to test runs and results.
- Validate against acceptance criteria in Tasks phase.