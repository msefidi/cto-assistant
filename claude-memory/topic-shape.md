---
name: topic-shape
description: "A new convention goes into CLAUDE.md with a template to copy; every folder is a topic listed in TOPICS.md; active topics follow cto-assistant/_template/; the word "initiative" is retired"
metadata:
  type: feedback
---

When Mahyar asks how to structure something in the workspace, deliver it as a written rule in `cto-assistant/CLAUDE.md` plus a template to copy, with a "done when" for each routine. A proposal that depends on habit is not enough.

**Why:** on 13 Nov 2026 I pointed out that his project folders were inconsistent (three log formats, some briefs, some none). His answer: "they are inconsistent because the agents every time did something different". The folders were built by agents with no shared shape to follow.

**How to apply:** every folder is a **topic** in one group: active (runs longer than one session), recurring, or done or reference. `TOPICS.md` (loaded every session) lists active and recurring; `TOPICS-DONE.md` (read on demand) lists the done ones. When a topic finishes, its folder moves to `cto-assistant/archive/` (Mahyar chose archiving over deleting on 17 Nov 2026: memory notes are only pointers, the log and decisions are the record) and its memory pointer note is marked closed. The tooling folders `_template/`, `artifact-index/` and `topics-overview/` are not topics and have no line in `TOPICS.md`. Product folders (`eviplex/`, later `platform/`) hold what stays true about a product; lasting product facts go there, not into memory (Mahyar, 17 Nov 2026). `cto-assistant/TOPICS.md` lists them all. Active topics are copied from `cto-assistant/_template/` (`AGENTS.md` brief with a source map, `docs/decisions.md` with one line per decision, `docs/log.md` for events, one-line `CLAUDE.md`); a recurring topic needs only an `AGENTS.md`. The rules are in `cto-assistant/CLAUDE.md`, section "Topics". Follow the existing shape before inventing a layout; if it does not fit, change the template and the rule, so the next agent gets the same answer. First case: [[aekw-tender]].

On 15 Nov 2026 Mahyar decided the repo stays the record, not claude.ai Projects: agents keep the files current and git versions them. A Project may later serve as a read-only view, for sharing or the phone, but never as a second copy. Related: [[workspace-repo-setup]], [[artifact-index]].

On 17 Nov 2026 Mahyar renamed `INITIATIVES.md` to `TOPICS.md`: "some of the topics are initiatives, some of them are just simple topics". The same day he retired the word "initiative": "initiative is just a longer term topic". Say "topic" (or "active topic"), never "initiative", except for Linear initiatives.
