# Data pipeline

How the numbers on the page are produced, end to end. Everything lives in BigQuery project `fomf-dl` (region europe-west3). Read-only access is preapproved by the parent brief.

## Querying

- **Preferred:** `bq query --use_legacy_sql=false --project_id=fomf-dl '<sql>'` when `gcloud auth` is valid.
- **Fallback (used so far, gcloud auth was expired):** `tools/mbq.sh "<sql>"` or `tools/mbq.sh -f file.sql`. It posts the SQL to the Metabase REST API (`/api/dataset`, database 2 = "Bigquery (fomf-dl)") and prints TSV. Needs `METABASE_API_KEY` in `cto-assistant/.env`; never print the key. Metabase caps a result at **2000 rows**, so per-member extracts are fetched in cohort chunks. The Metabase MCP tools cannot run native SQL.

Fully qualify tables as `` `fomf-dl`.dataset.table `` so the SQL runs through either path.

## Regenerating the page data

```
tools/fetch_members.sh      # 8 chunked queries (about 3 cohorts each) → data/cohort_member_rows_all_months.json → data/members_compact.json  (~1 min)
python3 tools/embed.py      # replaces the `const RAW = ...;` line in dashboard.html with members_compact.json
```

Then set `AS_OF` / `AS_OF_LABEL` in `dashboard.html` to the extraction date and publish (see `docs/dashboard.md`). To add a month, extend the end date in `sql/cohort_member_rows_all_months.sql` and the `CHUNKS` list in `fetch_members.sh` (keep each chunk under 2000 rows; cohorts run 150–630 members). If a chunk hits the 2000-row cap, split the cohort list in `fetch_members.sh`.

## Adding a topic (new per-member columns)

1. Add CTEs and output columns to `sql/cohort_member_rows_all_months.sql`. Join everything on `order_id` (one row per member). Keep the `__COHORTS__` placeholder in the WHERE clause.
2. Extend the `jq` compaction in `tools/fetch_members.sh`: append new array positions or new flag bits (next free bit is 8388608; positions 0–36 are taken). Column indexes in the `jq` refer to the SQL SELECT order, so appending columns at the end of the SELECT keeps existing indexes stable.
3. Extend the `ROWS` mapping at the top of the script in `dashboard.html`, and document the new positions in `docs/dashboard.md`.
4. Run the two commands above, take one screenshot, publish.

Per-member exports carry **no identifiers** (no user id, email, name): coarse attributes only (country, membership type, first-time/returning, dates, counts, labels). Every data file states its extraction date.

## SQL files

| File | Purpose | Status |
|---|---|---|
| `sql/cohort_member_rows_all_months.sql` | one row per member, all cohorts: status + renewal checkpoints + likely intent + 30/90/365-day attended-live flags, meaningful-video counts and active periods + automatic-renewal flag + product reach (attended live course / webinar, meaningful videos by brand group) + month-by-month activity masks M1..M12 (v20) + profile segment codes stage / spec (v21, `prof` CTE) + money (v23, CTEs `pay`, `money`: fee1 / fee2 / fee3 membership orders in EUR, ticket cash, credit value by live course / webinar). **The extract behind the page.** Chunks take 1–3 minutes each since v23. | current |
| `sql/check_behaviour_windows.sql` | 30/90-day segment distribution for several minute thresholds and both live definitions (booking vs attendance). v9 sensitivity check. | superseded by v11 definition, kept for reference |
| `sql/check_renewal_by_behaviour.sql` | year-1 renewal per 12-month behaviour category with renewal state (auto / manual / B2B) and status today; semantics check behind the v12 table | current |
| `sql/check_digital_threshold.sql` | candidate digital rules (minutes, meaningful-video counts, completions) per window, v10 → v11 discussion | reference |
| `sql/check_on_demand_watch_depth.sql` | minutes watched in week one by On-demand-led members (threshold question, 20 Sep 2026) | current |
| `sql/cohort_status_all_months.sql` | per-cohort aggregate (members, active, y1/y2 observable and renewed). Quick sanity check without chunking. | current |
| `sql/cohort_base.sql` | single-cohort CTEs `ord → prior → coh` for 2024-08 (change the dates). Start ad-hoc single-cohort queries here. | current |
| `sql/cohort_2024_08_acquisition_rows.sql` | acquisition channel signals per member (parked v3 analysis) | parked |
| `sql/cohort_status_rows_all_months.sql` | status-only per-member extract, superseded by the member rows file | superseded |
| `sql/cohort_2024_08_discovery_rows.sql` | first discovery extract (v1 page) | superseded |

## Data files

| File | Content |
|---|---|
| `data/cohort_member_rows_all_months.json` | raw Metabase result, 7,835 rows (25 cohorts), `cols` + `rows`, extraction date |
| `data/members_compact.json` | the same rows in the array format embedded in the page (contract in `docs/dashboard.md`) |
| `data/cohort_2024_08_acquisition.json`, `data/rows_compact.json` | parked v3 acquisition rows (raw / compact) |

## Tables that matter

| Need | Table |
|---|---|
| Orders, memberships, catalog | `platform_raw_membershipservice.public_membership_order`, `public_user_membership`, `public_membership`, `public_membership_order_item` (promo codes) |
| Course bookings and their revenue | `analysis.fct_course_bookings` (`booking_date`, `start_date_time`, `original_content_type`, `brand_type`, `booking_participation_type`, `total_price_eur`, `membership_credit_effective`; money columns `individual_revenue_eur` = non-member ticket price, `member_cash_eur` = cash a member paid on top of credit, `member_credit_value_eur` = list-price value covered by credit, `booking_total_revenue_eur` = their sum; the analytics team's event revenue tables `fct_course_event_revenue` / `fct_live_course_revenue` aggregate the same columns per event) |
| Membership money | `public_membership_order` (`total_price`, `membership_price`, `addon_items_price` in cents, `currency`, `is_upgrade_order`; renewals are their own PAID orders), `public_membership_order_item` (types MEMBERSHIP, TOP_UP, UPGRADE, PROMO_CODE, LEGAL_PAYMENT_REMINDER_FEE, BOOKING_CONVERSION_DISCOUNT), `public_membership_payment`. `analysis.fct_membership_revenue` is one row per paid user membership (`total_price` in cents), same basis. |
| On-demand watching | `analysis.fct_user_watched_content_events` (per content/media: first/last watch date, minutes, `content_brand`, `original_content_type`) and `analysis.fct_watched_content_events` (daily) |
| Content catalog / brands | `analysis.dim_contents` (`brand_type`, `original_content_type`, titles) |
| Users, account age, occupation, speciality | `analysis.dim_users` (`created_at`, `occupation_type`; specialty in two generations: legacy `speciality_group` (comma-joined names, empty for signups since Nov 2025) and v2 `specialities_v2` / `specialty_v2_name_de_de` (one name per selection, joined by ", "; filled for 98% of members). Use v2 first, legacy as fallback; v2 names differ (Pädiatrie = "Kinder- und Jugendmedizin", Kardiologie = "Innere Medizin und Kardiologie", general practice also "Praktische Ärztin/Praktischer Arzt", "Innere und Allgemeinmedizin (Hausarzt)"). `occupation_type` is filled throughout. |
| Self-reported "how did you hear about us" | `analysis.fct_membership_marketing_sources` (order id → German label; multi-select) |
| Content progress / completion, CME | `analysis.fct_content_progress_by_user`, `analysis.fct_content_certificates` |
| Live stream watching | `analysis.fct_live_schedule_watch_events` |
| Per-term engagement summary (dbt; check definitions before reuse) | `analysis.fct_user_membership_engagement` |
| Existing churn/return models by the analytics team (check before reinventing) | `analysis.v_membership_spells_value_realization`, `v_membership_churn_return_cohort`, `v_user_behavior_pre_event_90d_labeled` |
| Web behaviour (Segment; keyed by `user_id` only after login) | `segment_raw_unify.pages`, `order_completed`, `video_playback_*` (video events start 2024-09-09), `login` |
| Cancellations, pauses | `analysis.dim_user_memberships` (`cancellation_date/reason/type`), `analysis.dim_paused_memberships` |

Brand codes seen in bookings and watches: `REFRESHER`, `UPDATE_REFRESHER`, `FORTBILDUNGSTAGE`, `STUDY_CONFERENCE_UPDATE`, `KFS_SYMPOSION` (live courses); `WUEX`, `WUIF`, `WU660` (WebUp webinars); `SUMMEDUP`, `SKILL`, `EXPERT_LECTURE` (lectures); `WEBOP`, `ONDEMAND_ACCREDITED` (on-demand courses); `SYFAT`, `SPECIALIST_CERTIFICATE` (Facharzt); `SGMO_CURRICULUM`, `PFLEGE_CURRICULUM`; `GUIDELINE` (articles).

## Gotchas

- In Segment `pages` use `context_page_path`; the `path` column is empty. Membership checkout is `/booking/memberships`, **course** booking `/booking/events/{id}`, catalogue `/product`, course pages `/content/…`, on-demand `/mediathek`. Swiss French pages are prefixed `/fr-CH`. Event ids in page paths are numeric legacy ids and do not match the UUID `event_id` in bookings.
- UTM data on orders and pages is sparse (Aug 2024: 55 of 166 members with any external touch). Do not build an attribution argument on it.
- `is_booking_conversion`, `public_membership_order_source_booking`, campaign redemptions and the referral programme are empty for 2024.
- Country-specific labels of the same survey option differ ("Google Suche" vs "Google-Suche"); merge them.
- The legacy `speciality_group` in `dim_users` stops being filled for accounts created from about Nov 2025 (the signup flow moved to the v2 specialty model). A specialty cut that reads only the legacy field shows 35–50% "not stated" in the 2025-11 … 2026-08 cohorts; with the v2 field first it is 25 members in total.
- Accounts migrated to the current platform carry a creation date of Feb 2022, so "account older than 1 year" includes legacy accounts.
- BigQuery: `ARRAY_AGG(DISTINCT … ORDER BY 1)` is not allowed; order by the expression or drop the ORDER BY. A CTE list must not end with a trailing comma when you paste `cohort_base.sql` in front of a SELECT.
- Metabase dashboard 397 ("Platform metrics", tabbed) is off limits for edits; see the parent memory notes.
- `is_upgrade_order` on membership orders is NULL for older rows: always `IFNULL(…, FALSE)`; a bare `NOT is_upgrade_order` silently drops them (cost one wrong extract on 21 Sep 2026).
- An early renewal (`EARLY_RENEWED`) starts its new term on the day it is paid, not at the anniversary, so membership years cannot be bucketed by `started_at`; the extract counts payments in sequence instead (fee1 = joining order, fee2 = next paid order, fee3 = later ones).
- Members pay almost nothing on top of the fee: across all 25 cohorts, cash for tickets after joining is about 1% of membership fees; almost every ticket is covered by membership credit (`member_credit_value_eur` is the list-price value of what the credit bought).
