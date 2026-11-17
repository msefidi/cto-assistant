---
name: artifact-index
description: "Artifact Index page (claude.ai) is the register of all workspace outputs; rows in its db, add a row whenever an output is produced"
metadata:
  node_type: memory
  type: reference
  originSessionId: 6c7a136b-2c5b-4ec5-aeef-fb65007962fc
  modified: 2026-11-13T14:04:33.124Z
---

The **Artifact Index** is https://claude.ai/artifact/KPVNKWy8eCpyvHexVeJFuZ (private, built 13 Nov 2026). It lists every output of the CTO workspace of any kind: Claude pages/docs/decks/designs, Office files, emails and memos, skills, and things in Metabase, Notion, Linear, Figma. Rows live in the page database, collection `outputs` (read/write with `ArtifactData`); the page source is `cto-assistant/artifact-index/artifact-index.html`. Field list and rules are in `cto-assistant/AGENTS.md`, section "Artifact Index".

**Why:** Mahyar had 34 claude.ai artifacts and only 5 were linked from the repo; he wants one place to find earlier outputs, and "artifacts are not just HTML".

**How to apply:** look there first when asked about an earlier output; add or update a row whenever a session produces one. Personal items and HR documents stay out (his call, 13 Nov 2026). Deleting a claude.ai artifact needs his own confirmation, so it fails in non-interactive sessions: tell him to use `/artifacts` (d) or the artifact's menu. Repo setup from the same day: [[workspace-repo-setup]].
