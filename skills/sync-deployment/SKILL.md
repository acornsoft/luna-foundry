---
name: sync-deployment
description: Sync local ~/.github developments to repo root, commit, and push to GitHub.
---

# Sync-Deployment Skill

## Overview

This skill handles the deployment of developments from repo .github to the repository root, ensuring the workspace is updated, committed locally, and pushed to GitHub if tests pass.

## Purpose

- Copy developed folders (agents, chatmodes, instructions, prompts, skills) from repo .github to ~/luna-foundry.
- Commit changes locally.
- Test for issues; if OK, push to develop branch on github.com.

## Inputs

- Repo .github folder contents.
- Repo root path (default: ~/luna-foundry).
- Branch to push (default: develop).

## Process

1. Copy folders from repo .github to repo root.
2. Stage and commit changes locally.
3. Run basic tests (e.g., check for syntax errors).
4. If tests pass, push to GitHub develop branch.
5. If tests fail, abort push and notify.

## Outputs

- Updated repo with synced folders.
- Committed changes.
- Pushed to GitHub (if successful).

## Grok Integration

Use Grok for any validation or error checking. Temperature: 0.3 for precise operations.

## Next Phase

Deployment complete; ready for further development.

## Instructions

1. Invoke via @Luna: "@Luna, sync deployment to repo and push to develop."
2. Ensure ~/.github has the latest developments.
3. Manual fallback: Run .\scripts\Sync-Deployment.ps1.

## Examples

- Input: Local changes in ~/.github.
- Output: Repo updated and pushed.

## Learned Patterns

- Always test before push to avoid breaking main branch.