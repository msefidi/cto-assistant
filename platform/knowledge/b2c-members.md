# Platform: B2C members

What we know about FOMF's B2C members. Read before any B2C, SYFAT or On-Demand analysis. Each line says when it was established; the evidence and SQL are in the archived analyses listed at the end. When a newer analysis changes a finding, rewrite the line.

## Agreed definitions (change only with Mahyar)

- **Cohorts, intent, active, renewed, money:** `../../archive/b2c-value-journey/docs/definitions.md` (Sep 2026). Later cohort work, and the SYFAT and On-Demand baselines, reuse them.
- **Member count** = active, not paying: it matches the "Total B2C" card 959 (built on 2891 "Dim User Memberships B2C") of the "Daily Membership Update" dashboard. The paying count (without OFFERED_BY_ADMIN and NOT_PAID) is about 390 lower. (Sep 2026)
- **New customer** = first paid purchase: a paid non-member booking above €0, or a PAID B2C membership order. Free memberships (OFFERED_BY_ADMIN; 14-month and 3-month €0 offers, about 100–300 a month since autumn 2025) and REVOKED orders are never "paid". Only accounts created from March 2022 count: older accounts were migrated and their history before May 2022 is invisible. DACH only, UK excluded. Years run Sep–Aug. (Sep 2026)
- **Member bookings** are auto-answered "Mitgliedschaft" in the booking survey; spread new members over the other sources in proportion to the single-course answers, per month and country. (Sep 2026)
- **Product revenue** = the membership fee attributed to the product that brought the member in, plus stand-alone sales. Members pay almost nothing beyond the fee: tickets are 1.6 % of fees. (Sep 2026)
- **Cancelled** = renewal switched off (CANCEL_MEMBERSHIP); the member stays active until expiry. **Withdrawn** = REVOKE_MEMBERSHIP. A renewal = a paid B2C membership starting within 48 hours of the same user's previous one. The cancellation reason field is always empty.
- **Name:** the membership is the "FOMF-All-Access-Paket" in anything external, never "Mitgliedschaft" (Mahyar, 5 Nov 2026). Internal analyses may say "membership" for the data concept.

## Renewal and churn

- **Renewal is inertia, not a value signal.** 85 % of renewals are automatic (94 % among members with no CME). Year-1 renewal is about 72 % and flat across CME points (0 → 72 %, 50+ → 75 %) and video use; usage shows only in active-choice renewal (5 % → 14 %). A retention-based North Star would reward inertia. Proposed instead (Oct 2026, not decided): value-realising members, i.e. CME points earned for doctors and SYFAT progress for assistant doctors. In year 1, 11 % of members earn no CME, 50 % earn 25–49 (median 32, about one Refresher), 15 % reach 50+. (Oct 2026)
- **Churn:** 22.4 % annual logo churn on paying B2C (1 Oct 2025 → 1 Oct 2026; 23.0 % the year before), monthly about 1.8 % and very seasonal. Metabase card 998 shows about 66 % renewal on an unclean base; the clean figure is about 78 %. (Oct 2026)
- **Where renewals are lost** (due Oct 2025 – Sep 2026: 9,805, lost 2,287): 59 % switched off renewal in advance, 28 % were auto-renewed and then withdrew, 11 % never paid the renewal order. (Oct 2026)
- **The lever is early cancellation.** Cancellations more than 60 days before renewal rose from about 8–10 % to 11–12.6 % of renewals in April 2026 and stayed there. The Oct 2026 price increase added only about 1–1.5 points from mid-October, mostly first renewals, with no rise in withdrawals. (17 Nov 2026)
- **Retention emails** (two monthly emails per role plus a win-back after cancellation, Sep–Oct 2026): handover in `../../../pm/projects/b2c-retention-emails.md`. CME matters for Fachärzte, not for Assistenzärzte; say „Fortbildungszeit", never „Lernzeit". Measure with a holdout on cancellation rate, and watch that value reminders do not trigger cancellations among inactive members.

## Acquisition

- **New customers** (Sep–Aug, corrected for free memberships): 6,860 → 6,248 → 5,428 for 23/24 → 24/25 → 25/26; of them new members 2,172 → 1,781 → 1,915. Print is the largest source (40 % → 37 % → 33 %). (Sep 2026)
- **Skipping the June 2025 mailing** cost about 88 new customers (≈ €80k 24-month value) against a mailing cost of €420.6k; break-even would have been about 459 customers. (Sep 2026) Habib's EB project "PA-analysis" (SharePoint EB site) holds recipient matching, CAC and frequency studies: reuse it.
- **Free WebUps are not an acquisition channel:** at most 2.4–7 % of new paying customers had one before buying, and accounts that register for a WebUp buy within 90 days less often (4.0 %) than others (9.6 %). WebUps are sponsoring income and engagement for existing customers. (Oct 2026)
- **Mix:** Refresher-led cohorts bring 67 % of first-year fees. The CME products (On-Demand Accredited and SYFAT) are the only growing entry points: CME-led share of first-year fees 3 % (Aug 2024–Jul 2025 cohorts) → 7 % (Aug 2025–Aug 2026), 18 % in the Jul 2026 cohort. They grow at the expense of generic on-demand, not of Refresher. (Sep 2026)
- **Live courses shift to All Access bookings.** Kardiologie Update Refresher Wien (paid bookings 2023→2026: 92, 125, 118, 109): the All Access share rose 14 % → 32 % → 40 % → 51 %, and non-member ticket revenue fell from €17.5k (2024) to €9.9k (2026). Any revenue share with a partner that is based on tickets alone shrinks as membership grows. SQL in `../oekg/sql/kardio-at-baseline.sql`. (19 Nov 2026)
- **Registration:** 47 % of visitors finish the 3–4 step sign-up (3,470 → 1,635, Jul–Oct 2026); of those who leave on the email screen, a third log in within 24 hours (existing users). Inside the form, step 3 (professional details) loses most. Segment sees only about 45 % of new accounts, and `Baiduspider-render` inflates step counts about 3×. (Oct 2026)

## By product (membership revenue only; stand-alone sales, B2B and non-member buyers are not included)

| Fact (Aug 2024–Jul 2025 → Aug 2025–Aug 2026 cohorts) | SYFAT | On-Demand Accredited |
|---|---|---|
| Share of new B2C members with that likely intent | 2 % → 4 %; 7–9 % in Apr and Jul 2026 | 2 % → 4 %; 9–12 % in Apr, Jul and Aug 2026 |
| Members, first-year fees | 234 · €122k year 1 · €32k year 2 · €523 per member (lowest: more assistant doctors at the €490 price) | 235 · €150k year 1 · €31k year 2 · €636 per member |
| Watched the product within 30 d / 90 d / 12 m of joining | 5 % / 6 % / 9 % | 6 % / 8 % / 13 % |

SYFAT-led members are among the most active: assistant doctors, German, renewing at 51–62 %. Accredited-led is the faster-growing of the two. (21 Sep 2026)

Marie's SYFAT survey concept (Metabase, 2 Nov 2026, staff excluded; her figures, not checked against the definitions above): 1,666 users and 2,127 enrolments; median watch time about 102 minutes; 74 % of SYFAT users are active members, and 34 % of those have submitted a cancellation. Enrolments: AM 934, IM 1,159, Gyn 22, Päd 12.

## Where the detail lives

| Analysis | Folder | Page |
|---|---|---|
| B2C Value Journey: monthly cohorts, definitions (Sep 2026) | `../../archive/b2c-value-journey/` | https://claude.ai/artifact/7pArL6gezoZBfekf436j6a |
| B2C Membership Income, Metabase dashboard 1816 (Sep 2026) | `../../archive/b2c-income-dashboard/` | https://fomf2.metabaseapp.com/dashboard/1816 |
| New customers by source, skipped June mailing (Sep 2026) | `../../archive/acquisition-sources/` | https://claude.ai/artifact/S6Fwroo2vD5tuVgZV2YERr, https://claude.ai/artifact/DLtTuLcoRbHaJZ9kSKfUvf |
| Registration funnel (Oct 2026) | `../../archive/registration-funnel/` | https://claude.ai/artifact/Uk1RMDh5kfkTfEPQBsRqm3 |
| Price-increase cancellations (Sep and Nov 2026) | `../../archive/price-increase-cancellations/` | https://claude.ai/artifact/RJFk9kexEvmyfsfWZD2va6 |

The North Star and WebUp analyses (Oct 2026) were run in session scratchpads; only their conclusions above remain. North Star: CME points come from `platform_raw_contentaccreditationservice.public_participants_summary` (take the `mainAccreditation` amount; the table holds names and EFN, never select them).
