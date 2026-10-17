# On-Demand Accredited — commercial ownership

Sub-project of the CTO assistant workspace. Read the parent `AGENTS.md` / `CLAUDE.md` first (company context, language rules, data-sensitivity rules, preapproved read-only access). This file is the entry point; details live in `docs/`.

## What this is

Since **September 2026** Mahyar owns the **commercials of the On-Demand Accredited product** on behalf of the Executive Board: pricing, packaging, positioning, go-to-market and marketing. This is **not part of his CTO role**; he acts here as the product's commercial owner. The mandate is separate from the Platform / Meviq engineering work and must not be mixed with it in comms or docs.

**Goal: double On-Demand Accredited revenue in the coming year** (12 months from Sep 2026).

**Scope, as set by Mahyar on 22 Sep 2026:**
- **Revenue** = membership fees attributed to accredited-led members **plus stand-alone on-demand course sales**. **B2C only**; B2B is out of scope. The last-12-months baseline on this definition is the first deliverable (see workstream 1).
- The mandate **probably includes the content roadmap** (new courses, specialties), not just commercials. Content itself is produced by the **medical team**, which owns it.
- **No commercial team exists today** for this product: no marketing owner, no dedicated docs, no campaigns. This folder is the working base; everything starts from zero.
- **Marketing budget: around €50k** for the year (internal figure, do not paste into external tools).

Sister project with the same mandate and structure: `../syfat/` (SYFAT, the Facharzt exam preparation product). Both are the two "CME on demand" products of the learning platform; keep their analyses comparable and reuse SQL across the two folders where it makes sense.

## The product (facts from fomf.de, 22 Sep 2026)

- **Accredited on-demand CME courses**: recorded, structured learning modules with a closing multiple-choice test, CME points per completed module, accredited (German courses via Landesärztekammer Hessen). Two formats: **Refresher OnDemand** (multi-day course equivalents, 30–60 CME) and **Highlights OnDemand / OnDemand Kurs** (compact, 8 CME). Product page: https://www.fomf.de/on-demand; catalogue at `/kurse`.
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

  Prices differ by participant type (two tiers: Fachärzte and "Sonstige" pay the higher one, doctors and psychologists in training the lower one). All prices per participant type are identical across early-bird / normal / late, and `memberPrice` is null: members get the course through the membership, not at a member price.
- **Packaging** (comparison table on the course pages): a single course, e.g. €640 for 48 CME, 1 premium course, 27 videos, no slides, no certificates, no livestreams — against **FOMF All Access Online/Hybrid 50 from €670**: 50 CME, 150+ premium courses, 6,000+ videos, slides and notes, Facharztvorbereitung, certificates, livestreams, 6 on-site days. Reading: the single course is priced **a few euros below the membership**; it is an on-ramp to the membership, not a product with its own price logic. Any pricing work starts from this fact.
- In the platform data model these courses are `ON_DEMAND_ACCREDITED` content built from `LECTURE` items; in analytics they carry brand `ONDEMAND_ACCREDITED` (`analysis.dim_contents.brand_type`, `analysis.fct_user_watched_content_events.content_brand`). Enrolments **do not create booking rows**; watching, progress (`fct_content_progress_by_user`) and certificates (`fct_content_certificates`) are the usage signals. Stand-alone purchases should appear as orders — which table holds them is the first thing to check (workstream 1).
- Timeline: first accredited content **Jul 2024**, uptake from **Q4 2024**. Course editions are yearly (2025, 2026 in the slugs).
- Prices on fomf.de are rendered client-side; to re-read them, fetch `/content/<slug>` and parse `participantTypePrices` (cents) from the embedded JSON.

### Numbers already established (B2C Value Journey, data as of 21 Sep 2026)

From `../b2c-value-journey/` (definitions in its `docs/definitions.md`; agreed with Mahyar, do not contradict them):

| Fact | Value |
|---|---|
| New B2C members whose likely intent was On-demand-accredited-led | 2% of the Aug 2024–Jul 2025 cohorts → 4% of the Aug 2025–Aug 2026 cohorts; 9–12% in Apr, Jul and Aug 2026 |
| Accredited-led members, first-year membership fees | 235 members · €150k year 1 · €31k year 2 · €636 per member year 1 |
| Members who watched accredited content within 30 d / 90 d / 12 m of joining | 6% / 8% / 13% |
| CME-led (accredited + SYFAT) share of first-year fees | 3% (Aug 2024–Jul 2025 cohorts) → 7% (Aug 2025–Aug 2026); 18% in the Jul 2026 cohort |
| Reading | The CME products are the **only growing entry points** into the membership; they grow at the expense of generic on-demand, not of Refresher. Accredited-led is the faster-growing of the two. |

These cover membership revenue only. Any stand-alone course sales, B2B usage and non-member buyers are **not** in these figures.

## Where the data lives

BigQuery project `fomf-dl` (region europe-west3), read-only preapproved. Query with `bq query --use_legacy_sql=false --project_id=fomf-dl` or, when gcloud auth is expired, `../b2c-value-journey/tools/mbq.sh "<sql>"` (Metabase REST, 2000-row cap, needs `METABASE_API_KEY` in `../.env`, never print it). Fully qualify tables as `` `fomf-dl`.dataset.table ``. Table inventory, brand codes and gotchas: `../b2c-value-journey/docs/data-pipeline.md`.

Most relevant for this product: `analysis.dim_contents` (catalogue, brands, titles), `analysis.fct_user_watched_content_events` (who watched what, minutes), `analysis.fct_content_progress_by_user` and `analysis.fct_content_certificates` (completion, CME points), `analysis.dim_users` (occupation, specialty v2, country), membership orders in `platform_raw_membershipservice.*`, marketing sources in `analysis.fct_membership_marketing_sources`, web behaviour in `segment_raw_unify.*` (on-demand pages under `/mediathek`). Metabase: https://fomf2.metabaseapp.com (companion dashboard "B2C Membership Income", 1816).

Other systems: HubSpot (marketing / CRM, MCP connected), Notion (Executive Board space for strategy; check where the product docs live), Linear (Platform team projects), Slack. Use the MCP tools; do not guess state.

## Workstreams (the commercial funnel, in order)

1. **Baseline** — last-12-months B2C revenue on the agreed definition: (a) first-year and renewal fees of accredited-led members (reuse the intent logic from `../b2c-value-journey/sql/`), (b) stand-alone on-demand course orders (find the order table; check `platform_raw_membershipservice.*`, `analysis.fct_course_bookings` and the content-order tables). Then the Sep 2027 target = 2× that. Confirm the number with Mahyar; align with Erfan (CFO) on the accounting view.
2. **Pricing and packaging** — the single course priced just under the membership; options: reposition the single course (e.g. a clear CME-per-euro story), an on-demand-only membership tier, bundles per specialty, CME-deadline offers. Price tests only with Mahyar's sign-off.
3. **Content roadmap** — which specialties next (Refresher live courses that exist without an on-demand edition; specialty populations in `dim_users`), yearly edition cadence, Highlights vs. full Refresher mix. With the medical team, which owns production.
4. **Audience and positioning** — doctors who need CME points but do not attend live courses; specialty, career stage and country cuts; CME-deadline seasonality (year-end point pressure; Austrian / Swiss rules).
5. **Channels and marketing** — owned first (fomf.de, newsletter, in-platform cross-sell from Refresher recordings and the Mediathek to accredited courses), then paid and partnerships, referral. **~€50k budget**; plan spend by quarter and expected buyers per channel. No marketing owner exists; Mahyar decides.
6. **Measurement** — a small recurring Metabase dashboard: revenue by source (membership-attributed vs. stand-alone), new buyers, course starts, completion and certificates; monthly review against the doubling path.

Log every decision and result in `docs/log.md` with the date.

## Answered by Mahyar (22 Sep 2026)

| Question | Answer |
|---|---|
| Revenue definition | Membership fees attributed to accredited-led members + stand-alone course sales; **B2C only**, no B2B |
| Product today | See fomf.de facts above: 8 courses on the product page, €395–790 single, membership from €670 |
| Team | Medical team owns the content; **nothing else exists** (no marketing, no sales, no PM) |
| Existing docs / campaigns | None |
| Content roadmap in scope? | Probably yes |
| Budget | About €50k marketing budget |

## Still open

- Exact last-12-months baseline number (workstream 1 produces it) and whether Erfan's accounting view matches.
- Which table records stand-alone on-demand course purchases.
- Full catalogue beyond the 8 courses on the product page (the `/kurse` catalogue and `dim_contents` with brand `ONDEMAND_ACCREDITED` will show it), and the Swiss / Austrian editions.
- Who in the medical team is the on-demand content contact.
- Whether the €50k is confirmed by the EB and who approves individual spends.

## How to work with Mahyar on this

- Lead every reply with the finding and the numbers in a small table, then one caveat. He uses these directly in EB slides.
- Short instructions ("simplify", "take this out", "add X"): do exactly that, nothing extra.
- **Language:** English for internal working docs, SQL and analysis in this folder. **German** for anything customer-facing (landing pages, newsletters, ads), for Executive Board communications and for marketing / sales colleagues. Ask when the audience is unclear.
- Ask before: changing an agreed definition, adding a data source outside `fomf-dl`, publishing anything customer-facing, writing to HubSpot / Notion / Linear / Slack, or pasting financials or member-level data into an external tool.
- Per-member extracts carry no identifiers; financial and member-level figures stay in `fomf-dl`, this folder and private artifacts.
- Pricing decisions, contract terms and revenue figures are **financials**: never paste them into external tools without explicit approval.

## Folder

```
AGENTS.md / CLAUDE.md      this entry point (CLAUDE.md points here)
docs/                      log.md (decisions and results, dated) · definitions.md (revenue definition, baseline, segments; once agreed)
sql/                       extracts and checks (fully qualified `fomf-dl` tables)
data/                      extracts, no identifiers, each file states its extraction date
comms/                     drafts: EB updates (DE), marketing briefs (DE), team notes (EN)
```
