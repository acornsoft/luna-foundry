#!/usr/bin/env python3
"""
Convenience script to enforce Markdown format on all work items
in Luna Foundry Release 1.

This script uses the Azure CLI Markdown Enforcer extension to
automatically update all work items in the release to use Markdown
format for multiline fields.
"""

import subprocess
import sys

def run_command(command: list, description: str):
    """Run a command and handle errors."""
    print(f"🔧 {description}")
    try:
        result = subprocess.run(command, check=True)
        print("✅ Success")
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ Failed: {e}")
        return False

def main():
    """Main enforcement function."""
    print("🚀 Luna Foundry Release 1 - Markdown Enforcement")
    print("=" * 60)

    # First validate current state
    print("Step 1: Checking current compliance...")
    result = subprocess.run([
        sys.executable, "validate_release_markdown.py"
    ], cwd=".")

    if result.returncode == 0:
        print("🎉 All work items are already compliant!")
        return

    print("\nStep 2: Enforcing Markdown format...")

    # Build the WIQL query for Luna Foundry Release 1
    wiql_query = "SELECT [System.Id] FROM WorkItems WHERE [System.IterationPath] UNDER 'Luna Foundry Release 1'"

    # Run the enforcement
    success = run_command([
        "az", "boards", "work-item", "markdown-enforce", "enforce",
        "--wiql", wiql_query,
        "--fields", "System.Description", "Microsoft.VSTS.TCM.ReproSteps"
    ], "Enforcing Markdown format on all work items in Luna Foundry Release 1")

    if success:
        print("\nStep 3: Validating results...")
        run_command([
            sys.executable, "validate_release_markdown.py"
        ], "Re-validating compliance after enforcement")

        print("\n🎉 Markdown enforcement complete!")
        print("All work items in Luna Foundry Release 1 should now use Markdown format.")
    else:
        print("\n❌ Enforcement failed. Please check the error messages above.")
        sys.exit(1)

if __name__ == "__main__":
    main()