---
name: workspace-repo-setup
description: ai-folders repo is work-only on msefidi (private); personal work lives outside; changes go via PR + squash-merge; security reports git-ignored
metadata:
  node_type: memory
  type: project
  originSessionId: 6c7a136b-2c5b-4ec5-aeef-fb65007962fc
  modified: 2026-11-13T14:04:38.119Z
---

Decided 13 Nov 2026 during a cleanup of `ai-folders`:

- The repo stays at `msefidi/ai-folders` (private) and is **work-only**. Personal projects (e.g. `abm/`) were moved out to their own folder.
- Not moved to `fomf-code`: that org gives every member read access to all repos, which would expose EB material, contract drafts and security docs. A restricted org under the FOMF enterprise is the possible later home.
- `signals/` stays in the work repo.
- `cto-assistant/cybersecurity/reports/` is git-ignored: pentest findings (Blaze) stay in SharePoint.
- No timestamped backup copies in the repo; git is the backup.
- **Memory is versioned:** the memory files live in `ai-folders/claude-memory/`. Claude Code's memory path (`~/.claude/projects/-Users-mahyar-Development-Repositories-ai-folders/memory`) is a symlink to it. Memory edits show up in `git status` and get committed with the rest of the work.
- Project notes record a status at a date; when a project ends, shrink its note to the outcome and reusable lessons, or delete it (the hackathon note was dropped on 13 Nov 2026).

**Why:** four weeks of work existed only on the laptop, and the folder mixed personal and work material.

**How to apply:** push work regularly through a branch + PR + squash-merge (the pattern Mahyar accepted for PRs #2 and #3). Keep the local path unchanged: Claude Code finds the memory through the symlink under a path-keyed folder, so moving or renaming `ai-folders` needs the symlink redone. If memory ever looks empty, check that the symlink still exists. Before deleting a branch or worktree, move anything useful into the project folder. Outputs are tracked in [[artifact-index]].
