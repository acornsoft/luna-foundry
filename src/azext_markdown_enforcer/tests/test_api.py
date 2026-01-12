"""
Unit tests for the Markdown Enforcer API.
"""

import unittest
from unittest.mock import Mock, patch, MagicMock
import sys
import os

# Mock Azure CLI modules before importing our code
sys.modules['azure.cli.core'] = Mock()
sys.modules['azure.cli.core.commands'] = Mock()
sys.modules['azure.cli.core.extension'] = Mock()

# Add the extension to the path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from azext_markdown_enforcer.api import MultilineFormatSetterAPI

class TestMultilineFormatSetterAPI(unittest.TestCase):
    """Test cases for MultilineFormatSetterAPI."""

    @patch('subprocess.run')
    def setUp(self, mock_subprocess):
        """Set up test fixtures."""
        # Mock Azure CLI configuration
        mock_subprocess.return_value.stdout = """
        {
            "organization": "https://dev.azure.com/testorg",
            "project": "testproject"
        }
        """

        # Mock token retrieval
        mock_token_result = Mock()
        mock_token_result.stdout = '{"accessToken": "test-token"}'
        mock_subprocess.side_effect = [mock_token_result]

        self.api = MultilineFormatSetterAPI(org="testorg", project="testproject")

    @patch('requests.request')
    def test_get_work_item_ids_by_ids(self, mock_request):
        """Test getting work item IDs when IDs are provided directly."""
        ids = [123, 456, 789]
        result = self.api.get_work_item_ids(ids=ids)
        self.assertEqual(result, ids)

    @patch('requests.request')
    def test_get_work_item_ids_by_wiql(self, mock_request):
        """Test getting work item IDs using WIQL query."""
        mock_response = Mock()
        mock_response.json.return_value = {
            "workItems": [{"id": 123}, {"id": 456}]
        }
        mock_request.return_value = mock_response

        wiql = "SELECT [System.Id] FROM WorkItems"
        result = self.api.get_work_item_ids(wiql=wiql)

        self.assertEqual(result, [123, 456])
        mock_request.assert_called_once()

    @patch('requests.request')
    def test_enforce_markdown_format_dry_run(self, mock_request):
        """Test enforcing Markdown format in dry run mode."""
        # Mock work item retrieval
        mock_wi_response = Mock()
        mock_wi_response.json.return_value = {
            "multilineFieldsFormat": {
                "System.Description": "html"
            }
        }
        mock_request.return_value = mock_wi_response

        work_item_ids = [123]
        fields = ["System.Description"]

        result = self.api.set_multiline_format_to_markdown(
            work_item_ids=work_item_ids,
            fields=fields,
            dry_run=True
        )

        self.assertEqual(len(result), 1)
        self.assertTrue(result[0]['dry_run'])
        self.assertTrue(result[0]['success'])

    @patch('subprocess.run')
    def test_initialization_with_org_project(self, mock_subprocess):
        """Test API initialization with org and project."""
        # Mock token retrieval (only call made when org/project provided)
        mock_token_result = Mock()
        mock_token_result.stdout = '{"accessToken": "test-token"}'
        mock_token_result.returncode = 0

        mock_subprocess.return_value = mock_token_result

        api = MultilineFormatSetterAPI(org="testorg", project="testproject")
        self.assertEqual(api.org, "testorg")
        self.assertEqual(api.project, "testproject")
        self.assertEqual(api._token, "test-token")

if __name__ == '__main__':
    unittest.main()