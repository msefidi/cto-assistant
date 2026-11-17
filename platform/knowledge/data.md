# Platform: where the data lives

- **BigQuery** project `fomf-dl` (region europe-west3), read-only preapproved: `bq query --use_legacy_sql=false --project_id=fomf-dl`. Fully qualify tables as `` `fomf-dl`.dataset.table ``.
- **When `gcloud` auth has expired:** `../../archive/b2c-value-journey/tools/mbq.sh "<sql>"` queries through the Metabase REST API (2,000-row cap; needs `METABASE_API_KEY` in `cto-assistant/.env`, never print it).
- **Table inventory, brand codes and gotchas:** `../../archive/b2c-value-journey/docs/data-pipeline.md`.

## Most used tables

| Table | What |
|---|---|
| `analysis.dim_contents` | Catalogue, titles, brands (`brand_type`: e.g. `SYFAT`, `SPECIALIST_CERTIFICATE`, `ONDEMAND_ACCREDITED`) |
| `analysis.fct_user_watched_content_events` | Who watched what, minutes, `content_brand` |
| `analysis.fct_content_progress_by_user`, `analysis.fct_content_certificates` | Completion, CME points |
| `analysis.dim_users` | Occupation, specialty v2, country |
| `analysis.fct_course_bookings`, `analysis.fct_course_booking_marketing_sources` | Bookings and the booking survey |
| `analysis.fct_membership_marketing_sources` | Membership checkout survey (multi-select, use 1/k weights; 39–42 % unanswered) |
| `platform_raw_membershipservice.*` | Membership orders; `public_membership_cancellation_request` for cancellations and withdrawals |
| `platform_raw_contentaccreditationservice.public_participants_summary` | CME points per participant (holds names and EFN: never select them) |
| `segment_raw_unify.*` | Web behaviour (on-demand pages under `/mediathek`) |

Raw datasets (`platform_raw_*`) are not synced into Metabase's data model, so anything on them is a native SQL question; see the memory note on Metabase native cards.

## Metabase

https://fomf2.metabaseapp.com. Database 2 = "Bigquery (fomf-dl)". Executive Board collection 201.

- **Dashboard 1816 "B2C Membership Income"** (EB, Sep 2026): cards 7855 active members, 7856 by country and type, 7857 members over time (dbt series `fct_active_memberships_daily_unpivoted`, 1st of month), 7889 ARR by country, 7888 cash revenue by country (PAID, B2C, net of REVOKED, CHF × 1.05). Extend it rather than adding dashboards. Its daily series is about 0.1 % above the daily report; revenue is cash-basis and seasonal (Oct–Nov renewal peak, July trough).
- **Do not touch dashboard 397 "Platform metrics"** (tabbed; an earlier change broke it).

## Other systems

HubSpot (marketing and CRM), Segment, Google Search Console (`sc-domain:fomf.de`, `fomf.at`, `fomf.ch`; Mahyar owns them; pull script in `../syfat/tools/gsc.sh`), Datadog (Vercel logs of fomf.de, see `tech-and-security.md`).
