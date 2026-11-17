---
name: workspace-repo-setup
description: The CTO workspace is its own private repo msefidi/cto-assistant (moved out of ai-folders 17 Nov 2026); memory versioned in claude-memory/ (symlinked); PR + squash; security reports git-ignored
metadata:
  node_type: memory
  type: project
  originSessionId: 6c7a136b-2c5b-4ec5-aeef-fb65007962fc
  modified: 2026-11-13T14:04:38.119Z
---

Decided 13 Nov 2026 during a cleanup of `ai-folders`; on 17 Nov 2026 the workspace moved out of `ai-folders` into its own repo (history kept):

- The repo is `msefidi/cto-assistant` (private), local path `~/Development/Repositories/fomf/cto-assistant`, and is **work-only**. Personal projects live elsewhere. `ai-folders` keeps the other projects (`eviplex-model/`, `pm/`).
- Not moved to `fomf-code`: that org gives every member read access to all repos, which would expose EB material, contract drafts and security docs. A restricted org under the FOMF enterprise is the possible later home.
- `signals/` stays in the work repo.
- `cybersecurity/reports/` is git-ignored: pentest findings (Blaze) stay in SharePoint. `.env` (Metabase key) is git-ignored too.
- No timestamped backup copies in the repo; git is the backup.
- **Memory is versioned:** the memory files live in `claude-memory/` in this repo. `.claude/settings.json` sets `autoMemoryDirectory` to it, and Claude Code's path-keyed memory folder (`~/.claude/projects/-Users-mahyar-Development-Repositories-fomf-cto-assistant/memory`) is a symlink to it. Memory edits show up in `git status` and get committed with the rest of the work.
- What goes into memory, and what stays out (status, history, findings), is in the root `AGENTS.md`, section "Memory". When a topic ends, its note is marked closed and shrunk to the outcome and reusable lessons.

**Why:** four weeks of work existed only on the laptop, and the folder mixed personal and work material.

**How to apply:** push work regularly through a branch + PR + squash-merge. Keep the local path unchanged: moving or renaming the repo folder needs the symlink and `autoMemoryDirectory` redone. If memory ever looks empty, check both. Before deleting a branch or worktree, move anything useful into the project folder. Outputs are tracked in [[artifact-index]].
