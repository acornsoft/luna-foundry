# Azure CLI Extension: Markdown Enforcer

This Azure CLI extension allows you to set the multiline format to Markdown on Azure DevOps work items, enabling Markdown support for multiline fields where supported.

## Prerequisites

- Python 3.8 or higher
- Azure CLI installed (`az` command available)
- Azure CLI logged in to Azure DevOps (`az devops login` or `az login`)
- Git (for cloning the repository)

## Installation

1. Clone the Luna Foundry repository:
   ```bash
   git clone https://github.com/acornsoft/luna-foundry.git
   cd luna-foundry/src/azext_markdown_enforcer
   ```

2. Build the extension wheel:
   ```bash
   python setup.py bdist_wheel
   ```

3. Install the extension:
   ```bash
   az extension add --source dist/multiline_format_setter-0.1.0-py3-none-any.whl
   ```

4. Verify installation:
   ```bash
   az boards work-item set-multiline-format --help
   ```

## Usage

### Set multiline format on child work items of a parent

```bash
az boards work-item set-multiline-format --parent <parent-id> --fields System.Description
```

### Set multiline format on specific work items

```bash
az boards work-item set-multiline-format --ids 123 456 --fields System.Description AcceptanceCriteria
```

### Dry run to see what would be changed

```bash
az boards work-item set-multiline-format --parent <parent-id> --dry-run
```

### Options

- `--wiql`: WIQL query to select work items
- `--ids`: Specific work item IDs
- `--work-item-types`: Filter by work item types
- `--parent-id`: Process child work items of this parent
- `--fields`: Fields to set multiline format on (default: System.Description)
- `--dry-run`: Show what would be changed without making changes
- `--org`: Azure DevOps organization URL (if not configured)
- `--project`: Azure DevOps project name (if not configured)

## Examples

Enforce Markdown on all work items under Epic 973 for Description and AcceptanceCriteria:

```bash
az boards work-item set-multiline-format --parent 973 --fields System.Description Microsoft.VSTS.Common.AcceptanceCriteria
```

## Troubleshooting

If you encounter loading errors, try removing and reinstalling the extension:

```bash
az extension remove --name multiline-format-setter
az extension add --source dist/multiline_format_setter-0.1.0-py3-none-any.whl
```

Ensure your Azure CLI is up to date: `az upgrade`