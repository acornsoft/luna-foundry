---
name: update-local-deployment
description: Update local deployment: Copy repo .github folders to repo root, commit, merge to main, and push to GitHub.
---

# Update-Local-Deployment Skill

## Overview

This skill handles updating the local deployment by copying developed folders from the repo's .github to the repository root, committing changes, merging to main, and pushing to GitHub.

## Purpose

- Copy developed folders (agents, chatmodes, instructions, prompts, skills, workflows) from repo .github to ~/luna-foundry.
- Commit changes locally.
- Merge develop into main.
- Push to main branch on GitHub.

## Inputs

- Repo .github folder contents.
- Repo root path (default: ~/luna-foundry).
- Branches to merge and push (develop to main).

## Process

1. Copy folders from repo .github to repo root.
2. Stage and commit changes locally.
3. Merge develop into main.
4. Push to GitHub main branch.

## Outputs

- Updated repo root with synced folders.
- Committed changes.
- Merged and pushed to GitHub main.

## Grok Integration

Use Grok for any validation or error checking. Temperature: 0.3 for precise operations.

## Next Phase

Deployment updated; ready for further development or testing.

## Instructions

1. Invoke via @Luna: "@Luna, update local deployment to repo and push to main."
2. Ensure repo .github has the latest developments.
3. Manual fallback: Run .\scripts\Update-Local-Deployment.ps1 (if script exists).

## Examples

- Input: Changes in repo .github.
- Output: Repo root updated, merged to main, and pushed.

## Learned Patterns

- Always merge to main after testing to maintain stability.
- Copy only necessary folders to avoid clutter.