# Specify

Structured spec:
Functional: MCP accepts JSON input (e.g., { "phase": "Specify", "context": "Inventory Sync Sherpa" }), runs MacroFlow phase(s), generates prompts/code. POC: Endpoint that chains phases to output 5 sample prompts (e.g., luna-system, codegen-class, domain-crm).
Non-Functional: Serverless (scale to zero), <500ms latency per phase, observable via App Insights, audit via blockchain trail (e.g., Ethereum sidechain). Security: API keys for Grok calls.
JSON Schema snippet for input:

```json
{
  "type": "object",
  /* Lines 15-20 omitted */
  "required": ["phase", "context"]
}
```

Client-specific D365 spec: Modify current account definitions for division-specific accounts, unify under base customer account. Requires changes to custom account definition. Understand ramifications: forms impacts, current limitations, permission models, D365 architecture.
