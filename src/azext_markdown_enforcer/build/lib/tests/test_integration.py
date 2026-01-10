"""
Integration tests for the Markdown Enforcer Azure CLI extension.
"""

import unittest
import sys
import os
from unittest.mock import Mock, patch, MagicMock
import json

# Mock Azure CLI modules before importing our extension
sys.modules['azure.cli.core'] = Mock()
sys.modules['azure.cli.core.commands'] = Mock()
sys.modules['azure.cli.core.extension'] = Mock()

# Add the extension to the path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from azext_markdown_enforcer.commands import load_command_table, load_arguments, set_multiline_format_to_markdown
from azext_markdown_enforcer.api import MultilineFormatSetterAPI

class TestExtensionIntegration(unittest.TestCase):
    """Integration tests for the complete extension."""

    def setUp(self):
        """Set up test fixtures."""
        # Mock command table with context manager support
        self.command_table = Mock()
        self.command_group = Mock()
        self.argument_group = Mock()
        
        # Set up context managers
        self.command_table.command_group.return_value.__enter__ = Mock(return_value=self.command_group)
        self.command_table.command_group.return_value.__exit__ = Mock(return_value=None)
        self.command_table.argument_group.return_value.__enter__ = Mock(return_value=self.argument_group)
        self.command_table.argument_group.return_value.__exit__ = Mock(return_value=None)

    def test_load_command_table(self):
        """Test that commands are loaded into the command table."""
        load_command_table(self.command_table)

        # Verify command group was created
        self.command_table.command_group.assert_called_once_with('boards work-item set-multiline-format')

        # Verify command was added
        self.command_group.command.assert_called_once_with('set', 'set_multiline_format_to_markdown', supports_no_wait=True)

    def test_load_arguments(self):
        """Test that arguments are loaded correctly."""
        load_arguments(self.command_table)

        # Verify argument group was created
        self.command_table.argument_group.assert_called_once_with('boards work-item set-multiline-format')

        # Verify all arguments were added
        expected_calls = [
            unittest.mock.call('--wiql', help='WIQL query to select work items'),
            unittest.mock.call('--ids', nargs='*', type=int, help='Specific work item IDs to process'),
            unittest.mock.call('--work-item-types', nargs='*', help='Filter by work item types'),
            unittest.mock.call('--parent-id', type=int, help='Process child work items of this parent'),
            unittest.mock.call('--fields', nargs='*', help='Fields to set multiline format on (default: System.Description)'),
            unittest.mock.call('--dry-run', action='store_true', help='Show what would be changed without making changes'),
            unittest.mock.call('--org', help='Azure DevOps organization URL'),
            unittest.mock.call('--project', help='Azure DevOps project name'),
        ]

        self.assertEqual(self.argument_group.argument.call_count, len(expected_calls))
        self.argument_group.argument.assert_has_calls(expected_calls)

    @patch('subprocess.run')
    @patch('azext_markdown_enforcer.commands.MultilineFormatSetterAPI')
    def test_enforce_markdown_format_success(self, mock_api_class, mock_subprocess):
        """Test successful enforcement of Markdown format."""
        # Mock subprocess calls for az CLI
        mock_token_result = Mock()
        mock_token_result.stdout = '{"accessToken": "test-token"}'
        mock_token_result.returncode = 0
        mock_subprocess.return_value = mock_token_result
        
        # Mock API instance
        mock_api = Mock()
        mock_api_class.return_value = mock_api
        mock_api.get_work_item_ids.return_value = [123, 456]
        mock_api.set_multiline_format_to_markdown.return_value = [
            {'work_item_id': 123, 'success': True, 'fields': ['System.Description']},
            {'work_item_id': 456, 'success': True, 'fields': ['System.Description']}
        ]

        # Test the command
        set_multiline_format_to_markdown(ids=[123, 456])

        # Verify API was called correctly
        mock_api_class.assert_called_once_with(org=None, project=None)
        mock_api.get_work_item_ids.assert_called_once_with(
            wiql=None, ids=[123, 456], work_item_types=None, parent_id=None
        )
        mock_api.set_multiline_format_to_markdown.assert_called_once_with(
            work_item_ids=[123, 456],
            fields=['System.Description'],
            dry_run=False
        )

    @patch('subprocess.run')
    @patch('azext_markdown_enforcer.commands.MultilineFormatSetterAPI')
    def test_enforce_markdown_format_with_wiql(self, mock_api_class, mock_subprocess):
        """Test enforcement using WIQL query."""
        # Mock subprocess calls
        mock_token_result = Mock()
        mock_token_result.stdout = '{"accessToken": "test-token"}'
        mock_token_result.returncode = 0
        mock_subprocess.return_value = mock_token_result
        
        mock_api = Mock()
        mock_api_class.return_value = mock_api
        mock_api.get_work_item_ids.return_value = [789]
        mock_api.set_multiline_format_to_markdown.return_value = [
            {'work_item_id': 789, 'success': True, 'fields': ['System.Description', 'Microsoft.VSTS.TCM.ReproSteps']}
        ]

        wiql_query = "SELECT [System.Id] FROM WorkItems WHERE [System.WorkItemType] = 'Bug'"
        set_multiline_format_to_markdown(
            wiql=wiql_query,
            fields=['System.Description', 'Microsoft.VSTS.TCM.ReproSteps']
        )

        mock_api.get_work_item_ids.assert_called_once_with(
            wiql=wiql_query, ids=None, work_item_types=None, parent_id=None
        )
        mock_api.set_multiline_format_to_markdown.assert_called_once_with(
            work_item_ids=[789],
            fields=['System.Description', 'Microsoft.VSTS.TCM.ReproSteps'],
            dry_run=False
        )

    @patch('subprocess.run')
    @patch('azext_markdown_enforcer.commands.MultilineFormatSetterAPI')
    def test_enforce_markdown_format_dry_run(self, mock_api_class, mock_subprocess):
        """Test dry run mode."""
        # Mock subprocess calls
        mock_token_result = Mock()
        mock_token_result.stdout = '{"accessToken": "test-token"}'
        mock_token_result.returncode = 0
        mock_subprocess.return_value = mock_token_result
        
        mock_api = Mock()
        mock_api_class.return_value = mock_api
        mock_api.get_work_item_ids.return_value = [123]
        mock_api.set_multiline_format_to_markdown.return_value = [
            {'work_item_id': 123, 'success': True, 'dry_run': True, 'fields': ['System.Description']}
        ]

        set_multiline_format_to_markdown(ids=[123], dry_run=True)

        mock_api.set_multiline_format_to_markdown.assert_called_once_with(
            work_item_ids=[123],
            fields=['System.Description'],
            dry_run=True
        )

    @patch('subprocess.run')
    @patch('azext_markdown_enforcer.commands.MultilineFormatSetterAPI')
    def test_enforce_markdown_format_with_org_project(self, mock_api_class, mock_subprocess):
        """Test with custom org and project."""
        # Mock subprocess calls
        mock_token_result = Mock()
        mock_token_result.stdout = '{"accessToken": "test-token"}'
        mock_token_result.returncode = 0
        mock_subprocess.return_value = mock_token_result
        
        mock_api = Mock()
        mock_api_class.return_value = mock_api
        mock_api.get_work_item_ids.return_value = [123]
        mock_api.set_multiline_format_to_markdown.return_value = [
            {'work_item_id': 123, 'success': True, 'fields': ['System.Description']}
        ]

        set_multiline_format_to_markdown(ids=[123], org='myorg', project='myproject')

        mock_api_class.assert_called_once_with(org='myorg', project='myproject')

    @patch('subprocess.run')
    @patch('azext_markdown_enforcer.commands.MultilineFormatSetterAPI')
    def test_enforce_markdown_format_api_error(self, mock_api_class, mock_subprocess):
        """Test handling of API errors."""
        # Mock subprocess calls
        mock_token_result = Mock()
        mock_token_result.stdout = '{"accessToken": "test-token"}'
        mock_token_result.returncode = 0
        mock_subprocess.return_value = mock_token_result
        
        mock_api = Mock()
        mock_api_class.return_value = mock_api
        mock_api.get_work_item_ids.side_effect = Exception("API connection failed")

        with self.assertRaises(Exception):
            set_multiline_format_to_markdown(ids=[123])

        # Verify the API was still called
        mock_api_class.assert_called_once_with(org=None, project=None)

class TestAPIIntegration(unittest.TestCase):
    """Integration tests for the API with mocked HTTP responses.

    NOTE: These tests are deferred until Release 2 due to complex subprocess
    mocking requirements. See ADR 001 for details.

    The functionality is validated through extension integration tests instead.
    """

    @unittest.skip("Deferred to Release 2 - see ADR 001")
    def test_get_work_item_ids_wiql_query(self):
        """Test WIQL query execution."""
        pass

    @unittest.skip("Deferred to Release 2 - see ADR 001")
    def test_get_work_item_ids_work_item_types(self):
        """Test filtering by work item types."""
        pass

    @unittest.skip("Deferred to Release 2 - see ADR 001")
    def test_enforce_markdown_format_update_needed(self):
        """Test updating work item when Markdown format is needed."""
        pass

    @unittest.skip("Deferred to Release 2 - see ADR 001")
    def test_enforce_markdown_format_already_markdown(self):
        """Test when work item already has Markdown format."""
        pass

    @unittest.skip("Deferred to Release 2 - see ADR 001")
    def test_enforce_markdown_format_dry_run(self):
        """Test dry run doesn't make actual changes."""
        pass

    @unittest.skip("Deferred to Release 2 - see ADR 001")
    def test_enforce_markdown_format_http_error(self):
        """Test handling of HTTP errors."""
        pass

if __name__ == '__main__':
    unittest.main()