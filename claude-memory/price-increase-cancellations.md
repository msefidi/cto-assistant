---
name: price-increase-cancellations
description: "B2C price increase (renewals from 1 Oct 2026): it added ~1–1.5 points of renewal cancellations from mid-Oct, no withdrawal spike; the bigger rise is pre-notice cancellations since Apr 2026 (read 17 Nov 2026)"
metadata:
  type: project
---

Price increase: new B2C members from 1 Sep 2026, existing members at renewals from 1 Oct 2026. A notice email goes daily to members whose renewal is exactly 60 days away, starting 1 Aug 2026 (Mahyar, 30 Sep 2026).

**Conclusion (17 Nov 2026, data to 16 Nov):** the notice pulled the 1–15 Oct cancellations forward without adding any (5.9 % vs 5.7 % baseline). It added about 17 cancellations in 16–31 Oct (8.1 %) and about 20 so far in November (6.6 % vs 5.2 % on the same days), roughly 1–1.5 points of renewals, mostly first renewals. Withdrawals within 14 days of an October renewal did not rise (7.0 % vs 7.4 % in Oct 2025). All cancellations before renewal reached 17.0 % of October renewals (Oct 2025: 13.0 %); most of that gap is the separate rise in cancellations more than 60 days out, which has held at 11–12.6 % of renewals since Apr 2026 (before: 7.7–9.7 %), before the price emails.

Measure: "at risk at D-60" = no renewal-cancellation request before D-60; a cancellation counts on its first CANCEL_MEMBERSHIP request on or before the renewal date; baseline = renewals Oct 2025 – Sep 2026. Data: `platform_raw_membershipservice.public_membership_cancellation_request` (CANCEL_MEMBERSHIP = renewal switched off; REVOKE_MEMBERSHIP = withdrawal; reason always empty). Withdrawn rows lose their "renewed" state, so a renewal = paid B2C membership starting within 48 h of the same user's previous one. SQL: `cto-assistant/archive/price-increase-cancellations/sql/` (30 Sep read) and `sql/2026-11-17-rerun/` (`00_base.sql` goes in front of 01, 02, 03 and 05). First read page: https://claude.ai/artifact/RJFk9kexEvmyfsfWZD2va6.

Not checked: whether renewals were actually billed at the new price.

**How to apply:** the retention lever is the early cancellations (more than 60 days out), not the price notice; see [[b2c-retention-emails]] and [[platform-north-star]].
