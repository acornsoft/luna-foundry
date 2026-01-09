# Work Items for Luna Foundry Cleanup

## Feature: Cleanup Luna Foundry Redundancies
**ID**: Feature-001  
**Title**: Streamline .github Folder and Prioritize Skills  
**Description**: Remove redundancies in .github, migrate content to skills, neutralize references, and ensure skills-driven extensibility for Luna Foundry initial release.  
**Priority**: High  
**Assigned To**: David Blaszyk  
**State**: Active  

### User Story: As a developer, I want to clean up redundancies in .github so that the structure is streamlined and skills are prioritized.
**ID**: US-001  
**Title**: Clean Up Redundancies in .github Folder  
**Description**: Audit and remove redundant files, update core instructions, migrate to skills, apply neutrality, test, and commit.  
**Acceptance Criteria**:  
- Redundancies audited (phase instructions duplicating MacroFlow).  
- luna.instructions.md updated with Skills Integration, version v1.7, date Jan 8, 2026.  
- Content migrated from instructions to skills (constitution, clarify, specify, plan, tasks, implement).  
- Neutrality applied (Acornsoft references removed, generics used).  
- Integration tested (MacroFlow runs with skills).  
- Redundant files removed/archived.  
- Versioned and committed with build tag 1.0.26008.1.  

#### Tasks:
- **Task-001**: Audit Redundancies  
  **Description**: Review .github/instructions/, prompts/, agents/ for overlaps with luna.instructions.md and skills.  
  **State**: Completed  

- **Task-002**: Update Core File  
  **Description**: Edit luna.instructions.md to add Skills Integration, update version/date.  
  **State**: Completed  

- **Task-003**: Migrate Content  
  **Description**: Move details from phase instructions to respective skills.  
  **State**: Completed  

- **Task-004**: Apply Neutrality  
  **Description**: Remove company-specific references, use generics.  
  **State**: Completed  

- **Task-005**: Test Integration  
  **Description**: Run MacroFlow phases to ensure skills work.  
  **State**: Pending  

- **Task-006**: Remove/Archive Redundants  
  **Description**: Delete redundant .instructions.md files.  
  **State**: Pending  

- **Task-007**: Version & Commit  
  **Description**: Tag with build number, commit changes.  
  **State**: Pending