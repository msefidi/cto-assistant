---
name: initiative-shape
description: "A new convention goes into CLAUDE.md with a template to copy; initiative folders follow cto-assistant/_template/ (brief, log, pointer)"
metadata:
  type: feedback
---

When Mahyar asks how to structure something in the workspace, deliver it as a written rule in `cto-assistant/CLAUDE.md` plus a template to copy, with a "done when" for each routine. A proposal that depends on habit is not enough.

**Why:** on 13 Nov 2026 I pointed out that his project folders were inconsistent (three log formats, some briefs, some none). His answer: "they are inconsistent because the agents every time did something different". The folders were built by agents with no shared shape to follow.

**How to apply:** initiative folders are copied from `cto-assistant/_template/` (`AGENTS.md` brief with a source map, `docs/decisions.md` with one line per decision, `docs/log.md` for events, one-line `CLAUDE.md`), and `cto-assistant/INITIATIVES.md` lists every folder. The rules are in `cto-assistant/CLAUDE.md`, section "Initiatives". Follow the existing shape before inventing a layout; if it does not fit, change the template and the rule, so the next agent gets the same answer. First case: [[aekw-tender]].

On 15 Nov 2026 Mahyar decided the repo stays the record, not claude.ai Projects: agents keep the files current and git versions them. A Project may later serve as a read-only view, for sharing or the phone, but never as a second copy. Related: [[workspace-repo-setup]], [[artifact-index]].
