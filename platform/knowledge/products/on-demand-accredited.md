# On-Demand Accredited

A learning-platform product. Project lead: Isgard Eyberg (Notion page "OnDemand akkreditierte Kurse"); marketing: Tina Hoffmann. Mahyar owns its commercials (mandate, status and plans: `../../on-demand-accredited/AGENTS.md`).

## Facts from fomf.de (22 Sep 2026)

- **Accredited on-demand CME courses:** recorded, structured learning modules with a closing multiple-choice test, CME points per completed module, accredited (German courses via Landesärztekammer Hessen). Two formats: **Refresher OnDemand** (multi-day course equivalents, 30 to 60 CME) and **Highlights OnDemand / OnDemand Kurs** (compact, 8 CME). Product page: https://www.fomf.de/on-demand; catalogue at `/kurse`.
- **Catalogue (German instance, 8 courses listed on the product page):**

| Course (`/content/<slug>`) | CME | Single price (specialists / doctors in training) |
|---|---|---|
| OnDemand Refresher Allgemein- und Innere Medizin 2026 | 60 | €790 / €740 |
| OnDemand Refresher Innere Medizin 2026 | 48 | €640 / €590 |
| OnDemand Refresher Allgemeinmedizin 2026 | 48 | €640 / €590 |
| OnDemand Refresher Psychiatrie 2026 | 36 | €590 / €540 |
| OnDemand Refresher Pädiatrie 2026 | 30 | €590 / €540 |
| Gynäkologie SKU OnDemand 2026 | 24 | €395 / €370 |
| OnDemand Kurs Psychiatrie 2026 (Highlights) | 8 | no single price shown |
| OnDemand Kurs Pädiatrie 2025 (Highlights) | 8 | no single price shown |

  Prices differ by participant type (two tiers: Fachärzte and "Sonstige" pay the higher one, doctors and psychologists in training the lower one). All prices per participant type are identical across early-bird, normal and late, and `memberPrice` is null: members get the course through the membership, not at a member price.
- **Packaging** (comparison table on the course pages): a single course, e.g. €640 for 48 CME, 1 premium course, 27 videos, no slides, no certificates, no livestreams, against FOMF All Access Online/Hybrid 50 from €670: 50 CME, 150+ premium courses, 6,000+ videos, slides and notes, Facharztvorbereitung, certificates, livestreams, 6 on-site days. Reading: the single course is priced a few euros below the membership; it is an on-ramp to the membership, not a product with its own price logic. Any pricing work starts from this fact.
- In the platform data model these courses are `ON_DEMAND_ACCREDITED` content built from `LECTURE` items; in analytics they carry brand `ONDEMAND_ACCREDITED` (`analysis.dim_contents.brand_type`, `analysis.fct_user_watched_content_events.content_brand`). Enrolments do not create booking rows; watching, progress (`fct_content_progress_by_user`) and certificates (`fct_content_certificates`) are the usage signals. Stand-alone purchases should appear as orders; which table holds them is the first thing to check (workstream 1 in `../../on-demand-accredited/AGENTS.md`).
- Timeline: first accredited content Jul 2024, uptake from Q4 2024. Course editions are yearly (2025, 2026 in the slugs).
- Prices on fomf.de are rendered client-side; to re-read them, fetch `/content/<slug>` and parse `participantTypePrices` (cents) from the embedded JSON.

## Audience and format (from the project page)

- **Target group:** primary = specialists in the offered fields, doctors in private practice and GPs, doctors with regular CME needs. Secondary = hospital doctors with little time, returners, doctors refreshing knowledge, clinics and practices that offer flexible training to staff.
