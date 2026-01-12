#!/usr/bin/env python3

"""
Script to set multiline format to Markdown for work items under a parent Epic.
"""

import argparse
import logging
import sys
import os

# Add the azext_markdown_enforcer package to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'azext_markdown_enforcer'))

from azext_markdown_enforcer.api import MultilineFormatSetterAPI

def main():
    parser = argparse.ArgumentParser(description='Set multiline format to Markdown for work items under a parent.')
    parser.add_argument('--parent', type=int, required=True, help='Parent work item ID (e.g., Epic ID)')
    parser.add_argument('--org', default='acornsoft365', help='Azure DevOps organization URL')
    parser.add_argument('--project', default='d35e9f8b-904f-4c8f-8f84-45f91733586c', help='Azure DevOps project name')
    parser.add_argument('--fields', nargs='*', default=['System.Description'], help='Fields to set multiline format on')
    parser.add_argument('--dry-run', action='store_true', help='Show what would be changed without making changes')

    args = parser.parse_args()

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    try:
        api = MultilineFormatSetterAPI(org=args.org, project=args.project)

        # Get work item IDs
        work_item_ids = api.get_work_item_ids(parent_id=args.parent)
        if not work_item_ids:
            logger.warning(f"No work items found under parent {args.parent}.")
            return

        logger.info(f"Found {len(work_item_ids)} work items under parent {args.parent}.")

        # Update multiline format
        results = api.set_multiline_format_to_markdown(
            work_item_ids=work_item_ids,
            fields=args.fields,
            dry_run=args.dry_run
        )

        # Report results
        successful = sum(1 for r in results if r.get('success'))
        failed = len(results) - successful

        logger.info(f"Processing complete. Successful: {successful}, Failed: {failed}")

        if failed > 0:
            logger.warning("Some work items failed to update. Check logs for details.")
            sys.exit(1)

    except Exception as e:
        logger.error(f"Error: {str(e)}")
        sys.exit(1)

if __name__ == '__main__':
    main()