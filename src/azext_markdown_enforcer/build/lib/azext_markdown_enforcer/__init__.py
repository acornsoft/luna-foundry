"""
Azure CLI extension for setting multiline format to Markdown on work items.
"""

__version__ = "0.1.0"

def load_command_table(command_table, **kwargs):
    """Load commands into the command table."""
    from .commands import load_command_table as load_cmd
    load_cmd(command_table, **kwargs)

def load_arguments(command_table, **kwargs):
    """Load arguments for commands."""
    from .commands import load_arguments as load_arg
    load_arg(command_table, **kwargs)