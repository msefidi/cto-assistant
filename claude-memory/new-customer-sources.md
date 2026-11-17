---
name: new-customer-sources
description: "New Customer Sources artifact (24 Sep 2026) — new B2C customers by checkout-survey source, 'Mitgliedschaft' redistributed proportionally; SQL in cto-assistant/archive/acquisition-sources/"
metadata:
  type: project
---

Built 2026-09-24. Artifact https://claude.ai/artifact/S6Fwroo2vD5tuVgZV2YERr. Files: `cto-assistant/archive/acquisition-sources/` (`sql/new_customers_by_source.sql`, `sql/new_members_membership_survey.sql`, `page.template.html` + `data/embed.js` → `new-customer-sources.html`).

Mahyar's rule: member bookings are auto-answered "Mitgliedschaft" in `analysis.fct_course_booking_marketing_sources`; spread new members over the other sources in proportion to the single-course answers (implemented per month × country). New customer = first paid purchase (paid non-member booking > €0, or PAID B2C membership order). Cross-check against the membership checkout survey (`fct_membership_marketing_sources`, multi-select → 1/k weights; 39% unanswered in 2025/26).

UK (GBR) excluded (DACH only). Years Sep–Aug, 2023/24 added 2026-09-24. Mahyar chose to count only accounts created from Mar 2022 on (older accounts were migrated; their pre-May-2022 history is invisible, so returning customers looked new: 25% of 23/24 vs 12% of 25/26). Result 23/24 → 24/25 → 25/26: 6,932 → 6,311 → 6,775 new customers; single course 4,687 → 4,462 → 3,496; members 2,245 → 1,849 → 3,279 (share 32% → 29% → 48%); print 40% → 37% → 33%. The booking-survey option "FOMF website / former participant" was dropped in Apr 2024 (10% of 23/24), which moves part of the 23/24 mix. The membership survey was unanswered for 42% of new members in 25/26.

**Correction 2026-09-24:** free memberships (state OFFERED_BY_ADMIN, 14-month/3-month €0 offers, ~100–300/month since autumn 2025) and REVOKED orders are excluded from "paid membership" everywhere. Corrected Sep–Aug: 6,860 → 6,248 → 5,428 new customers; members 2,172 → 1,781 → 1,915.

**Skipped June mailing (artifact https://claude.ai/artifact/DLtTuLcoRbHaJZ9kSKfUvf, 2026-09-24):** window 1 Jan–22 Sep 2024–26. 2026 DE mailings landed 27/28 Nov 2025, 22–26 Mar, 9/10 Sep (Marketingplan_2026.xlsx); 2025 had Feb, Jun, Aug. June 2025 wave cost €420.6k DACH (SharePoint "Postaussendung Kosten 2025.docx"). Difference-in-differences with Jan–May as baseline: 1 Jun–17 Aug no loss (+31 new customers vs trend); 18 Aug–22 Sep −119 (autumn timing mixed in); total −88 customers ≈ €80k 24-month value vs break-even ~459. Re-check 23 Sep–30 Nov in December. LTV24 table by entry × Facharzt/Assistenzarzt × specialty in data/ltv_by_segment.tsv. Habib's EB project "PA-analysis" (SharePoint EB site, Claude/PA-analysis/CLAUDE.md) has recipient-matching, CAC, career-stage and frequency studies — reuse, don't redo.

**How to apply:** reuse these definitions for follow-ups (e.g. SYFAT / On-Demand Accredited acquisition). Related: [[b2c-value-journey-dashboard]].
