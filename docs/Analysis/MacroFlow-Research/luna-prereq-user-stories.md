# User Stories for Luna Foundry Pre-Requisites Tracking in Azure DevOps

## User Story 1: As a developer, I want automated pre-req checks in ADO so that setup is consistent across teams.
- **Description**: During Luna Constitution, validate tools/extensions/repos and log results in ADO for visibility.
- **Acceptance Criteria**: Checks run automatically; results stored in "Luna Pre-Req" work item; failures trigger alerts.
- **Tags**: #automation, #ado-integration, #constitution

## User Story 2: As a project manager, I want pre-req status reports in ADO so that I can track team readiness.
- **Description**: View dashboard of pre-req statuses for all team members in ADO.
- **Acceptance Criteria**: Dashboard shows pass/fail for each pre-req; updates in real-time via MCP.
- **Tags**: #reporting, #dashboard, #ado

## User Story 3: As a DevOps engineer, I want to customize pre-req lists in ADO so that they fit project needs.
- **Description**: Add/remove pre-reqs in ADO work item type for flexibility.
- **Acceptance Criteria**: Custom fields for pre-reqs; changes propagate to Luna agents.
- **Tags**: #customization, #flexibility, #ado