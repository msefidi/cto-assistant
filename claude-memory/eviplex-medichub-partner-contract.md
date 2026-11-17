---
name: eviplex-medichub-partner-contract
description: "Eviplex partner model and contract (Medichub, Webop): draft v0.1 for Risch-Kerst ready 12 Nov 2026, not yet sent; brief and log in cto-assistant/eviplex-partnermodell/"
metadata:
  node_type: memory
  type: project
  originSessionId: 07738500-6526-490f-80c6-a837104910de
  modified: 2026-11-15T00:00:00.000Z
---

The partner-model topic lives in `cto-assistant/eviplex-partnermodell/`: `AGENTS.md` is the brief (status, people, open points, source map), `docs/decisions.md` holds every rate and rule with its date, `docs/log.md` the history. Read the brief before advising; this note is only the pointer.

Two things to keep in mind even without opening the folder:

- **Current rates (12 Nov 2026 evening):** partner who brings the customer to closing 15–20 % of net revenue in months 1–12, 10 % in months 13–24, year 3+ negotiable per partner; introduction (hospitals and practices only) a fixed 7.5 % in months 1–12. The rates changed several times that day, so check `decisions.md` before reusing any term.
- **Billing-grade attribution does not exist yet:** UTM values go only to Segment with consent and are not stored on the account (EVP-1348 in Backlog).

**Why:** Eviplex GmbH holds liability and is GDPR controller, so the partner must not sell, price or hold customer data; prices and rates are confidential.

**How to apply:** "catch up on the partner model" means the routine in `cto-assistant/CLAUDE.md`, section "Topics", sub-section "One shape for active topics". Partner marketing claims need the approved wording in [[eviplex-ch-tech-factsheet]]. Sina appears in Outlook and Teams as Martin S. Taheri, see [[people-m365-names]].
