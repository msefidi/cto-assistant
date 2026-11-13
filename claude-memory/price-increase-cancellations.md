---
name: price-increase-cancellations
description: B2C price increase (new members 1 Sep 2026, renewals from 1 Oct 2026, notice emails from 1 Aug at ~D-61) — how to measure renewal cancellations; first read 30 Sep 2026
metadata:
  type: project
---

Price increase: new B2C members from 1 Sep 2026; existing members at renewals from 1 Oct 2026, notice email runs daily and goes to members whose renewal is exactly 60 days away (confirmed by Mahyar 30 Sep 2026), starting 1 Aug 2026. Mahyar asked (30 Sep 2026) whether renewal cancellations are trending up.

Data: `platform_raw_membershipservice.public_membership_cancellation_request` (cancellation_type CANCEL_MEMBERSHIP = renewal switched off, created_at = when; REVOKE_MEMBERSHIP = withdrawal; reason always empty). `public_user_membership` has no cancellation timestamp. SQL in `cto-assistant/price-increase-cancellations/sql/`. Usable baseline starts with renewals from Jul 2025 (earlier months have few rows). Old regime evidently had a reminder ~30 days before renewal.

First read (30 Sep 2026): the notice pulls cancellations forward rather than adding them. Renewals 1–15 Oct (almost fully observed) cancelled 4.6% of those still renewing at D-60 vs a 4.7% baseline. Late-Oct and Nov renewals are elevated so far (4.8% vs 2.6%; Nov 2.4% vs 0.8%), about 35 extra cancellations. Concentrated in first renewals. Separate trend: cancellations more than 60 days out rose from 8–9% to 11–13% of renewals from Apr 2026, which is before the price emails.

Mahyar's pushback (30 Sep): the weekly YoY bars (Oct–Dec renewals, Aug–Sep 104 → 164) show clearly more cancellations. Agreed, and the page headline was softened. Split by each member's own notice day: +30 came after the notice, +33 before it (the general rise, not the price). At matched timing: 1–15 Oct −8, 16–31 Oct +17, Nov +22 (≈ +31). Artifact: https://claude.ai/artifact/RJFk9kexEvmyfsfWZD2va6 (file `price-increase-cancellations/cancellations.html`).

**How to apply:** re-run after the Oct renewals have passed (final Oct rate vs ~13–15%) and track REVOKE_MEMBERSHIP within 14 days of an Oct auto-renewal (withdrawal after being charged the new price).
