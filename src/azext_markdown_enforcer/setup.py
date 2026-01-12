#!/usr/bin/env python

"""
Setup script for azext_markdown_enforcer Azure CLI extension.
"""

from setuptools import setup, find_packages

setup(
    name='multiline-format-setter',
    version='0.1.0',
    description='Azure CLI extension to set multiline format to Markdown on work items',
    long_description='A Python Azure CLI extension that sets multilineFieldsFormat to "markdown" on Azure DevOps work items, enabling Markdown support for multiline fields.',
    author='Acornsoft365',
    author_email='david@acornsoft365.com',
    url='https://github.com/acornsoft365/luna-foundry',
    packages=find_packages(),
    install_requires=[
        'requests>=2.25.0',
    ],
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3.10',
        'Programming Language :: Python :: 3.11',
    ],
    python_requires='>=3.8',
)