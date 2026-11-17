---
name: security-assessment-vendor
description: "Blaze security assessment (M365, GCP, pentests): contract + DPA signed 9 Nov 2026 (€31,900 net, 29 d); brief and log in cto-assistant/cybersecurity/"
metadata:
  node_type: memory
  type: project
  originSessionId: ab6f3fd4-c6d2-4f65-bb3c-2214f787b7a6
  modified: 2026-11-16T00:00:00.000Z
---

The security assessment lives in `cto-assistant/cybersecurity/`: `AGENTS.md` is the brief (status, contract at a glance, open points, source map), `docs/decisions.md` the decisions and `docs/log.md` the dated history (Mandiant dropped July 2026, PCG vs Blaze, NDA, contract). Read the brief before advising; this note is only the pointer.

Two things to keep in mind even without opening the folder:

- **Dates cost money once agreed.** Blaze's SOW months are not binding, but MSA 10.3 charges 25/50/100 % for cancelling within 15/10/5 working days of an agreed start. Commit only to dates IT and the product teams can meet; move them at least 4 weeks ahead. Blaze proposed dates on 12 Nov 2026 (M365 from 23 Nov); on 16 Nov Mahyar moved them as a weekly timeline (M365 + debrief week of 7 Dec, Mahyar away from 14 Dec; then one part per week from 6 Jan, pentests a week apart, tests end week of 8 Feb; phase order kept), sent to Blaze on 16 Nov, awaiting confirmation.
- **Findings never go in the brief, log or memory.** They go in `cto-assistant/cybersecurity/reports/` (git-ignored) and SharePoint.

**Why:** Blaze covers the dropped Mandiant scope (M365 + GCP) plus manual pentests of both products; PCG had no M365 and no real product pentest. The GKE review targets the in-cluster gaps from [[php2shell-drupal-incident]].

**How to apply:** "catch up on cybersecurity" means the routine in `cto-assistant/CLAUDE.md`, section "Topics", sub-section "Initiatives — one shape"; the shape is in [[topic-shape]]. Sina appears in Outlook and Teams as Martin S. Taheri, see [[people-m365-names]].
