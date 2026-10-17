# Definitions

Agreed definitions for the B2C Value Journey. Do not change any of these without Mahyar; if he changes one, update this file and the Definitions block inside `dashboard.html` in the same commit.

## Cohort

A member belongs to cohort `YYYY-MM` when

- the membership order (`platform_raw_membershipservice.public_membership_order`) has `status = 'PAID'`, no `group_membership_id` and no `clinic_membership_id` (that is what B2C means here), and `DATE(created_at, 'Europe/Berlin')` falls in the month, **and**
- the resulting user membership (`public_user_membership`, joined via `created_from_membership_order_id`) has `state = 'NEWLY_CREATED'`.

Why the second condition: every renewal creates its **own** order row and user-membership row (states `AUTOMATICALLY_RENEWED`, `EARLY_RENEWED`, `PAID_MANUALLY_AUTOMATICALLY_RENEWED`, `MANUALLY_RENEWED`). Counting paid orders alone triples the cohort: August 2024 had 485 paid B2C orders but 166 new members. `REVOKED` (withdrawn within the withdrawal period) and `OFFERED_BY_ADMIN` (zero-price grants) are also excluded.

Cohorts in scope: August 2024 through August 2025, 13 months, 3,895 members. Every cohort has completed at least one full membership year.

**First-time vs returning:** returning = the user had any earlier `public_user_membership` row (B2C, group or clinic) before the order. Aug 2024: 149 first-time, 17 returning.

**Cohort age:** full months from the first day of the joining month to the data date (Aug 2024 on 19 Sep 2026 = 25 months).

## Planned expiry

`started_at` + catalog cycle from `public_membership.cycle`: 365 days for `ONE_YEAR`, 1096 for `THREE_YEARS`, 427 for `FOURTEEN_MONTHS`, 183 for `SIX_MONTHS`, 92 for `THREE_MONTHS`, 31 for `ONE_MONTH`. Almost all B2C memberships are one year; a few three-year terms appear from late 2024.

Two raw fields look usable and are not: `initial_expires_at` carries stale dates for returning members (values in 2023 for a 2024 cohort), and `expires_at` is shortened when a member renews early. Neither is used for renewal checks.

## Valid membership, active today, renewed

A user membership is **valid** when its state is not `REVOKED` and not `NOT_PAID`. `PAUSED` is valid. Group (B2B) and clinic memberships are valid.

A member is **covered** on day *t* when any valid membership of theirs has `started_at <= t < expires_at`.

- **Active today** = covered on the data date. **Active via B2B** = the covering membership is a group or clinic membership. **Cancellation pending** = the covering B2C membership has `renewal_status = 'CANCELED'` (it will lapse at term end).
- **Year-1 renewed** = covered on planned expiry + 14 days. **Year-2 renewed** = covered on planned expiry + 379 days. The 14-day grace absorbs payment delays. Early renewals count because the new term covers the check day; a move into a B2B group membership counts as covered.
- A checkpoint is **observable** for a member only when its check day is on or before the data date. The page shows "n of N observable" and hatches the bar when not all members have reached it.

## Likely intent (acquisition section)

Seven classes, defined by Mahyar on 20 Sep 2026 (v14; replaces the five-class Live / On-demand / Facharzt / Mixed / Unknown rule). Read from the first 7 days after the order (`sql/cohort_member_rows_all_months.sql`, CTEs `w7`, `b7`, `sig`, `intent`).

Signals:

- **Refresher** = booked a ticket (any participation type) for content with `original_content_type = LIVE_COURSE`, booking not cancelled (`analysis.fct_course_bookings`). Brands REFRESHER and UPDATE_REFRESHER are 95% of these; the other live formats (FORTBILDUNGSTAGE, STUDY_CONFERENCE_UPDATE, KFS_SYMPOSION, SGMO_CURRICULUM) are folded in.
- **Webinar** = booked a WEBINAR ticket (WebUp brands WUEX, WUIF, WU660).
- **On-demand accredited** = first watched content with `content_brand = ONDEMAND_ACCREDITED` (`analysis.fct_user_watched_content_events`, `first_watch_date` in the window). Enrolments in on-demand courses do not create booking rows, so watching is the only signal.
- **SYFAT** = first watched content with brand `SYFAT` or `SPECIALIST_CERTIFICATE`.
- **On-demand** = first watched any other content: course recordings (Refresher, Update Refresher, Fortbildungstage), SummedUp, Skill, WebOp, PJ training, webinar recordings, deleted content without brand.

Label:

| Situation | Label |
|---|---|
| no signal in 7 days | Unknown |
| exactly one signal type | that type |
| several signals, a live booking (Refresher or webinar) within 60 minutes of the order | that booking (the earliest if both) |
| several signals, otherwise | earliest signal day wins (bookings by minute, watches by day); on the same day a CME product (accredited, SYFAT) beats generic on-demand |
| several signals, tie left on the first day | Mixed |

Result (20 Sep 2026): Aug 2024–Jul 2025 (3,716) Refresher-led 66 · Webinar-led 1 · Accredited-led 2 · SYFAT-led 2 · On-demand-led 14 · Mixed 2 · Unknown 13%; Aug 2025–Aug 2026 (4,119) 65 · 1 · 4 · 4 · 10 · 2 · 13%. Accredited-led reaches 9–12% in Apr, Jul and Aug 2026. Compact codes: R W A S O M U.

Known limits: On-demand-led means "started by watching a non-CME video, no booking in week one"; 60% of those first watches are Refresher / Update Refresher recordings, so the class is largely the live product consumed as recording. Both CME products launched in mid-2024 (accredited: first content Jul 2024, uptake from Q4 2024; SYFAT watching from Oct 2024, content re-tagged in 2025), so the 2024 cohorts could not have been CME-led. Historical five-class results (Live-led 67% / On-demand-led 16% / Facharzt-led 2% / Mixed 2% / Unknown 14%) are in `docs/log.md`, v6–v8.

## First 30 / 90 days / 12 months (behaviour categories)

Definition given by Mahyar on 20 Sep 2026 (v11; replaces the v9/v10 "15 minutes" rule, which he judged too weak). Five mutually exclusive categories per window, read from the 30, 90 and 365 days after the order (`sql/cohort_member_rows_all_months.sql`, CTEs `tk`, `ls`, `pm`, `mv`, `fw`).

- **Attended live** (per window) = held a non-cancelled ticket for a live course or webinar (`fct_course_bookings`, LIVE_COURSE/WEBINAR) whose `start_date_time` falls in the window, **or** watched a livestream for ≥ 10 minutes in the window (`fct_live_schedule_watch_events`, `watched_mins`). A booking for a course outside the window does **not** count (that was the v9/v10 rule). The two sources overlap; the livestream source adds about 3% of members at 30 days.
- **Meaningful video** = a media-library video (`fct_watched_content_events`, any brand incl. Facharzt) with `media_duration` ≥ 300 s of which the member watched ≥ 50% within the window (sum of `diff_seconds > 0`) or which is flagged `completed`. Playback on a live event's own days is excluded (livestream). Videos under 5 minutes are 2% of what members watch.
- **Active periods** = distinct days (30 d) / ISO weeks (90 d) / calendar months (365 d) with playback on a meaningful video.
- **Counting fix (v16, 20 Sep 2026):** v11–v15 counted a meaningful video once per watch day (a video watched over three days counted three). Since v16 `COUNT(DISTINCT media_id)`. Effect ≤ 2 points on any category (30 d Hybrid 8 → 7%, 12 m Hybrid 6 → 4%, Live-only 86 → 87%).
- **Digital threshold**: 30 d = ≥ 2 meaningful videos on ≥ 2 days · 90 d = ≥ 8 across ≥ 4 weeks · 12 m = ≥ 24 across ≥ 6 months (`THRESH` in the page script; counts are in the data, the thresholds are applied on the page).
- Categories: **Hybrid** = attended live and meets the threshold · **Live-only** = attended live, below the threshold (a member with 20 videos and one course is Live-only) · **Digital-only** = threshold met, no live attendance · **Low/Episodic** = ≥ 1 meaningful video, below the threshold, no live attendance · **Inactive** = no live attendance and no meaningful video.
- **Observable** = order date + 30 (90, 365) days ≤ data date; shares are of observable members only.

Result (all cohorts, observable members, 20 Sep 2026): 30 d Inactive 33 / Low 4 / Live-only 43 / Digital-only 12 / Hybrid 8 · 90 d 11 / 7 / 71 / 5 / 6 · 12 m 2 / 5 / 86 / 2 / 6. The 12-month digital bar (24 videos in 6 months) is reached by 8% of members. Sensitivity of the earlier minute/video-count rules is in `sql/check_digital_threshold.sql` and `sql/check_behaviour_windows.sql`.

## Product reach (v16, 20 Sep 2026)

Share of observable members who used a product family within the window; **not mutually exclusive**. Columns `attR/attW` (attended a LIVE_COURSE / a WEBINAR, same attendance rule as above, split by `original_content_type` on tickets and livestream events) and `mva/mvs/mvo` (meaningful videos whose brand is ONDEMAND_ACCREDITED / SYFAT+SPECIALIST_CERTIFICATE / everything else; they sum to `mv`). Reach = attended, or ≥ 1 meaningful video of the group.

Result (all cohorts, 20 Sep 2026), 30 d / 90 d / 12 m: Refresher 46 / 73 / 90% · Webinar 10 / 16 / 29% · Accredited 6 / 8 / 13% · SYFAT 5 / 6 / 9% · Library 23 / 30 / 43%.

## Where each acquisition class ends up (v16)

Members with a completed first year, grouped by likely intent (seven classes), shown with their 12-month behaviour category distribution and their year-1 renewal rate. Pure recombination of existing fields; no new definition.

## Renewal by 12-month behaviour (v12, 20 Sep 2026)

Year-1 renewal (as defined above) per 12-month behaviour category, for members with `obs365` and `y1_observable`. **Automatic renewal** = the membership covering the year-1 check day has state `AUTOMATICALLY_RENEWED` or `PAID_MANUALLY_AUTOMATICALLY_RENEWED` (`per.y1_auto`); the alternatives are `EARLY_RENEWED` / `MANUALLY_RENEWED` or a group (B2B) membership. Renewal is switched on by default in the membership service, so a year-1 renewal is the absence of a cancellation, not an action.

Result (all cohorts, 3,906 eligible members): Hybrid 73% (234) · Digital-only 74% (74) · Live-only 72% (3,341) · Low/Episodic 67% (195) · Inactive 79% (62); all 72%. 85% of renewals were automatic (2,390 of 2,804; Inactive: 48 of 49). Behaviour in year one does not predict year-1 renewal; check `sql/check_renewal_by_behaviour.sql`.

## Who the best members are (v25, 21 Sep 2026)

Mahyar's question (21 Sep 2026): "what profile is our best customer with most activity and highest LTV, highest retention". The first cut showed the three criteria pull apart, so he decided to **separate** them into two rankings. Pure recombination of existing fields; no new definition and no new extract.

- **Population** = members whose first year has elapsed and whose year-1 checkpoint has passed (`o365 && y1o`): 3,916, cohorts Aug 2024 – Aug 2025.
- **Profile groups** = career stage × one of specialty (7 codes, Not stated left out), country, likely intent (Mixed left out). Ranked when ≥ 80 members; 20–79 listed greyed; under 20 hidden.
- **Value** = `fee1 + fee2` per member: the year-1 fee plus the first renewal fee (0 when the member did not renew). It is a two-year value, not lifetime (only 236 members have a year-2 checkpoint), and it already contains retention. CHF prices lift Swiss groups (about €570 vs €490 a year).
- **Retention** = year-1 renewal as defined above.
- **Activity** = active months of 12 (`bits(ml | md)`, the month-by-month rule), meaningful videos in 12 months (`v365`), share who attended live in 12 months (`l365`).

Result (specialty grouping): value and retention lead = doctors in psychiatry (€1,444 · 81%, n 280), paediatrics (€1,439 · 77%), general practice (€1,336 · 76%); trail = assistant doctors in other specialties (€810 · 53%). Activity lead = assistant doctors in internal medicine (3.8 active months · 13.6 videos · 85% live), trail = doctors in psychiatry (2.5 months · 1.7 videos · 97% live). The value leader ranks last of 11 on activity; the activity leader ranks 10 of 11 on value. Country: doctors in Switzerland €1,686 · 78% vs assistant doctors in Germany €786 · 55% (most active: 3.7 months, 14.8 videos). Intent: doctors with no week-one signal €1,356 · 79%, Refresher-led doctors €1,302 · 76%, On-demand-led doctors €1,210 · 79% and 4.6 active months (the one group strong on both); On-demand-led assistant doctors most active (4.9 months, 21 videos, 60% live) at €899 · 61%.

## Money

Order totals are in cents. CHF converted to EUR at a fixed 1.05, the same rate the analytics models use. Discounts are `PROMO_CODE` line items in `public_membership_order_item`; the code prefix encodes the channel (PA = Postaussendung, BL = Beilage, INS = Inserat, MS = Messe/Stand).

### Revenue by product (v23, 21 Sep 2026)

Built for "connect behaviour to economics … product-based, which product generated how much over time" (Mahyar, 21 Sep 2026). Basis = the "B2C Membership Income" dashboard's: PAID B2C membership orders (no group / clinic membership), `total_price` net of promo codes, EUR with CHF × 1.05, cash basis by order, excluding orders whose resulting membership is REVOKED (withdrawn) or NOT_PAID. Per member (`sql/cohort_member_rows_all_months.sql`, CTEs `pay`, `money`):

- **Year 1 (`fee1`)** = the cohort order (+ any upgrade order of the same user, which carries only the upgrade delta). A three-year term (€1,350–1,650, a few dozen members from late 2024) is paid upfront and sits entirely in year 1.
- **Year 2 (`fee2`)** = the member's **second** paid B2C membership order after the cohort order: automatic, manual or early renewal, or a re-join after a lapse. **Year 3+ (`fee3`)** = every later order. Payments are counted in sequence, not by date, because an early renewal starts its new term on the day it is paid (28–364 days after joining) and would otherwise land in year 1.
- **Attribution to a product** = the member's likely intent in week one (the seven classes above). The membership fee is one price whatever the member uses, so "Refresher-led revenue" means fees paid by members whom the Refresher brought in; it is not a price allocation. The alternative lens, what the fee was used for, is available from `cvR` / `cvW` (list-price value of live-course / webinar tickets covered by credit) and is shown as one sentence, not as revenue: on-demand products have no list price, so a usage-based split would cover only the live products.
- **Ticket cash (`tix`)** = `member_cash_eur` (cash on top of credit) + `individual_revenue_eur` (tickets bought while not a member, i.e. after a lapse) on non-cancelled bookings after the cohort order. About 1% of fees across all cohorts; shown in the hint, not added to revenue.
- Not included anywhere: B2B (group / clinic) membership orders, zero-price grants (`OFFERED_BY_ADMIN`), payment-reminder fees, and anything the member paid before joining (prior course bookings were 52% of Aug 2024 members, €76k; see the v1 discovery findings in `docs/log.md`).

Check (Aug 2024, 166 members): year 1 €116,782 (matches the €117k first-year cash from v1), year 2 €94,159 from 130 members, year 3+ €60,713 from 83; the sum of later payments equals the €155k of valid later orders found independently by state and start date.

## Parked: acquisition channel labels with confidence (v3, 19 Sep 2026)

Built for cohort 2024-08, removed from the page when Mahyar reset it to cohort basics. Preserved in `archive/dashboard_v3_acquisition.html` (rules in its `RULES` array), `sql/cohort_2024_08_acquisition_rows.sql`, `data/cohort_2024_08_acquisition.json`.

One label per member, rules top to bottom, first match wins. Evidence hierarchy: hard (promo code) > observed (bookings, page views, campaign-tagged clicks) > stated (checkout survey "Wie haben Sie von FOMF erfahren?", multi-select, answered on all Aug 2024 orders).

| Label | Main evidence | Confidence |
|---|---|---|
| Print campaign | promo code with PA/BL/INS/MS prefix | High; stated print only → Medium (account ≤30 d old) / Low |
| Course checkout | first course booking ≤10 min after the order, or course pages in the 24 h before + booking ≤1 h | High; booking ≤24 h, or course pages + booking ≤7 d → Medium; course pages only → Low |
| Email / newsletter | HubSpot-tagged click in the 90 d before (+ stated → High) | Medium; stated only → Medium/Low by account age |
| Search | organic search referrer in the 90 d before (+ stated, or account ≤7 d → High) | Medium; stated only → Medium/Low |
| Word of mouth, Social media | stated only | Medium (new account) / Low |
| Media library | watched on-demand around the purchase, no booking | Medium / Low |
| Existing relationship | prior bookings or watching, no other signal | Medium / Low |
| Unknown | nothing | Low |

Aug 2024 result: Course checkout 113 (68%, 80 High), Print 19 (10 High via codes), Search 10, Word of mouth 8, Email 6, Existing 4, Social 3, Media library 3. 84 members (51%) booked a course within 10 minutes of buying; 75% of first-week bookings were livestream tickets for courses a median 74 days ahead, 96% paid with membership credit. Caveats: outbound labels rest mostly on the survey; tagged web traffic covers about a third of members; 25 members browsed courses but did not book within a week.

## Active month by month (v20, 21 Sep 2026)

Member-months from the order date: M_k = [order date + (k−1) months, order date + k months), so M12 ends at the first anniversary. A member is **active in M_k** when they **attended live** in it (ticket for a live course or webinar whose start falls in the month and was booked before the month ended, or ≥ 10 minutes of livestream in the month; same sources as the window rule) **or watched ≥ 1 meaningful video** in it (media-library video ≥ 5 min of which ≥ 50% was watched within that month, or completed in it; livestream days excluded as in `pm`). A month is **observable** only once it has fully elapsed on the data date; shares are of observable members, and the page draws a hollow dot when not every member of the cohort has completed the month.

Differences to the window figures: M1 is the first calendar-offset month (28–31 days), not the 30-day window; the ≥ 50% test is applied within a single month, so a video watched across two months can be meaningful for a window but for no month. The chart's "Attended live" / "Watched a video" modes use the two masks separately; "Any activity" is their union. Extract columns `mlive`, `mdig` (12-bit masks) and `mobs` (`sql/cohort_member_rows_all_months.sql`, CTEs `mb`, `ml`, `md`, `mm`).
