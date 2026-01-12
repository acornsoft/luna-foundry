"""
API client for Azure DevOps work item operations.
"""

import logging
import subprocess
import json
import requests
from typing import List, Dict, Optional, Any

logger = logging.getLogger(__name__)

class MultilineFormatSetterAPI:
    """API client for setting multiline format to Markdown on Azure DevOps work items."""

    def __init__(self, org: Optional[str] = None, project: Optional[str] = None):
        """Initialize the API client."""
        self.org = org
        self.project = project
        self._token = None
        self._base_url = None

        # Get Azure CLI configuration
        self._load_az_config()

    def _load_az_config(self):
        """Load configuration from Azure CLI."""
        try:
            # Get default organization and project if not provided
            if not self.org:
                result = subprocess.run(
                    ['az', 'devops', 'configure', '--list'],
                    capture_output=True,
                    text=True,
                    check=True
                )
                # Parse the output to get org URL
                for line in result.stdout.split('\n'):
                    if 'organization' in line.lower():
                        self.org = line.split('=')[1].strip()
                        break

            if not self.project:
                result = subprocess.run(
                    ['az', 'devops', 'configure', '--list'],
                    capture_output=True,
                    text=True,
                    check=True
                )
                for line in result.stdout.split('\n'):
                    if 'project' in line.lower():
                        self.project = line.split('=')[1].strip()
                        break

            # Get access token
            result = subprocess.run(
                ['az', 'account', 'get-access-token', '--resource', '499b84ac-1321-427f-aa17-267ca6975798'],
                capture_output=True,
                text=True,
                check=True
            )
            token_data = json.loads(result.stdout)
            self._token = token_data['accessToken']

            # Build base URL
            if self.org and self.project:
                self._base_url = f"https://dev.azure.com/{self.org}/{self.project}/_apis"

        except subprocess.CalledProcessError as e:
            raise ValueError(f"Failed to load Azure CLI configuration: {e}")

    def _make_request(self, method: str, url: str, data: Optional[Dict] = None) -> Dict:
        """Make an authenticated request to Azure DevOps API."""
        headers = {
            'Authorization': f'Bearer {self._token}',
            'Content-Type': 'application/json-patch+json'
        }

        response = requests.request(method, url, headers=headers, json=data)
        response.raise_for_status()
        return response.json()

    def get_work_item_ids(
        self,
        wiql: Optional[str] = None,
        ids: Optional[List[int]] = None,
        work_item_types: Optional[List[str]] = None,
        parent_id: Optional[int] = None
    ) -> List[int]:
        """Get work item IDs based on various criteria."""
        if ids:
            return ids

        if wiql:
            # Execute WIQL query
            url = f"{self._base_url}/wit/wiql"
            data = {"query": wiql}
            result = self._make_request('POST', url, data)
            return [item['id'] for item in result.get('workItems', [])]

        if parent_id:
            # Get child work items
            url = f"{self._base_url}/wit/workitems/{parent_id}"
            params = {"$expand": "relations"}
            result = self._make_request('GET', url)
            child_ids = []
            for relation in result.get('relations', []):
                if relation['rel'] == 'System.LinkTypes.Hierarchy-Forward':
                    # Extract ID from URL
                    url_parts = relation['url'].split('/')
                    child_ids.append(int(url_parts[-1]))
            return child_ids

        # Build WIQL query from work item types
        if work_item_types:
            type_filter = " OR ".join([f"[System.WorkItemType] = '{wt}'" for wt in work_item_types])
            wiql = f"SELECT [System.Id] FROM WorkItems WHERE {type_filter}"
            return self.get_work_item_ids(wiql=wiql)

        return []

    def set_multiline_format_to_markdown(
        self,
        work_item_ids: List[int],
        fields: List[str],
        dry_run: bool = False
    ) -> List[Dict[str, Any]]:
        """Set multiline format to Markdown on specified fields of work items."""
        results = []

        for work_item_id in work_item_ids:
            try:
                # Get current work item
                url = f"{self._base_url}/wit/workitems/{work_item_id}"
                work_item = self._make_request('GET', url)

                # Check current format
                current_format = work_item.get('multilineFieldsFormat', {})

                # Prepare updates
                updates = []
                needs_update = False

                for field in fields:
                    if field not in current_format or current_format[field] != 'markdown':
                        updates.append({
                            "op": "add",
                            "path": f"/multilineFieldsFormat/{field}",
                            "value": "markdown"
                        })
                        needs_update = True

                if needs_update:
                    if dry_run:
                        logger.info(f"DRY RUN: Would update work item {work_item_id} fields: {fields}")
                        results.append({
                            'work_item_id': work_item_id,
                            'success': True,
                            'dry_run': True,
                            'fields': fields
                        })
                    else:
                        # Update work item
                        update_url = f"{self._base_url}/wit/workitems/{work_item_id}"
                        self._make_request('PATCH', update_url, updates)
                        logger.info(f"Updated work item {work_item_id} to use Markdown format for fields: {fields}")
                        results.append({
                            'work_item_id': work_item_id,
                            'success': True,
                            'fields': fields
                        })
                else:
                    logger.info(f"Work item {work_item_id} already has Markdown format for specified fields")
                    results.append({
                        'work_item_id': work_item_id,
                        'success': True,
                        'already_markdown': True
                    })

            except Exception as e:
                logger.error(f"Failed to update work item {work_item_id}: {str(e)}")
                results.append({
                    'work_item_id': work_item_id,
                    'success': False,
                    'error': str(e)
                })

        return results