# Decision log and results

Newest first. Numbers are as of the data date 19 Sep 2026 unless stated (21 Sep 2026 from v20 on).

## 2026-09-21 · v26: revenue charts in one section

Mahyar: "let's bring the charts around revenue together into one section". Overview section 3 is now **Revenue** with two stacked cards: "Revenue by cohort and product" (the v23 stacked bars, unchanged) and "Highest value and retention by profile group" (the value ranking from v25, moved here). The activity ranking stays where it was as its own section, renamed **Who uses the membership most**. The Group-by switch appears in both places and is one shared state (`.bestDimSwitch`), like the window switches. The shared foot was split into a value foot and an activity foot; the cross-reference sentences in the hints now name the other section. Ranking tables capped at 820px so they do not stretch across the full card. No data change.

## 2026-09-21 · v25: who the best members are (two rankings)

Mahyar: "how can we see what profile is our best customer with most activity and highest LTV, highest retention … do we need to extract more data?" Answer given: no new extract; the rows already carry profile (stage, specialty, country, first-time, intent), activity (12-month videos, live, active months), value (fee1 + fee2) and retention (year-1). A first scoring of profile cells showed the criteria diverge: highest value and retention = doctors, Swiss / psychiatry / paediatrics, Refresher-led or no signal, lightly active Live-only; most active = assistant doctors, German, on-demand / SYFAT-led, renewing at 51–62%. He decided: "separate highest LTV & retention / most active".

Built as Overview section 8: one "Group by" switch (specialty · country · likely intent, each × career stage) above two cards, **Highest value and retention** (sorted by € per member years 1 + 2, with year-1 renewal) and **Most active** (sorted by active months of 12, with meaningful videos and attended-live share). Population = 3,916 members with a completed first year and a passed year-1 checkpoint; groups under 80 greyed and unranked. Hints name leader and trailer and the leader's rank in the other table. Numbers and definitions in `docs/definitions.md`, "Who the best members are".

Key readings for the deck: doctors in psychiatry €1,444 · 81% but the least active group (2.5 months, 1.7 videos); assistant doctors in internal medicine the most active (3.8 months, 13.6 videos) at €882 · 56%. On-demand-led doctors are the only group high on both (€1,210 · 79% · 4.6 months, n 341). Swiss doctors' €1,686 is partly CHF pricing.

Data gaps stated to Mahyar and not built: LTV is two-year value (only 236 members have a year-2 checkpoint); profile depth is five coarse dimensions (age band, account age, prior bookings, promo channel, survey answer would be cheap SQL additions); CME points / certificates as a value-realised signal would be the one genuinely new source.

Open thread (pre-existing, not from v25): at phone width the Overview is about 500px wide (something in the Overview has an intrinsic minimum around 460px; the heatmap wrapper itself scrolls). Not investigated further.

## 2026-09-21 · v24: filter chips removed

Mahyar (screenshot of the chip row): "let's get rid of these filters". Country / Online-Hybrid / first-time chips and Reset removed from the sticky bar; the bar keeps the cohort selector and shows the cohort's member count, and is hidden on the Overview. `filtered()` is the identity; the heatmap's Germany · Switzerland · Austria split is unaffected. No data change.

## 2026-09-21 · v23: revenue by product (connect behaviour to economics)

Mahyar pasted "connect behavior to economics. For example: €840k cohort revenue. Then break that into something meaningful" and asked for it "product based, so we know which product generated how much over time". Data check first: members pay almost nothing beyond the membership fee (cash for course tickets after joining is €128k against €7.78M in fees across all cohorts, 1.6%; nearly every ticket is covered by credit), so "which product generated how much" has to be an attribution of the fee. Chosen lens: **the product that brought the member in** (the seven likely-intent classes, already on the page). The other lens, what the fee was used for, is stated in one sentence as list-price credit value (`member_credit_value_eur`, live courses and webinars only; on-demand products carry no list price) and not shown as revenue.

Built: Overview section 3 "Revenue by cohort and product" (25 stacked bars by intent class, switch Year-1 fees / All payments to date) and Cohort section "Revenue and the product that brought it in" (tiles paid to date · year 1 · year 2 · year 3+, table intent × membership year with share bar, hint with ticket cash and credit value). Extract +6 columns (positions 31–36: fee1, fee2, fee3, tix, cvR, cvW; SQL CTEs `pay`, `money`); revenue basis = the "B2C Membership Income" dashboard (PAID B2C orders net of promo codes, CHF × 1.05, revoked excluded). Membership years are counted as payment sequence, not by date, because early renewals start their term on the day they are paid. One member's status flags changed between the two runs today. **Bug caught on the way:** `is_upgrade_order` is NULL on older orders; `NOT is_upgrade_order` dropped most renewals in the first test (fee2 €3k instead of €94k for Aug 2024) — fixed with `IFNULL`. Definitions in `docs/definitions.md`, Money.

| All 25 cohorts, 7,835 members | Members | Year 1 | Year 2 | Year 3+ | Total to date | Share | Year 1 per member |
|---|---|---|---|---|---|---|---|
| Refresher-led | 5,109 | €3.65M | €1.41M | €119k | €5.18M | 67% | €714 |
| On-demand-led | 963 | €618k | €265k | €28k | €912k | 12% | €642 |
| Unknown | 1,048 | €758k | €315k | €33k | €1.11M | 14% | €724 |
| On-demand accredited-led | 235 | €150k | €31k | – | €181k | 2% | €636 |
| SYFAT-led | 234 | €122k | €32k | – | €154k | 2% | €523 |
| Mixed | 144 | €101k | €36k | €1k | €138k | 2% | €700 |
| Webinar-led | 102 | €77k | €28k | €5k | €110k | 1% | €755 |
| All | 7,835 | €5.47M | €2.12M | €186k | €7.78M | 100% | €699 |

Over time: CME-led (accredited + SYFAT) share of first-year fees 3% for the Aug 2024–Jul 2025 cohorts → 7% for Aug 2025–Aug 2026 (0–1% in the 2024 cohorts, 8–13% in Feb–Jun 2026, 18% in Jul 2026, 11% in Aug 2026); Refresher-led 67% → 66%; On-demand-led 13% → 10%. Year-1 fee per member is flat at €640–735 per cohort; SYFAT-led members pay the least (€523: more assistant doctors at the €490 price). Aug 2024 cohort: €272k to date (€117k year 1 · €94k year 2 from 130 members · €61k year 3 from 83), €1,636 per member, Refresher-led 56%; against that the cohort used credit worth €136k at ticket list prices and paid €5.0k in cash for tickets. Also extracted, not shown: ticket cash and credit value per member (`tix`, `cvR`, `cvW`) for a possible "what the fee bought" step.

Published to the live URL on 21 Sep 2026 on Mahyar's explicit go (the first attempts were blocked by the Claude Code auto-mode classifier because the artifact is shared and the change adds financial figures; note for future money steps).

Open: whether he wants the second lens (value used vs fee paid, i.e. credit utilisation by product) as its own section; whether "revenue" should also include the €128k of ticket cash as a Refresher line (it is Refresher/Update Refresher tickets almost entirely); Overview default is year-1 fees (comparable across cohorts), all-payments is one click away.

## 2026-09-21 · v22: cohort matrices show one window behind a switch

Mahyar (with screenshots of the behaviour matrix and product reach): "turn time 30d, 90d, 12 month to tabs like the overview page". Both Cohort-view matrices now render one window, selected with the same 30 days / 90 days / 12 months control the Overview uses; the four switches share one state, so changing it anywhere changes it everywhere. Behaviour hint now names only the selected window's threshold. No data change.

## 2026-09-21 · v21: where the membership is strongest (specialty × career stage)

Mahyar: "adding Segment cuts to answer 'Where is this cohort strongest?' … Specialty × Career stage … the same view by Germany / Switzerland / Austria". Advice given and accepted: pooled on the Overview, not per cohort (a single cohort splits into cells under 20 members); one explicit metric with a switch; country as the existing filter plus a side-by-side split. He asked for the top 5 specialties only.

Built as Overview section 6: heatmap, rows = General practice / Internal medicine / Psychiatry / Paediatrics / Cardiology / Other specialty / Several specialties (+ Not stated only when ≥ 30), columns = Doctor / Assistant doctor (+ All), switches for metric (share of members · active months of 12 · year-1 renewal), cohorts (all 25 · last 12 months) and columns (career stage · stage × country). Cells under 30 members greyed and outside the colour scale; ~1% with another occupation type (psychotherapists, psychologists) in totals only.

**Data finding on the way:** the legacy `speciality_group` field is empty for signups since Nov 2025 (35–50% "not stated" per cohort); the v2 profile fields (`specialty_v2_name_de_de`) carry it for 1,175 of those 1,200 members. Rule now: v2 first, legacy fallback; Innere Medizin listed together with its cardiology subspecialty counts as Cardiology; other combinations across groups are "Several". Not stated: 25 members. Extract +2 coarse code columns (`stage`, `spec`, positions 29–30); the first 29 columns changed for 6 members between the two runs today (status flags moving during the day, as before).

| All 25 cohorts, 7,835 members | Doctor | Assistant doctor | All |
|---|---|---|---|
| General practice | 28% (2,220) · 2.9 months · renewal 76% | 8% (609) · 3.6 · 57% | 36% |
| Internal medicine | 12% (938) · 3.4 · 75% | 6% (433) · 3.8 · 56% | 18% |
| Psychiatry | 7% (543) · 2.5 · 81% | 1% (114) · 3.0 · 60% | 9% |
| Paediatrics | 4% (332) · 2.5 · 77% | 1% (64) · 2.2 · 67% | 5% |
| Cardiology | 3% (232) · 3.5 · 72% | 1% (99) · 4.2 · 53% | 4% |
| Other / several | 19% (1,558) · 2.9 / 3.5 · 73% / 82% | 8% (613) · 3.5 / 3.8 · 53% / 66% | 28% |
| All specialties | 74% (5,829) · 3.0 · 76% | 25% (1,933) · 3.6 · 57% | 100% |

Reading: **career stage separates renewal, specialty does not.** Doctors renew at 76% (72–82% across specialties), assistant doctors at 57% (53–67%), a 19-point gap that holds in every specialty and every country (Germany 74 vs 55, Switzerland 78 vs 59, Austria 77 vs 66). Assistant doctors are the more active group while they are members (3.6 vs 3.0 active months). Acquisition: general practice is the base (36%); Switzerland is the doctor-heavy market (psychiatry 15% and paediatrics 9% of Swiss members vs 6% / 3% in Germany), Germany has the assistant doctors (33% of German members vs 12% in Switzerland, 26% in Austria). The last-12-months view is acquisition-only for now (few completed first years, no checkpoints).

Open: the assistant-doctor renewal gap is the slide-worthy finding; a natural follow-up is whether it is price (they pay the same), a training-end effect, or the B2B route (clinic memberships) that takes them over. Mahyar to confirm the Doctor / Assistant doctor reading of `occupation_type` with Vahid before the deck.

## 2026-09-21 · v20: active month by month (data date 21 Sep 2026)

Mahyar proposed a per-cohort chart, x = months since purchase M1–M12, y = share of the cohort active, "are we becoming part of the doctor's learning routine?" Agreed defaults before building: active = attended live **or** ≥ 1 meaningful video in the month (the complement of Inactive), member-months from the order date (M12 ends at the anniversary), whole cohort as denominator, M1–M12 only. Visualisation: one line (cohort, `--s1`, value on every point, hollow dot when the month is only partly observable), grey all-cohorts line behind it, x labels M1–M12 with the calendar-month pair under each ("Nov–Dec"), y fixed 0–100 %, mode switch Any / Attended live / Watched a video (one line at a time, colour unchanged), tooltip with live / video / both split and the all-cohorts value. Placed between product reach and renewal by behaviour in the Cohort view. Re-extract added `mlive`, `mdig` (12-bit masks) and `mobs`; the data date moved 20 → 21 Sep (94 rows changed in observability / status / 365-day counts, expected). Check: M1 equals the 30-day non-Inactive share exactly (all cohorts 67 %; Aug 2024: 70 of 166 both ways).

| Any activity, all cohorts (observable members) | M1 | M2 | M3 | M4 | M5 | M6 | M7 | M8 | M9 | M10 | M11 | M12 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Active | 67% | 38% | 29% | 23% | 21% | 19% | 18% | 17% | 16% | 15% | 17% | 20% |
| of which attended live | 51% | 26% | 19% | 14% | 12% | 11% | 10% | 11% | 9% | 9% | 10% | 13% |
| of which watched a video | 29% | 17% | 14% | 12% | 11% | 10% | 9% | 8% | 8% | 8% | 8% | 10% |

Reading: after the joining month the cohort settles at roughly one in five active per month, with a small rise towards M11–M12 (13 % live in M12: the second Refresher season and the anniversary). Per cohort the curve is dominated by the Refresher calendar: Aug 2024 peaks in M3–M4 (Oct–Dec, 58 % / 44 %) and ends at 9 % in Jul–Aug; Nov 2024 starts at 89 % (the November course) and drops to 25 % in M2. Of the 4,149 members with a completed first year, the average is 3.1 active months, median 2; 51 % were active in 1–2 months, 33 % in 3–5, 15 % in 6 or more, 2 % in none. The "active months out of 12" distribution is the natural next step if he wants the routine question answered directly.

## 2026-09-20 · v19: noindex

Mahyar is sharing the page: `<meta name="robots" content="noindex, nofollow, noarchive">` added. Note the host wraps the file inside `<body>`, so the tag is not in `<head>`; indexing protection ultimately rests on the artifact's sharing settings.

## 2026-09-20 · v18: trends card removed

Mahyar: "remove the trends and patterns completely for now." Section and `renderTrends()` removed; code parked in `archive/trends_bullets_v17.js`. It returns as board questions with computed answers when he sends them.

## 2026-09-20 · v17: trends card moved to the end of the Overview

Mahyar: "let's take Trends & patterns to the last part. Then I can let you know the questions and you can add the answers." The card now closes the Overview, after the renewal chart; it is where board questions and their computed answers go next. No data change.

## 2026-09-20 · v16: product reach and acquisition → outcome (options 3 and 4), counting fix

Mahyar asked how to reflect the seven product classes in the behaviour analysis; five options were laid out, he asked to see 3 (product reach, non-exclusive) and 4 (acquisition class → 12-month behaviour + renewal). Both built with real data as draft sections: Cohort view "Product reach" matrix (rows = windows, columns = Refresher attended / Webinar attended / Accredited watched / SYFAT watched / Library watched) and "Where each acquisition class ends up" table; Overview "Product reach over time" small multiples sharing the window switch.

Extract: +6 attendance flags by content type, +9 meaningful-video counts by brand group. **Bug fixed on the way:** `mv_n` counted media × watch-days instead of distinct media; effect ≤ 2 points (30 d Hybrid 8 → 7%, 12 m Hybrid 6 → 4%, Live-only 86 → 87%). Numbers in the v11–v15 entries above are the inflated ones.

| Reach, all cohorts | 30 d | 90 d | 12 m |
|---|---|---|---|
| Refresher attended | 46% | 73% | 90% |
| Webinar attended | 10% | 16% | 29% |
| Accredited course watched | 6% | 8% | 13% |
| SYFAT watched | 5% | 6% | 9% |
| Library watched | 23% | 30% | 43% |

## 2026-09-20 · v15: cohort selector in the sticky bar with ‹ › buttons

Mahyar: "bring cohort selection to the sticky header with backward and forward buttons to see the values easily across multiple cohorts." Selector moved from the page header into the sticky filter bar, previous/next buttons (disabled at Aug 2024 / Aug 2026), ← → keys step too; hidden on the Overview. Data date now sits under the view switch. No data change.

## 2026-09-20 · v14: seven acquisition classes

Mahyar, after asking whether On-demand-led includes accredited courses (it did, 12% of first on-demand items; 60% were Refresher recordings) and since when on-demand courses exist (accredited: Jul 2024, uptake Q4 2024; SYFAT watching from Oct 2024): "introduce on-demand-cme-led acquisitions ... also webup led ... refresher and update refresher are the same." New taxonomy: Refresher-led · Webinar-led · On-demand accredited-led · SYFAT-led · On-demand-led (non-CME videos, other content) · Mixed · Unknown. Rule in `docs/definitions.md`; my choices: other live-course formats (5% of live bookings) fold into Refresher-led, accredited is watch-only (enrolments are not bookings), same-day CME beats generic on-demand.

| Class | Aug 2024–Jul 2025 (3,716) | Aug 2025–Aug 2026 (4,119) |
|---|---|---|
| Refresher-led | 66% | 65% |
| Webinar-led | 1% | 1% |
| On-demand accredited-led | 2% | 4% |
| SYFAT-led | 2% | 4% |
| On-demand-led | 14% | 10% |
| Mixed | 2% | 2% |
| Unknown | 13% | 13% |

Reading: the CME products are the only growing entry points, and they grow at the expense of generic on-demand, not of Refresher. Accredited-led is 9–12% in Apr, Jul and Aug 2026; SYFAT-led peaks at 7–9% in Apr and Jul 2026. Page: seven intent tiles, six overview panels, new `--s5` purple token for On-demand-led, trends bullet 2 rewritten. Re-extract: one member's status flags changed during the day.

## 2026-09-20 · v13: Overview extended with trends and patterns

Mahyar: "add visualization and also trends and patterns we see in these 25 cohorts in the overview tab." Overview now has five sections: (1) **Trends and patterns**, six computed sentences (numbers from the data, wording static); (2) **New members per cohort**, bars, Sep–Nov highlighted; (3) acquisition small multiples (unchanged); (4) **Behaviour over time**, five small multiples with a 30 d / 90 d / 12 m switch, hollow dots for partly observable cohorts; (5) **Renewal and status by cohort**, year-1 bars (hatched when the checkpoint is not complete for every one-year member) with active-today dots. `drawMultiples()` generalises the small multiples; `y1Complete()` treats three-year members as not due for the year-1 check (they were making Nov 2024–Jun 2025 look partly observable).

Patterns (all members, 20 Sep 2026): Sep–Nov cohorts average 472 members, Jun–Aug 205; Nov peaks 629 / 552. Live-led intent 67% → 66% year over year; Facharzt-led 2% → 4%. 30-day behaviour mirrors the season: Nov joiners Live-only 68%, Inactive 12%; Jul/Aug joiners Inactive 56%, Digital-only 21%. 12 months: Live-only 86%, Hybrid 6%, Digital-only 2%, Inactive 2%. Year-1 renewal 77% (Aug–Oct 2024) → 65% (Jun–Aug 2025); year 2 complete for Aug 2024 (57%) and Sep 2024 (60% of 65). Year-1 renewal flat across behaviour groups; 85% of renewals automatic. Fix in the same step: the automatic share was mis-summed as 90% in the v12 notes; the page and docs now say 85%.

## 2026-09-20 · v12: renewal by 12-month behaviour

Mahyar: "now renewal", with a mock table (behaviour group · members · renewal rate). Built as a table under the behaviour matrix using the five v11 categories over 12 months and the existing year-1 renewal flag; added one column "of which automatic" after the semantics check. Extract gained `y1_auto` (bit 65536); three members' status flags moved between the two runs today (real changes).

| 12-month behaviour | Members | Renewed year 1 | Rate | Automatic |
|---|---|---|---|---|
| Hybrid | 234 | 170 | 73% | 88% |
| Digital-only | 74 | 55 | 74% | 96% |
| Live-only | 3,341 | 2,399 | 72% | 84% |
| Low/Episodic | 195 | 131 | 67% | 95% |
| Inactive | 62 | 49 | 79% | 98% |
| All | 3,906 | 2,804 | 72% | 85% |

Finding: year-1 renewal is flat across behaviour groups (67–79%), and Inactive renews above average. Checked against the membership semantics: renewal is on by default and 85% of renewals are automatic (48 of 49 among Inactive), so year-1 renewal measures the absence of a cancellation, not engagement. The real behaviour-dependent question is cancellation / year-2 (Aug–Sep 2024 only so far) and "active today"; Aug 2024 cohort: renewal 77%, groups too small (Inactive 1 member). Suggested next step: cancellation-pending and year-2 by group once more cohorts reach it.

## 2026-09-20 · v11: behaviour categories redefined (Mahyar's definition)

Mahyar: "the signal for digital only is too weak. you're only considering 15 minutes of video watches?" Then, after seeing the candidate rules (minutes, meaningful-video counts, completions; whole-content completion is 1–2% and unusable), he supplied a definition table: five mutually exclusive categories, live = **attended** (not booked), digital = **meaningful videos with recurrence**, thresholds scaling with the window (2 videos / 2 days · 8 / 4 weeks · 24 / 6 months), meaningful video = ≥ 50% watched with a minimum duration. Implemented as specified; my choices: minimum video duration 5 min, livestream ≥ 10 min as second attendance evidence, active periods counted on days with playback of a meaningful video, Low/Episodic requires ≥ 1 meaningful video (anything less is Inactive). Details in `docs/definitions.md`.

| Window | Observable | Inactive | Low/Episodic | Live-only | Digital-only | Hybrid |
|---|---|---|---|---|---|---|
| First 30 days | 7,763 | 33% | 4% | 43% | 12% | 8% |
| First 90 days | 7,428 | 11% | 7% | 71% | 5% | 6% |
| First 12 months | 4,137 | 2% | 5% | 86% | 2% | 6% |
| Aug 2024, 30 d / 90 d / 12 m | 166 | 58 / 13 / 1 | 9 / 10 / 7 | 12 / 66 / 85 | 17 / 4 / 1 | 4 / 7 / 7 |

Reading: with attendance instead of booking, a third of members have done nothing in their first 30 days (their course is still ahead); by 90 days 77% have sat in a live course. The digital bar is high: 8% reach it over 12 months (24 videos in 6 months), so Digital-only shrinks to 2% and Hybrid to 6% at 12 months; 86% are Live-only, which includes members with up to 23 meaningful videos. Nov cohorts (Refresher season) are the most live-heavy at 30 days (Live-only 66–70%), Jul/Aug cohorts the most inactive (53–58%). The re-extract left the earlier columns identical except one member whose status flags changed between the two runs today (a renewal landed).

## 2026-09-20 · v10: 12-month window added to the behaviour section

Mahyar: "now let's add the 12 month". Same segments over 365 days (the whole first membership year). Three cards side by side were too cramped (labels wrapped, bar text tiny), so the section became one card with a matrix: rows = windows, columns = segments, bar under each row; shares are comparable down a column. Extract extended by three columns; earlier columns identical except two members whose 30/90-day minutes moved by one minute (float summation order).

| Window | Observable | Live only | Digital only | Hybrid | Low/inactive |
|---|---|---|---|---|---|
| First 30 days | 7,763 | 66% | 9% | 13% | 12% |
| First 90 days | 7,428 | 65% | 9% | 20% | 6% |
| First 12 months | 4,137 (cohorts to Aug 2025, Sep 2025 partial) | 57% | 6% | 34% | 2% |
| Aug 2024, 12 months | 166 | 51% | 8% | 40% | 2% |

Reading: over a full year almost nobody stays inactive (2%), and a third become hybrid; digital-only stays a small niche (6%). Live only falls from 66% to 57% as course bookers pick up the media library. Per cohort 12-month Live only ranges 50–64%, Hybrid 28–40%.

## 2026-09-20 · v9: first 30 and 90 days (behaviour segments)

Mahyar: "add first 30 and 90 day behaviour" with the shape Live only / Digital only / Hybrid / Low/inactive. Built as one section in the Cohort view, two cards (30 and 90 days), four tiles + 100% bar each. Definition (new, in `docs/definitions.md`): live = booked or attended a live course/webinar in the window; digital = ≥ 15 min of media-library watching in the window (threshold `MIN_DIGITAL_MIN` on the page, not in the data); shares of members whose window has elapsed. Re-extract added six columns; the old columns came back identical.

| Window | Observable | Live only | Digital only | Hybrid | Low/inactive |
|---|---|---|---|---|---|
| First 30 days | 7,763 of 7,835 | 66% | 9% | 13% | 12% |
| First 90 days | 7,428 of 7,835 | 65% | 9% | 20% | 6% |
| Aug 2024, 30 d | 166 | 57% | 13% | 10% | 20% |
| Aug 2024, 90 d | 166 | 60% | 11% | 22% | 7% |

Reading: two thirds only book courses in their first quarter; the media library is a secondary channel (digital in any form 22% at 30 days, 29% at 90 days). Between day 30 and day 90 Low/inactive halves and Hybrid grows, i.e. course bookers start watching. Per cohort the picture is stable (Live only 55–73% at 30 days), Jul cohorts are the digital-heavy outliers (Jul 2026: Live only 48%, Digital only 18%, Low 22%). Threshold sensitivity is in `docs/definitions.md`; Mahyar has not confirmed 15 minutes yet. Live via attendance adds under 1 point over booking alone. 90 days not yet observable for Jul/Aug 2026, partial for Jun 2026; 30 days partial for Aug 2026 (130 of 202).

## 2026-09-20 · v8: Overview view with acquisition shares over time

Mahyar asked for an overview page with one thing: acquisition shares over time, Aug 2024 – Aug 2026, and wanted to discuss the visualisation first. Options weighed: stacked 100% bars (composition, poor for trends), five lines on one axis (Facharzt flat), small multiples with own scales (chosen), year-over-year overlay (kept as a possible toggle for the seasonality argument). He chose small multiples; Mixed gets no panel.

Built as a second view in the same artifact (Overview / Cohort switch), not a second artifact. Result, all members, weighted:

| Intent | Aug 2024–Jul 2025 (3,716) | Aug 2025–Aug 2026 (4,119) |
|---|---|---|
| Live-led | 67% | 66% |
| On-demand-led | 15% | 14% |
| Facharzt-led | 2% | 4% |
| Mixed | 2% | 2% |
| Unknown | 13% | 13% |

Reading: the mix is stable; the only trend is Facharzt-led (near 0% in 2024, 3–10% in 2026, peak Jul 2026). Live-led dips and On-demand-led rises every Jul/Aug. Open check before this goes into a deck: whether the Facharzt-led growth is product uptake or a change in how content got the SYFAT / SPECIALIST_CERTIFICATE brand.

## 2026-09-20 · v7: cohorts extended to Aug 2026, data date 20 Sep 2026

Mahyar: "add cohorts up to August 2026 ... we can see the impact of our recent features and products on acquisition and activation." SQL end date moved to 2026-08-31, `fetch_members.sh` now runs 8 chunks; 25 cohorts, 7,835 members. The 13 old cohorts came back byte-identical. Cohorts from Sep 2025 on show "none yet" for renewal data and hatched checkpoints; Sep 2025 is the first with a partial year-1 checkpoint.

| Cohort | Members | Live / On-demand / Facharzt / Mixed / Unknown |
|---|---|---|
| Sep 2025 | 404 | 73 / 10 / 4 / 1 / 12 |
| Oct 2025 | 415 | 71 / 11 / 2 / 3 / 13 |
| Nov 2025 | 552 | 75 / 11 / 2 / 3 / 9 |
| Dec 2025 | 309 | 61 / 18 / 4 / 2 / 16 |
| Jan 2026 | 421 | 69 / 15 / 3 / 2 / 11 |
| Feb 2026 | 252 | 69 / 13 / 3 / 3 / 12 |
| Mar 2026 | 282 | 66 / 11 / 7 / 1 / 15 |
| Apr 2026 | 276 | 55 / 17 / 7 / 3 / 18 |
| May 2026 | 350 | 60 / 15 / 5 / 2 / 18 |
| Jun 2026 | 323 | 71 / 14 / 4 / 1 / 11 |
| Jul 2026 | 154 | 51 / 23 / 10 / 2 / 14 |
| Aug 2026 | 202 | 62 / 20 / 3 / 1 / 13 |

Facharzt-led has grown from ~0% (2024) to 3–10% in 2026. Also: age tile says "1 month" not "1 months"; all visible dates now come from `AS_OF_LABEL`.

## 2026-09-20 · question: does On-demand-led require a minimum watch length?

No. The rule uses `first_watch_date` only; opening a video for a few seconds counts. Checked with `sql/check_on_demand_watch_depth.sql` (daily `fct_watched_content_events`, `diff_seconds` summed over the 7-day window; `seconds` is the playhead position, not time watched, so it is not used):

| Minutes watched in week one | All cohorts (609 On-demand-led) | Aug 2024 (39) |
|---|---|---|
| under 1 | 184 (30%) | 14 |
| 1–5 | 64 (11%) | 3 |
| 5–15 | 70 (11%) | 3 |
| 15–60 | 153 (25%) | 9 |
| 60+ | 138 (23%) | 10 |

Median 12 min, mean 42 min; 396 (65%) completed at least one video. A 5-minute threshold would move ~41% of On-demand-led to Unknown (On-demand-led ~16% → ~9% of all members, Unknown ~14% → ~20%). Not changed; Mahyar to decide.

## 2026-09-20 · v6.1: definitions on hover for the intent tiles

Mahyar: "on the hover please add the definition so it is easy to understand." Each of the five intent tiles (and the matching segment of the 100% bar) now shows a one-paragraph plain-language definition in the existing tooltip, plus "Read from the first 7 days after the order." Definitions live in the `INTENTS` array (fourth element); the tiles get `cursor:help`. No data or numbers changed.

## 2026-09-20 · docs split, pipeline scripts added

AGENTS.md reduced to an entry point; details moved to `docs/definitions.md`, `docs/data-pipeline.md`, `docs/dashboard.md`, `docs/log.md`. `tools/fetch_members.sh` and `tools/embed.py` added and run once end to end: the re-extract matched the embedded data exactly. Page unchanged (v6).

## 2026-09-20 · v6: likely-intent section added

Mahyar asked for an acquisition section "what seems to have brought them in — live course, on-demand, Facharztkurs, campaign" and then specified the exact shape: five shares, Live-led / On-demand-led / Facharzt-led / Mixed / Unknown. Campaign was dropped from the taxonomy at that point. Rules in `docs/definitions.md`.

| Intent | All cohorts (3,895) | Aug 2024 (166) |
|---|---|---|
| Live-led | 67% | 58% (96) |
| On-demand-led | 16% | 23% (39) |
| Facharzt-led | 2% | 0% |
| Mixed | 2% | 1% (2) |
| Unknown | 14% | 17% (29) |

Of the 96 live-led members in Aug 2024, 88 booked their course within an hour of buying. He asked what On-demand-led means; answer given: "started by watching, no course booked in week one" (it cannot separate media-library buyers from live-course buyers whose course is months away). Possible follow-up he may pick up: what the on-demand-led members did in 90 days.

## 2026-09-20 · v5: all-cohorts table removed (his request).

## 2026-09-19 · v4: page reset to cohort basics

"Simplify. Start with how many members the cohort has and how old it is; whether it is active or not depending on the availability of renewal data. Remove the rest so we can build step by step." Page rebuilt for all 13 cohorts.

| Cohort | Members | Year-1 renewal | Year-2 renewal | Active today |
|---|---|---|---|---|
| Aug 2024 | 166 | 77% (128) | 57% (94) | 56% (93; 5 cancellation pending) |
| Sep 2024 | 376 | 78% | 68% of the 53 observable | 68% |
| Oct 2024 – Aug 2025 | 173–629 | 62–78% | not yet observable | 62–78% |

Year-1 renewal across all cohorts: 62–78%. A wrong first attempt used `initial_expires_at` for the planned expiry and produced 2023 dates for a 2024 cohort; replaced by start + catalog cycle (see definitions).

## 2026-09-19 · v3: acquisition-only page with channel labels and confidence

Mahyar: "focus on acquisitions; look at their first immediate action and label them with confidence." Built rules-based labels (hard > observed > stated evidence). Result and rules preserved in `docs/definitions.md` (parked section) and `archive/dashboard_v3_acquisition.html`. Headline: the membership is sold by the course catalogue, not by membership marketing; 51% booked a course within 10 minutes of buying.

He then asked for the slide summary table and the presentation caveats to be on the page itself (done in v3.1), before resetting to v4.

## 2026-09-19 · v1/v2: discovery page for cohort 2024-08 (full value-journey framing)

Original ask: a value journey (discovery → first behaviour → ongoing pattern → renewal) for B2C cohorts Aug 2024–Aug 2025, starting with discovery for Aug 2024. Findings still valid:

- 485 paid B2C orders in Aug 2024 → 279 renewals, 166 new members (149 first-time, 17 returning), 31 revoked, 9 admin-granted.
- €117k first-year membership cash, avg €704 per member.
- 52% had booked a course before (€76k prior course spend); 59% had booked or watched before.
- Of members with a tracked session in the 24 h before buying, 64% were in the course booking flow or catalogue.
- Self-reported source (multi-select, all answered): colleague recommendation 35, email/newsletter 31, search 30, FOMF website 26, post flyer 23, journal insert/ad 18, former participant 16, social 7, clinic poster 3.
- 10 promo codes (PA/BL/INS/MS prefixes). 61% booked a course within 7 days of joining.
- Cohort sizes: Aug 24 166 · Sep 376 · Oct 453 · Nov 629 · Dec 260 · Jan 25 385 · Feb 238 · Mar 284 · Apr 237 · May 276 · Jun 239 · Jul 173 · Aug 25 179.

## Open threads Mahyar has named (not yet asked for)

Check the Facharzt-led trend against content publication/brand-tagging dates before presenting it. Possible year-over-year overlay toggle on the overview. First behaviour, 90-day pattern, active learning months, renewal detail. Possibly: what On-demand-led members did in 90 days; whether the acquisition channel labels come back as a section.
