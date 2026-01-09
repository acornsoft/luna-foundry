# Sync Schemas for App Collaboration

## Overview
These schemas define JSON structures for shared state in Luna Foundry, enabling cross-app synchronization between Grok Desktop, VS Code, and other modalities. Schemas ensure consistent data flow in the MacroFlow network.

## Session Schema
```json
{
  "sessionId": "string",
  "phases": ["Constitution", "Clarify", ...],
  "context": {
    "user": "Blaze",
    "project": "Luna Foundry",
    "grokMode": "Think"
  },
  "currentNode": "string",
  "flowData": {}
}
```

## Phase Output Schema
```json
{
  "phase": "string",
  "output": {},
  "timestamp": "ISO string",
  "validation": "boolean"
}
```

## Artifact Link Schema
```json
{
  "type": "GitHub",
  "repo": "acornsoft/luna-foundry",
  "branch": "main",
  "commit": "string",
  "workItemId": "number"
}
```

Use these for reliable app sync.