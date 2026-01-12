"""
Commands for the markdown-enforcer extension.
"""

import logging
from .api import MultilineFormatSetterAPI

def load_command_table(command_table, **kwargs):
    """Load commands into the command table."""
    with command_table.command_group('boards.workitem') as g:
        g.command('set-multiline-format', 'set_multiline_format_to_markdown')

def load_arguments(command_table, **kwargs):
    """Load arguments for commands."""
    with command_table.argument_group('boards.workitem set-multiline-format') as g:
        g.argument('--wiql', help='WIQL query to select work items')
        g.argument('--ids', nargs='*', type=int, help='Specific work item IDs to process')
        g.argument('--work-item-types', nargs='*', help='Filter by work item types')
        g.argument('--parent-id', type=int, help='Process child work items of this parent')
        g.argument('--fields', nargs='*', help='Fields to set multiline format on (default: System.Description)')
        g.argument('--dry-run', action='store_true', help='Show what would be changed without making changes')
        g.argument('--org', help='Azure DevOps organization URL')
        g.argument('--project', help='Azure DevOps project name')

def set_multiline_format_to_markdown(
    wiql=None,
    ids=None,
    work_item_types=None,
    parent_id=None,
    fields=None,
    dry_run=False,
    org=None,
    project=None
):
    """
    Set multiline format to Markdown on Azure DevOps work items.

    This command updates the multilineFieldsFormat for specified work items
    to "markdown", enabling Markdown support for multiline fields where supported,
    opposed to HTML.
    """
    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    try:
        api = MultilineFormatSetterAPI(org=org, project=project)

        # Get work item IDs to process
        work_item_ids = api.get_work_item_ids(
            wiql=wiql,
            ids=ids,
            work_item_types=work_item_types,
            parent_id=parent_id
        )

        if not work_item_ids:
            logger.warning("No work items found matching the criteria.")
            return

        logger.info(f"Found {len(work_item_ids)} work items to process.")

        # Default fields if none specified
        if not fields:
            fields = ['System.Description']

        # Process work items
        results = api.set_multiline_format_to_markdown(
            work_item_ids=work_item_ids,
            fields=fields,
            dry_run=dry_run
        )

        # Report results
        successful = sum(1 for r in results if r['success'])
        failed = len(results) - successful

        logger.info(f"Processing complete. Successful: {successful}, Failed: {failed}")

        if failed > 0:
            logger.warning("Some work items failed to update. Check logs for details.")

    except Exception as e:
        logger.error(f"Error setting multiline format to Markdown: {str(e)}")
        raise