# Work Item Cloning Specifications

## Overview
This document specifies the requirements for improving Feature, Requirement, and User Story cloning from external Azure DevOps instances, with a focus on ensuring Feature cloning works reliably.

## Functional Requirements
- **FR1: Clone Work Items**: Support cloning Feature, Requirement, and User Story types from source instance (e.g., ecolabDevOpsServer) to target (e.g., acornsoftDevOpsServer), preserving all shared fields (System.Title, System.Description, System.AssignedTo, System.AreaPath, System.IterationPath, Microsoft.VSTS.Common.Priority, System.Tags) and type-specific fields (e.g., Microsoft.VSTS.Scheduling.Effort for Features).
- **FR2: Content Refinement**: Convert HTML descriptions to Markdown, ensure clean separation of narrative content from field metadata (no embedded Priority/AssignedTo in descriptions).
- **FR3: Format Enforcement**: Set multiline fields (System.Description, System.History, Microsoft.VSTS.Common.AcceptanceCriteria, etc.) to Markdown format during creation via MCP fields array.
- **FR4: Linking**: Attempt parent-child linking (e.g., Feature to Epic); if automated fails (due to permissions/hierarchy), provide manual guidance.
- **FR5: Comments and Tracking**: Add Luna comment noting cloning source, refinements, and format settings; update internal knowledge for future refinements.

## Non-Functional Requirements
- **NFR1: Reliability**: Handle auth issues gracefully (e.g., null returns); retry mechanisms for MCP calls.
- **NFR2: Performance**: Clone process completes within 5 minutes per work item.
- **NFR3: Usability**: Templates separate content from fields; error messages guide manual fixes.
- **NFR4: Security**: Use PAT for ADO access; no secrets exfiltration.
- **NFR5: Compatibility**: Works with ADO MCP servers; supports multi-instance forensics.

## Constraints
- Grok-native stack only.
- C# primacy for any code gen.
- Vertical slice architecture.
- Markdown-first for docs.

## JSON Schema for Work Item Clone Spec
```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "sourceInstance": {
      "type": "string",
      "description": "Source ADO instance (e.g., ecolabDevOpsServer)"
    },
    "targetInstance": {
      "type": "string",
      "description": "Target ADO instance (e.g., acornsoftDevOpsServer)"
    },
    "workItemType": {
      "enum": ["Feature", "Requirement", "User Story"],
      "description": "Type of work item to clone"
    },
    "sourceId": {
      "type": "integer",
      "description": "ID of source work item"
    },
    "fields": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "name": {
            "type": "string",
            "description": "Field name (e.g., System.Title)"
          },
          "value": {
            "type": "string",
            "description": "Field value"
          },
          "format": {
            "enum": ["Html", "Markdown"],
            "description": "Format for multiline fields"
          }
        },
        "required": ["name", "value"]
      },
      "description": "List of fields to set"
    },
    "parentId": {
      "type": "integer",
      "description": "Optional parent work item ID for linking"
    }
  },
  "required": ["sourceInstance", "targetInstance", "workItemType", "sourceId", "fields"]
}
```

## ADR-Style Trade-Offs
- **ADR: Automation vs. Manual**: Full automation preferred, but manual linking accepted for hierarchy restrictions (trade-off: speed vs. reliability).
- **ADR: Format Enforcement**: Set on creation vs. post-process (chose creation for immediacy, but requires MCP support).
- **ADR: Scope**: Focus on Feature first (trade-off: breadth vs. depth for validation).