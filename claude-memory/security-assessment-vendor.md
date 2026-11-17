---
name: security-assessment-vendor
description: "Blaze security assessment (M365, GCP, pentests); agreed dates cost money to move; brief and log in cto-assistant/cybersecurity/"
metadata:
  type: project
---

The security assessment lives in `cto-assistant/cybersecurity/`: `AGENTS.md` is the brief (status, contract at a glance, open points, source map), `docs/decisions.md` the decisions and `docs/log.md` the history (Mandiant dropped July 2026, PCG vs Blaze, NDA, contract, phase dates). Status is in `cto-assistant/TOPICS.md`. Read the brief before advising; this note is only the pointer.

- **Dates cost money once agreed.** MSA 10.3 charges 25/50/100 % for cancelling within 15/10/5 working days of an agreed start. Commit only to dates IT and the product teams can meet, and move them at least 4 weeks ahead.
- **Findings never go in the brief, log or memory.** They go in `cto-assistant/cybersecurity/reports/` (git-ignored) and SharePoint, and never into external tools.

**Why:** Blaze covers the dropped Mandiant scope (M365 + GCP) plus manual pentests of both products and a GKE review aimed at the in-cluster gaps from [[php2shell-drupal-incident]].

**How to apply:** "catch up on cybersecurity" means the routine in `cto-assistant/CLAUDE.md`, section "Topics", sub-section "One shape for active topics", see [[topic-shape]]. Sina appears in Outlook and Teams as Martin S. Taheri, see [[people-m365-names]].
