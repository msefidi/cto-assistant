---
name: verify-live-state
description: "Before telling Mahyar something is open, pending or unsigned, check the live source (gh, Linear, mail); briefs and logs lag reality"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 49320895-3128-49ad-972f-bf3185983827
  modified: 2026-11-18T13:13:25.303Z
---

A brief's Status line is a snapshot from the session that wrote it. Before passing a status on to Mahyar as current, check the live source, especially when it backs a correction of his words or a claim that leaves FOMF. For a PR, run `gh pr view`. For an issue, check Linear. For a reply, check Outlook or Teams. Read-only `gh` is preapproved and takes seconds.

**Why:** On 18 Nov 2026 I told Mahyar that PR #1079 (Eviplex EU gateway endpoint) was still open, citing the AVV brief's "As of 17 Nov" line. That line was written at about 15:50 CET; the PR was merged at 20:49 CET the same evening, and no session updated the brief. I corrected his correct sentence in a draft to Benigna with the stale fact.

**How to apply:** if the live state differs from the brief, update the brief and log in the same session ([[topic-shape]]). If a check isn't possible (connector down), say "as of <date> per the brief, not re-checked" instead of stating it as fact.
