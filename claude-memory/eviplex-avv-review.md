---
name: eviplex-avv-review
description: "Eviplex user AVV and FOMF↔Eviplex § 203 secrecy agreement; the documents describe the end state; brief and log in cto-assistant/eviplex-avv/"
metadata:
  type: project
---

The AVV topic lives in `cto-assistant/eviplex-avv/`: `AGENTS.md` is the brief (status, open points, source map), `docs/decisions.md` the agreed wording and positions, `docs/log.md` the history, including the Google PSA. Status is in `cto-assistant/TOPICS.md`. The review page lists security gaps and is in the git-ignored `cto-assistant/cybersecurity/reports/`. Read the brief before advising; this note is only the pointer.

- **The documents describe the end state.** Habib hands them out only once everything in them is live, and Mahyar tells him when (agreed 3–4 Nov 2026).
- **Re-verify a TOM claim in code and GCP before reusing it.** Several were untrue on 3 Nov. Fixes land in the meviq repo and `meviq-prod` and need Mahyar's approval.

**Why:** Eviplex GmbH holds the liability; the TOMs are promises to doctors under § 203.

**How to apply:** "catch up on the AVV" means the routine in `cto-assistant/CLAUDE.md`, section "Topics", sub-section "One shape for active topics". Claim wording for Eviplex is in `cto-assistant/eviplex/claims-and-legal.md` ([[eviplex-product]]). Related: [[security-assessment-vendor]].
