---
name: platform-north-star
description: Oct 2026 platform North Star work — usage/CME does not predict year-1 renewal (85% automatic); CME points source table
metadata:
  node_type: memory
  type: project
  originSessionId: 2b37fb47-637f-4a86-990b-4c86e6767fe3
  modified: 2026-10-13T12:54:38.124Z
---

Started 13 Oct 2026: Mahyar asked for FOMF's North Star KPIs, then "focus on platform first". Proposed NSM: value-realising members (doctors: CME points earned; assistant doctors: SYFAT/Facharzt progress).

Test on 4,243 B2C members (cohorts 2024-08..2025-09, year-1 checkpoint observable, cohort SQL definitions): year-1 renewal is flat ~72% regardless of CME points earned (0 → 72%, 50+ → 75%) or meaningful-video months. 85% of renewals are automatic (94% among zero-CME members). Usage shows only in active-choice renewal (5% at 0 CME → 14% at 50+) and weakly in year 2 (n small). CME in year 1: 11% zero, 50% 25–49 (median 32 ≈ one Refresher), 15% reach 50+.

CME points source: `platform_raw_contentaccreditationservice.public_participants_summary` (participant_id = user_id; granted_points is a JSON array per accreditation body, take the `mainAccreditation` entry's `amount`; contains names/EFN, never select them). `analysis.fct_user_membership_engagement` has CME per current term only (16.5k rows).

**Why:** renewal is inertia, not a value signal; a retention-based NSM would reward inertia.
**How to apply:** don't validate value metrics against year-1 renewal alone; the natural test is the Oct 2026 price-increase cancellations ([[price-increase-cancellations]]) and active-choice / year-2 renewal. Related: [[b2c-value-journey-dashboard]].

**Churn basics and decomposition (13 Oct 2026).** Standard annual logo churn on paying B2C (spells, 14-day gap): 22.4% (1 Oct 2025 → 1 Oct 2026), 23.0% the year before; monthly avg ~1.8%, very seasonal. Metabase card 998 (Anah) is a renewal rate by start month on an unclean base (staff accounts, revoked, free; month-truncated join) → shows 66% where the clean figure is ~78%.
Annual renewals due Oct 2025–Sep 2026: 9,805, lost 2,287. Of the losses: 1,354 (59%) switched off renewal in advance (18% of those in month 1 of the term, 30% in months 4–9, 22% in the last 30 days); ~640 (28%) were auto-renewed, then revoked on request (refund/withdrawal); ~263 (11%) renewal order never paid (failed payment). cancellation_reason is always empty. SQL in the session scratchpad only (cancel_timing.sql, silent2.sql), built on cto-assistant/archive/price-increase-cancellations/sql/base.sql.
