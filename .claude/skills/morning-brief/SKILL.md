---
name: morning-brief
description: Read-only morning planning brief for Mahyar. Pulls Linear "My Issues" AND open Todoist tasks into one converged digest he uses to timebox his day into the Outlook calendar. Reads both sources, writes nothing by default. Invoke on "morning brief", "plan my day", "what's on today", or /morning-brief.
---

# Morning brief

A single converged planning surface. The point is NOT to move tasks between tools, it's to read Linear and Todoist together once each morning so Mahyar can decide what to timebox onto his calendar today. Linear stays the system of record; the calendar is where time actually gets committed; this brief is the daily convergence step.

**Read-only by default.** Do not create/edit/complete anything in Linear or Todoist while generating the brief. Writes (e.g. creating calendar blocks) only happen if Mahyar explicitly asks, and with confirmation.

## Procedure

1. **Load tools** via ToolSearch (deferred): `mcp__claude_ai_Linear__list_issues`, `mcp__claude_ai_Todoist__find-tasks`. (Add `mcp__claude_ai_Microsoft_365__*` calendar tools only if he asks to block time.)

2. **Linear — My Issues:** `list_issues(assignee="me", limit=250, includeArchived=false)`.
   - Output can be very large (>100k chars) and exceed the token cap. If it's saved to a file, parse it in a **subagent** (Agent tool) returning only active issues (identifier, title, status name, status type, team, project, url). Keep the raw dump out of context.
   - Keep only active issues: exclude state types `completed`, `canceled`, `duplicate`.
   - "In Review" = status name contains "review" (case-insensitive).

3. **Todoist — open commitments:** pull what's actionable now:
   - `find-tasks(filter="overdue")`, `find-tasks(filter="today")`, and `find-tasks(filter="no date")` (or a combined filter). These are the non-Linear commitments (after the one-time cleanup, no Linear issues live in Todoist).

4. **Render the brief** as two clean sections so each keeps the overview Mahyar likes:
   - **Linear (system of record):** group by **team -> status**, flag `[In Review]`, show the issue ID + title. Lead with In Progress / In Review (things in flight), then Todo, then Backlog/Triage collapsed to a count.
   - **Todoist (everything else):** Overdue first, then Due today, then a short list of undated/available.
   - End with a **suggested timebox**: propose 2 to 4 Linear items plus any must-do Todoist items to block today (he can't advance 25 issues/day, so force a small pick). Ask which to put on the calendar.

5. **Optional write step (only if asked):** create Outlook calendar blocks for the chosen items via the M365 tools, confirming time/duration first.

## Notes

- This replaced an earlier "sync Linear into Todoist" approach. Do NOT mirror Linear issues into Todoist, it duplicates Linear's best feature (the grouped overview) and creates a second list to reconcile. Read both; write neither.
- Linear payloads: parse big responses in a subagent.
- Todoist MCP proxy intermittently 502s on heavy writes; not relevant here since the brief is read-only.
