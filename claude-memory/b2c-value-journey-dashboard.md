---
name: b2c-value-journey-dashboard
description: "B2C Value Journey page (Sep 2026 EB strategy meeting, v23): 25 monthly B2C cohorts Aug 2024–Aug 2026; definitions and build log live in cto-assistant/b2c-value-journey/"
metadata:
  type: project
---

Interactive page on monthly B2C member cohorts, built 19–21 Sep 2026 for the Executive Board strategy meeting; last version v23. Page: https://claude.ai/artifact/7pArL6gezoZBfekf436j6a.

The repo holds everything else: start at `cto-assistant/b2c-value-journey/AGENTS.md`, then `docs/log.md` (decisions, newest first), `docs/definitions.md` (cohort, intent classes, behaviour groups, renewal check), `docs/data-pipeline.md` (Metabase 2000-row cap, IFNULL on `is_upgrade_order`) and `docs/dashboard.md`. Read those instead of relying on this note.

Findings worth remembering without opening the folder:
- Year-1 renewal is 62–78% and flat across behaviour groups, because 85% of renewals are automatic: it measures absence of cancellation, not engagement.
- Members pay almost nothing beyond the fee (tickets 1.6% of fees), so product revenue = fee attributed to the product that brought the member in. Refresher-led cohorts bring 67% of fees; CME-led (accredited + SYFAT) is small but growing.

**Why:** later cohort work and the SYFAT / On-Demand Accredited baselines must reuse these definitions.

**How to apply:** Mahyar builds pages like this step by step and strips what isn't needed yet; when he pastes a definition table, implement it literally and state the few gap-filling choices. Data via Metabase REST when `bq` auth has expired, see [[metabase-native-cards-via-api]]. Related: [[b2c-membership-income-dashboard]], [[new-customer-sources]].
