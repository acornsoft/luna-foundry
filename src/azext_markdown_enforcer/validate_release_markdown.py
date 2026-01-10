#!/usr/bin/env python3
"""
Validation script to check that all work items under Luna Foundry Release 1
are using Markdown format for multiline fields.

This script queries Azure DevOps for work items in the Luna Foundry Release 1
iteration and validates that System.Description and other multiline fields
are set to use Markdown format instead of HTML.
"""

import subprocess
import json
import sys
from typing import List, Dict, Optional

def run_az_command(command: List[str]) -> dict:
    """Run an Azure CLI command and return the JSON result."""
    try:
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            check=True
        )
        return json.loads(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error running Azure CLI command: {e}")
        print(f"Command: {' '.join(command)}")
        if e.stderr:
            print(f"Stderr: {e.stderr}")
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Error parsing JSON response: {e}")
        print(f"Raw output: {result.stdout}")
        sys.exit(1)

def get_work_items_for_release(release_name: str = "Luna Foundry Release 1") -> List[dict]:
    """Get all work items for the specified release."""
    print(f"Querying work items for release: {release_name}")

    # First, find the iteration path for the release
    iterations = run_az_command([
        "az", "boards", "iteration", "list",
        "--output", "json"
    ])

    target_iteration = None
    for iteration in iterations["value"]:
        if release_name in iteration["name"]:
            target_iteration = iteration
            break

    if not target_iteration:
        print(f"Error: Could not find iteration containing '{release_name}'")
        print("Available iterations:")
        for iteration in iterations["value"]:
            print(f"  - {iteration['name']}")
        sys.exit(1)

    iteration_path = target_iteration["path"]
    print(f"Found iteration: {iteration_path}")

    # Query work items in this iteration
    work_items = run_az_command([
        "az", "boards", "query",
        "--wiql", f"SELECT [System.Id], [System.Title], [System.WorkItemType] FROM WorkItems WHERE [System.IterationPath] UNDER '{iteration_path}'",
        "--output", "json"
    ])

    return work_items

def check_work_item_format(work_item_id: int) -> Dict[str, any]:
    """Check the multilineFieldsFormat for a specific work item."""
    try:
        work_item = run_az_command([
            "az", "boards", "work-item", "show",
            "--id", str(work_item_id),
            "--output", "json"
        ])

        fields_format = work_item.get("multilineFieldsFormat", {})

        # Check key fields that should be Markdown
        critical_fields = ["System.Description", "Microsoft.VSTS.TCM.ReproSteps"]
        issues = []

        for field in critical_fields:
            current_format = fields_format.get(field, "html")  # Default is HTML
            if current_format != "markdown":
                issues.append({
                    "field": field,
                    "current_format": current_format,
                    "expected_format": "markdown"
                })

        return {
            "work_item_id": work_item_id,
            "title": work_item.get("fields", {}).get("System.Title", "Unknown"),
            "work_item_type": work_item.get("fields", {}).get("System.WorkItemType", "Unknown"),
            "multilineFieldsFormat": fields_format,
            "issues": issues,
            "compliant": len(issues) == 0
        }

    except Exception as e:
        return {
            "work_item_id": work_item_id,
            "error": str(e),
            "compliant": False
        }

def main():
    """Main validation function."""
    print("🔍 Luna Foundry Release 1 - Markdown Format Validation")
    print("=" * 60)

    # Get work items for the release
    work_items = get_work_items_for_release()

    if not work_items:
        print("No work items found for Luna Foundry Release 1")
        return

    print(f"Found {len(work_items)} work items to check")
    print()

    # Check each work item
    results = []
    for wi in work_items:
        work_item_id = wi["id"]
        print(f"Checking work item {work_item_id}...")
        result = check_work_item_format(work_item_id)
        results.append(result)

    # Report results
    print("\n📊 Validation Results")
    print("=" * 60)

    compliant_count = 0
    total_count = len(results)

    for result in results:
        if "error" in result:
            print(f"❌ Work Item {result['work_item_id']}: ERROR - {result['error']}")
            continue

        if result["compliant"]:
            print(f"✅ Work Item {result['work_item_id']} ({result['work_item_type']}): {result['title'][:50]}...")
            compliant_count += 1
        else:
            print(f"❌ Work Item {result['work_item_id']} ({result['work_item_type']}): {result['title'][:50]}...")
            for issue in result["issues"]:
                print(f"   - Field '{issue['field']}' is '{issue['current_format']}' (should be 'markdown')")

    print(f"\n📈 Summary: {compliant_count}/{total_count} work items are compliant")

    if compliant_count == total_count:
        print("🎉 All work items are using Markdown format!")
        sys.exit(0)
    else:
        print("⚠️  Some work items need to be updated to use Markdown format.")
        print("   Run the following command to fix them:")
        print("   az boards work-item markdown-enforce enforce --wiql \"SELECT [System.Id] FROM WorkItems WHERE [System.IterationPath] UNDER 'Luna Foundry Release 1'\"")
        sys.exit(1)

if __name__ == "__main__":
    main()