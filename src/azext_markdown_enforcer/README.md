# Azure CLI Markdown Enforcer Extension

A Python Azure CLI extension that enforces Markdown format on Azure DevOps work items by updating the `multilineFieldsFormat` property.

## Installation

### From Source

1. Clone the repository
2. Navigate to the extension directory:
   ```bash
   cd src/azext_markdown_enforcer
   ```
3. Install the extension:
   ```bash
   az extension add --source .
   ```

### From Wheel

```bash
pip install azext_markdown_enforcer-0.1.0-py3-none-any.whl
az extension add --name markdown-enforcer
```

## Usage

### Basic Usage

Enforce Markdown format on work items by ID:
```bash
az boards work-item markdown-enforce enforce --ids 123 456 789
```

### Using WIQL Query

Enforce Markdown format on work items matching a WIQL query:
```bash
az boards work-item markdown-enforce enforce --wiql "SELECT [System.Id] FROM WorkItems WHERE [System.WorkItemType] = 'Task'"
```

### Filter by Work Item Types

Enforce Markdown format on specific work item types:
```bash
az boards work-item markdown-enforce enforce --work-item-types Task Bug
```

### Process Child Work Items

Enforce Markdown format on child work items of a parent:
```bash
az boards work-item markdown-enforce enforce --parent-id 123
```

### Specify Fields

By default, only `System.Description` is updated. Specify additional fields:
```bash
az boards work-item markdown-enforce enforce --ids 123 --fields System.Description Microsoft.VSTS.TCM.ReproSteps
```

### Dry Run

Preview changes without making them:
```bash
az boards work-item markdown-enforce enforce --ids 123 --dry-run
```

### Override Organization/Project

Specify different org/project than the default:
```bash
az boards work-item markdown-enforce enforce --ids 123 --org myorg --project myproject
```

## Authentication

The extension uses the same authentication as the Azure CLI. Ensure you are logged in:

```bash
az login
az devops configure --defaults organization=https://dev.azure.com/myorg project=myproject
```

## Examples

### Enforce Markdown on all Tasks in a project
```bash
az boards work-item markdown-enforce enforce --work-item-types Task
```

### Update multiple fields with dry run
```bash
az boards work-item markdown-enforce enforce --wiql "SELECT [System.Id] FROM WorkItems WHERE [System.State] = 'New'" --fields System.Description Microsoft.VSTS.TCM.ReproSteps --dry-run
```

## Development

### Setup Development Environment

1. Install dependencies:
   ```bash
   pip install -r requirements-dev.txt
   ```

2. Run tests:
   ```bash
   python -m pytest
   ```

### Building the Extension

```bash
python setup.py bdist_wheel
```

## Contributing

Please read the contributing guidelines and submit pull requests to the main repository.

## License

MIT License