---
name: b2c-membership-income-dashboard
description: "Metabase dashboard 1816 \"B2C Membership Income\" for the Sep 2026 EB strategy meeting — card ids, definitions, and agreed member-count basis"
metadata: 
  node_type: memory
  type: project
  originSessionId: a8e4f3ac-9324-4567-839b-50d6631cdd58
  modified: 2026-09-18T20:59:08.057Z
---

Built 2026-09-18 for the Executive Board strategy meeting (week of 2026-09-21). Dashboard: https://fomf2.metabaseapp.com/dashboard/1816 (Executive Board collection 201). Window Sep 2025 – Sep 2026.

Cards: 7855 Active B2C Members (scalar), 7856 by country×type (table), 7857 members over time stacked by country (bar, dbt daily series `fct_active_memberships_daily_unpivoted`, value on 1st of month), 7889 ARR by country (native SQL; active paid memberships × annualised order price, on the 1st of month), 7888 revenue per month by country in EUR (native SQL on raw `platform_raw_membershipservice` orders; PAID, B2C, net of REVOKED, CHF×1.05, by order month). Dashboard order: members → members over time → ARR → cash revenue.

Mahyar's decision: member counts must match the "Daily Membership Update" dashboard's "Total B2C" card (question 959 built on 2891 "Dim User Memberships B2C") — i.e. *active* not *paying*; 7855/7856 are built on source-card 2891 for that reason. Paying variant (excl. OFFERED_BY_ADMIN, NOT_PAID) ≈ 390 lower; SQL for both kept in `cto-assistant/b2c-income-dashboard/sql/`.

Known caveats to repeat when asked: dbt series is ~0.1% above the daily report (clinic-linked + fomf-in-email members); revenue is cash-basis and strongly seasonal (Oct–Nov renewal peak, Jul trough) — ARR card 7889 covers the recurring view. Do not touch EB dashboard 397 "Platform metrics" (tabbed; earlier mishap).

**Why:** the board deck reuses these numbers; definitions must stay consistent.
**How to apply:** extend dashboard 1816 rather than creating new ones; keep the 959 definition for member counts. See [[metabase-native-cards-via-api]].
