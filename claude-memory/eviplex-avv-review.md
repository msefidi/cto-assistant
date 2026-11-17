---
name: eviplex-avv-review
description: "Eviplex user AVV (V-05, Anlage 2.1 TOMs / 2.2 subprocessors) and FOMF↔Eviplex § 203 secrecy agreement; review for Habib 3 Nov 2026; brief and log in cto-assistant/eviplex-avv/"
metadata:
  node_type: memory
  type: project
  originSessionId: 18077c01-474f-4f4f-8a2a-cf972e655fe6
  modified: 2026-11-15T00:00:00.000Z
---

The AVV topic lives in `cto-assistant/eviplex-avv/`: `AGENTS.md` is the brief (status, open points, source map), `docs/decisions.md` the agreed wording and positions, `docs/log.md` the dated history. The review page lists security gaps and is in the git-ignored `cto-assistant/cybersecurity/reports/`. Read the brief before advising; this note is only the pointer.

Two things to keep in mind even without opening the folder:

- **The documents describe the end state.** Habib hands them out only once everything in them is live, and Mahyar promised to tell him when (3–4 Nov 2026). Do not call a TOM true until it is verified in prod.
- **Re-verify before reusing any TOM claim.** On 3 Nov several were untrue (list in the review page). The OpenAI EU pin and EU dictation merged on 10 Nov (meviq #1093); TLS (#1079) was still open on 15 Nov. Fixes belong in the meviq repo and GCP and need approval.

**Why:** Eviplex GmbH holds the liability; the TOMs are promises to doctors under § 203.

**How to apply:** "catch up on the AVV" means the routine in `cto-assistant/CLAUDE.md`, section "Topics", sub-section "One shape for active topics". Related: [[eviplex-ch-tech-factsheet]] (Google PSA status), [[security-assessment-vendor]].
