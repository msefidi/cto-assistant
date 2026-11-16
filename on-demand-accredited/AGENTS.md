# On-Demand Accredited: commercial ownership

Since September 2026 Mahyar owns the commercials of the On-Demand Accredited product (CME-point-bearing on-demand courses, called "CME OnDemand" or "OnDemand akkreditierte Kurse" internally) for the Executive Board: pricing, packaging, positioning, go-to-market and marketing. This is not part of his CTO role; he acts as the product's commercial owner. The goal is to double its B2C revenue by Sep 2027. The folder was set up on 22 Sep 2026. Sister initiative with the same mandate and shape: `../syfat/`.

## Status

**As of 15 Nov 2026:** The revenue baseline (workstream 1) is not done; nothing was logged here between 22 Sep and this catch-up. The brief of 22 Sep said the product had no owner, marketing or docs. Since 23 Oct a Notion project page names Isgard Eyberg as project lead and Tina Hoffmann as marketing, with a roadmap and a marketing overview; Isgard shared it in the medical team meeting chat on 5 Nov.

- **Next step:** to confirm with Mahyar. Proposed, not confirmed by Mahyar: produce the last-12-months baseline and agree with Isgard how her project page and this mandate fit together.
- **Next date:** none recorded.
- **Waiting on:** nobody recorded.

## Goal

Double On-Demand Accredited revenue in the 12 months from Sep 2026, so by Sep 2027. Revenue = membership fees attributed to accredited-led members plus stand-alone on-demand course sales, B2C only (B2B is out of scope). The Sep 2027 target is 2× the last-12-months baseline on that definition; the baseline is the first deliverable. The mandate probably includes the content roadmap (new courses, specialties); the medical team produces and owns the content. On 13 Oct the EB also made Mahyar responsible for the marketing of the OnDemand accredited courses from the business-owner side, with the marketing team supporting mainly in newsletter and print.

## People

| Who | Role here |
|---|---|
| Mahyar | Commercial owner: decides on budget and priorities, owns marketing from the business-owner side (EB, 13 Oct) |
| Isgard Eyberg (eyberg@fomf.org) | Project lead (Projektleitung) on the Notion page "OnDemand akkreditierte Kurse", created 23 Oct |
| Tina Hoffmann (hoffmann@fomf.org) | Head of marketing; marketing on the Notion page |
| Daniela König (koenig@fomf.org) | SEO; works with the agency Claneo. Asked on 5 Oct for an SEO analysis of the CME OnDemand pages |
| Marie Fiebig | Checks SYFAT and On-Demand content regularly with Isgard and reports issues (Mahyar, 3 Nov) |
| Habib | CGO. Sent the EB's marketing priorities on 13 Oct |
| Wafa | Co-founder; runs the medical team meeting where SYFAT and On-Demand are discussed |
| Erfan | CFO. The baseline is to be aligned with his accounting view |
| Medical team | Owns and produces the content |

## Open points

- The last-12-months baseline number does not exist yet, and whether Erfan's accounting view matches is open. (owner: Mahyar)
- Which table records stand-alone on-demand course purchases is unknown. The daily "Anmeldestand" booking report shows OnDemand rows at 0, which fits enrolments not creating booking rows. (owner: Mahyar)
- How Isgard's project lead role relates to Mahyar's commercial ownership is not recorded; the workspace `CLAUDE.md` still says the product has no owner. (owner: Mahyar)
- Full catalogue beyond the 8 DE/AT courses: the Notion page lists 2 CH courses and planned ones; `dim_contents` with brand `ONDEMAND_ACCREDITED` will show the rest. (owner: Mahyar)
- Who in the medical team is the on-demand content contact (possibly Isgard, not confirmed). (owner: Mahyar)
- Whether the EB confirmed the €50k marketing budget and who approves individual spends. (owner: Mahyar)
- The marketing-performance dashboard Mahyar said he was building (EB update, 26 Oct) is not in this folder or the Artifact Index. (owner: Mahyar)
- Membership price: fomf.de showed "from €670" on 22 Sep; the Notion page lists All Access Online 50 at €670 a year or CHF 990. The SYFAT pages showed "from €580" on the same day. Which price applies to which buyer is not settled. (owner: Mahyar)

## Rules

- Read the workspace `CLAUDE.md` first (company context, language rules, data-sensitivity rules, preapproved read-only access).
- Keep this mandate separate from Platform and Eviplex engineering work in comms and docs.
- Keep analyses comparable with `../syfat/` and reuse SQL across the two folders where it makes sense.
- Lead every reply with the finding and the numbers in a small table, then one caveat. Mahyar uses these directly in EB slides.
- Short instructions ("simplify", "take this out", "add X"): do exactly that, nothing extra.
- Language: English for internal working docs, SQL and analysis in this folder. German for anything customer-facing (landing pages, newsletters, ads), for Executive Board communications and for marketing, sales and medical colleagues. Ask when the audience is unclear.
- Ask before changing an agreed definition, adding a data source outside `fomf-dl`, publishing anything customer-facing, writing to HubSpot, Notion, Linear or Slack, or pasting financials or member-level data into an external tool.
- Pricing decisions, contract terms and revenue figures are financials: never paste them into external tools without explicit approval. The €50k marketing budget is an internal figure.
- Per-member extracts carry no identifiers; financial and member-level figures stay in `fomf-dl`, this folder and private artifacts.
- Price tests only with Mahyar's sign-off.

## Source map

| Where | What to search or open |
|---|---|
| Outlook | Search `"OnDemand akkreditiert"`, `"CME OnDemand"`, `"On-Demand"`. Threads: "Prioritäten in der Vermarktung" (Habib, 13 Oct; Tina's reply, 14 Oct), "Finale Freigabe neue Fachgebiete-Seite" (Daniela König, SEO), "Vorbereitung für Teamevent / Infos zum Programm" (Vanessa Schützl, 7 Oct). Senders: eyberg@, hoffmann@, koenig@. `akkreditiert` alone mostly finds event accreditation and staff badge messages. |
| Teams | Search `"On-Demand" OR OnDemand OR "CME OnDemand"`. The medical team's weekly meeting chat (Wafa's meeting; Isgard posts there); Mahyar's 1:1 chat with Isgard; Mahyar's weekly update to the group chat with Habib, Wafa and Erfan (26 Oct). |
| Slack | Not searched yet. |
| SharePoint | Not searched yet. |
| Notion | Isgard's project page "OnDemand akkreditierte Kurse" (https://app.notion.com/p/fomf/OnDemand-akkreditierte-Kurse-4027afedf3098099b06cc3a0fb9b8c72), with the "Roadmap OnDemand akkreditierte Kurse" database, "Statistik Zielgruppe OnDemand Kurse", "Marketing - OnDemand akkreditierte Kurse" (two databases, one a marketing roadmap) and "OnDemand – akkreditierte Kurse & wichtige Informationen". |
| Linear | none |
| Other | BigQuery `fomf-dl` and Metabase https://fomf2.metabaseapp.com (dashboard "B2C Membership Income", 1816). fomf.de product page `/on-demand` and catalogue `/kurse`. HubSpot: not searched yet. |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
| `sql/`, `data/`, `comms/` | Empty so far (placeholders only) |

Conventions: `sql/` holds extracts and checks with fully qualified `fomf-dl` tables. `data/` holds extracts without identifiers, each stating its extraction date. `comms/` holds drafts: EB updates (DE), marketing briefs (DE), team notes (EN). A `docs/definitions.md` (revenue definition, baseline, segments) is to be added once agreed.

## The product (facts from fomf.de, 22 Sep 2026)

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
- In the platform data model these courses are `ON_DEMAND_ACCREDITED` content built from `LECTURE` items; in analytics they carry brand `ONDEMAND_ACCREDITED` (`analysis.dim_contents.brand_type`, `analysis.fct_user_watched_content_events.content_brand`). Enrolments do not create booking rows; watching, progress (`fct_content_progress_by_user`) and certificates (`fct_content_certificates`) are the usage signals. Stand-alone purchases should appear as orders; which table holds them is the first thing to check (workstream 1).
- Timeline: first accredited content Jul 2024, uptake from Q4 2024. Course editions are yearly (2025, 2026 in the slugs).
- Prices on fomf.de are rendered client-side; to re-read them, fetch `/content/<slug>` and parse `participantTypePrices` (cents) from the embedded JSON.

### Isgard's Notion project page (read 15 Nov 2026)

Page "OnDemand akkreditierte Kurse", dated 23 Oct 2026, last edited 12 Nov 2026, German. What it adds beyond fomf.de:

- **Status:** DE and AT 8 courses online: Refresher AM, IM, Allgemeine Innere Medizin, Psychiatrie and Pädiatrie; Studien- und Kongressupdate Gynäkologie; Highlights Pädiatrie and Psychiatrie. CH 2 courses online: Pädiatrie in German and French. Highlights AM and IM are being renewed; Studien- und Kongressupdate Kardiologie planned; CH Allgemeine Innere Medizin submitted for accreditation, IM and Médecine Interne Générale planned; a Refresher Gynäkologie is to be built.
- **Done:** switch to All Access Online and new pricing 09/2026; marketing started (Google Ads, social, newsletter, direct mail); a cross-department workshop held 10/2026.
- **Next:** extend the 2027 offering and update content; a new product name to set it apart from recordings and livestreams; marketing and SEO; link live and on-demand courses; explainer video and Eviplex integration; an app with offline use and notifications; sponsoring (symposia, sponsored short videos); retention.
- **Target group:** primary = specialists in the offered fields, doctors in private practice and GPs, doctors with regular CME needs. Secondary = hospital doctors with little time, returners, doctors refreshing knowledge, clinics and practices that offer flexible training to staff.
- **Marketing so far (2026):** Google Search Ads in DE, AT and CH since Jul 2026; social posts and pushes; newsletters in DE and AT in February and one on the AIM Refresher in July; print ad in CME-Magazin Deutschland (Apr 2026); direct mail in Aug 2026 to GPs and internists in private practice in Niedersachsen, Hamburg, Sachsen, Schleswig-Holstein and Bremen.
- **Marketing planned 2026/2027:** new product name, Google Ads keyword and conversion work, more social content, an explainer video, landing page and SEO, regular newsletters, a second direct mail and ads in specialist media, cross-selling with live courses and All Access, presence at FOMF live courses and events, Eviplex link, retention, better tracking, and using the planned budget more fully.
- **Pricing (as of Oct 2026):** All Access Online 50 €670 a year (DE/AT), CHF 990 (CH). Single prices for the Refreshers and the Gyn update as on fomf.de (higher tier); Highlights are included in All Access only; CH is sold only through All Access.

## Numbers already established

From `../b2c-value-journey/` (data as of 21 Sep 2026; definitions in its `docs/definitions.md`, agreed with Mahyar, do not contradict them):

| Fact | Value |
|---|---|
| New B2C members whose likely intent was On-demand-accredited-led | 2% of the Aug 2024–Jul 2025 cohorts → 4% of the Aug 2025–Aug 2026 cohorts; 9–12% in Apr, Jul and Aug 2026 |
| Accredited-led members, first-year membership fees | 235 members · €150k year 1 · €31k year 2 · €636 per member year 1 |
| Members who watched accredited content within 30 d / 90 d / 12 m of joining | 6% / 8% / 13% |
| CME-led (accredited + SYFAT) share of first-year fees | 3% (Aug 2024–Jul 2025 cohorts) → 7% (Aug 2025–Aug 2026); 18% in the Jul 2026 cohort |
| Reading | The CME products are the only growing entry points into the membership; they grow at the expense of generic on-demand, not of Refresher. Accredited-led is the faster-growing of the two. |

These cover membership revenue only. Stand-alone course sales, B2B usage and non-member buyers are not in these figures.

## Where the data lives

BigQuery project `fomf-dl` (region europe-west3), read-only preapproved. Query with `bq query --use_legacy_sql=false --project_id=fomf-dl` or, when gcloud auth is expired, `../b2c-value-journey/tools/mbq.sh "<sql>"` (Metabase REST, 2000-row cap, needs `METABASE_API_KEY` in `../.env`, never print it). Fully qualify tables as `` `fomf-dl`.dataset.table ``. Table inventory, brand codes and gotchas: `../b2c-value-journey/docs/data-pipeline.md`.

Most relevant: `analysis.dim_contents` (catalogue, brands, titles), `analysis.fct_user_watched_content_events` (who watched what, minutes), `analysis.fct_content_progress_by_user` and `analysis.fct_content_certificates` (completion, CME points), `analysis.dim_users` (occupation, specialty v2, country), membership orders in `platform_raw_membershipservice.*`, marketing sources in `analysis.fct_membership_marketing_sources`, web behaviour in `segment_raw_unify.*` (on-demand pages under `/mediathek`). Metabase: https://fomf2.metabaseapp.com (companion dashboard "B2C Membership Income", 1816).

Other systems: HubSpot (marketing / CRM, MCP connected), Notion (Isgard's page above; the Executive Board space for strategy), Linear (Platform team projects), Slack. Use the MCP tools; do not guess state.

## Workstreams (the commercial funnel, in order)

1. **Baseline:** last-12-months B2C revenue on the agreed definition: (a) first-year and renewal fees of accredited-led members (reuse the intent logic from `../b2c-value-journey/sql/`), (b) stand-alone on-demand course orders (find the order table; check `platform_raw_membershipservice.*`, `analysis.fct_course_bookings` and the content-order tables). Then the Sep 2027 target = 2× that. Confirm the number with Mahyar; align with Erfan on the accounting view.
2. **Pricing and packaging:** the single course priced just under the membership; options: reposition the single course (e.g. a clear CME-per-euro story), an on-demand-only membership tier, bundles per specialty, CME-deadline offers.
3. **Content roadmap:** which specialties next (Refresher live courses that exist without an on-demand edition; specialty populations in `dim_users`), yearly edition cadence, Highlights vs. full Refresher mix. With the medical team, which owns production; Isgard's Notion roadmap is the starting point.
4. **Audience and positioning:** doctors who need CME points but do not attend live courses; specialty, career stage and country cuts; CME-deadline seasonality (year-end point pressure; Austrian and Swiss rules).
5. **Channels and marketing:** owned first (fomf.de, newsletter, in-platform cross-sell from Refresher recordings and the Mediathek to accredited courses), then paid and partnerships, referral. About €50k budget; plan spend by quarter and expected buyers per channel. Mahyar decides; Tina is the marketing contact on Isgard's page.
6. **Measurement:** a small recurring Metabase dashboard: revenue by source (membership-attributed vs. stand-alone), new buyers, course starts, completion and certificates; monthly review against the doubling path.
