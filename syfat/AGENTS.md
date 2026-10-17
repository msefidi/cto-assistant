# SYFAT — commercial ownership

Sub-project of the CTO assistant workspace. Read the parent `AGENTS.md` / `CLAUDE.md` first (company context, language rules, data-sensitivity rules, preapproved read-only access). This file is the entry point; details live in `docs/`.

## What this is

Since **September 2026** Mahyar owns the **commercials of SYFAT** on behalf of the Executive Board: pricing, packaging, positioning, go-to-market and marketing. This is **not part of his CTO role**; he acts here as the product's commercial owner. The mandate is separate from the Platform / Meviq engineering work and must not be mixed with it in comms or docs.

**Goal: double SYFAT revenue in the coming year** (12 months from Sep 2026).

**Scope, as set by Mahyar on 22 Sep 2026:**
- **Revenue** = membership fees attributed to SYFAT-led members **plus stand-alone SYFAT course sales**. **B2C only**; B2B is out of scope. The last-12-months baseline on this definition is the first deliverable (see workstream 1).
- The mandate **probably includes the content roadmap** (new specialties, updates), not just commercials. Content itself is produced by the **medical team**, which owns it.
- **People:** **Marie Fiebig** (fiebig@fomf.org) is the **business owner** of SYFAT; she is a doctor herself and co-leads the project with **Isgard Eyberg** (eyberg@fomf.org). **Tina Hoffmann** (hoffmann@fomf.org) is the marketing contact on the project page. Beyond that there is no commercial team; Mahyar sets the commercial direction and works with Marie on product and content. Marketing so far was small and campaign-based (see below).
- **Marketing budget: around €50k** for the year (internal figure, do not paste into external tools).

Sister project with the same mandate and structure: `../on-demand-accredited/` (On-Demand Accredited). Both are the two "CME on demand" products of the learning platform; keep their analyses comparable and reuse SQL across the two folders where it makes sense.

## The product (facts from fomf.de, 22 Sep 2026)

- **SYFAT = Systematisiertes Facharzttraining.** Structured on-demand video courses preparing assistant doctors for the **Facharztprüfung** (specialist exam), built along the official learning-objective catalogue ("nach offiziellem Lernzielkatalog"), updated yearly. Product page: https://www.fomf.de/syfat. Marketing label on course pages: "Facharztvorbereitung".
- **Catalogue (German instance): 4 courses** — Innere Medizin, Allgemeinmedizin, Pädiatrie, Gynäkologie und Geburtshilfe (`/content/syfat-<fach>-de`). Each about 178 on-demand videos. **No CME points** on the stand-alone course.
- **Pricing and packaging** (all participant types pay the same):

| Offer | Price | What you get |
|---|---|---|
| Single course (Einzelkurs) | **€590** Innere Medizin, Allgemeinmedizin · **€520** Pädiatrie, Gynäkologie | one Facharztvorbereitung course, ~178 videos, FOMF Free content; no CME, no slides/notes, no certificates |
| FOMF All Access Online/Hybrid 50 (membership) | **from €580** | all 4 SYFAT courses incl. updates, 6,000+ videos, 150+ premium courses, 50 CME, slides and notes, certificates, livestreams, 6 on-site days (Hybrid 50) |

  Reading: the membership is priced **at or below a single SYFAT course**. Stand-alone SYFAT is effectively an on-ramp to the membership, not a product with its own price logic. Any pricing work starts from this fact.
- In the platform data model SYFAT courses are `ADDON_COURSE` content (course pages) built from `LECTURE` items; in analytics they carry brand `SYFAT` or `SPECIALIST_CERTIFICATE` (`analysis.dim_contents.brand_type`, `analysis.fct_user_watched_content_events.content_brand`). Enrolments **do not create booking rows**; watching (`fct_user_watched_content_events`) and progress (`fct_content_progress_by_user`) are the usage signals. Stand-alone purchases should appear as orders — which table holds them is the first thing to check (workstream 1).
- Timeline: SYFAT watching visible from **Oct 2024**; content re-tagged in 2025, so brand-based history before 2025 is unreliable (open check: growth vs. re-tagging effect, see `../b2c-value-journey/docs/log.md`).
- Prices on fomf.de are rendered client-side; to re-read them, fetch `/content/<slug>` and parse `participantTypePrices` (cents) from the embedded JSON. Comparison tables on the course pages are the source for the packaging above.

### Marie's project page (Notion, last edited 30 Jul 2026)

https://app.notion.com/p/fomf/SYFAT-Systematisiertes-Facharzttraining-3817afedf30980c99589cda790d78cd0 — the only existing product doc; German. Sub-pages: "SYFAT - Livestream Kurse", "OP-Lehre Gyn - WebOP", "Landing Page" (empty). What it adds beyond fomf.de:

- **Status and roadmap:** AM and IM online first; Gyn and Päd prepared for a Jul/Aug 2026 launch (both are live on fomf.de as of 22 Sep 2026); Gyn and Päd content to be extended with speaker lectures Aug–Sep 2026; **Psychiatrie** planned, to be built and launched Jul–Sep 2026 (not on fomf.de yet: check status with Marie). Gyn got a new "Operative Gynäkologie" section with 17 WebOP surgery videos (Jul 2026).
- **Target group:** primary = doctors in training **3–12 months before the Facharztprüfung**. Secondary = returners, career changers, doctors refreshing knowledge, doctors anxious about the oral exam, clinics and practices as employers. Needs: structured preparation, confidence for the oral exam, realistic exam cases, orientation in the material.
- **Format:** on-demand online course plus course book / digital materials; didactic focus on exam-relevant topics, structured approach, differential-diagnostic thinking, guideline-based therapy decisions.
- **Marketing so far:** time-limited social media post pushes and Google Search Ads. **Planned:** social media campaigns, Google Search Ads, flyers after the Gyn/Päd launch. No budget, targets or results are recorded.
- **Prices approved by the management (EB feedback Jul 2026):**

| Course | Videos recommended / further | DE/AT | CH |
|---|---|---|---|
| SYFAT AM | 130 / 87 | €590 | CHF 890 |
| SYFAT IM | 86 / 68 | €590 | CHF 890 |
| SYFAT Päd | 55 / 32 | €520 | CHF 780 |
| SYFAT Gyn | 35 / 23 | €520 | CHF 780 |

  Content depth differs a lot: AM has 217 videos, Gyn 58, at the same two price points.
- **Adjacent project, "Facharztvorbereitungskurs" livestream** (same page tree): 3–4-day live courses per specialty, CME via LÄK Hessen, sponsored symposia, VoD access afterwards, two-year rhythm. Plan: AM Feb/Mar 2027 (in contact with Events), Gyn autumn 2027, IM Feb/Mar 2028, Päd autumn 2028, Psych open. Planned price **€490 / CHF 490 per participant**, membership €570 / CHF 860 next to it. Sponsoring and Events contacts are on that page. Treat this as part of the SYFAT commercial line: it is a second revenue stream and a marketing moment for the on-demand course.

### Numbers already established (B2C Value Journey, data as of 21 Sep 2026)

From `../b2c-value-journey/` (definitions in its `docs/definitions.md`; agreed with Mahyar, do not contradict them):

| Fact | Value |
|---|---|
| New B2C members whose likely intent was SYFAT-led | 2% of the Aug 2024–Jul 2025 cohorts → 4% of the Aug 2025–Aug 2026 cohorts; peaks 7–9% in Apr and Jul 2026 |
| SYFAT-led members, first-year membership fees | 234 members · €122k year 1 · €32k year 2 · €523 per member year 1 (lowest of all classes: more assistant doctors at the €490 price) |
| Members who watched SYFAT content within 30 d / 90 d / 12 m of joining | 5% / 6% / 9% |
| Reading | The CME products (accredited + SYFAT) are the **only growing entry points** into the membership; they grow at the expense of generic on-demand, not of Refresher. SYFAT-led members are among the most active (assistant doctors, German, renewing at 51–62%). |

These cover membership revenue only. Any stand-alone SYFAT sales, B2B usage and non-member buyers are **not** in these figures.

## Where the data lives

BigQuery project `fomf-dl` (region europe-west3), read-only preapproved. Query with `bq query --use_legacy_sql=false --project_id=fomf-dl` or, when gcloud auth is expired, `../b2c-value-journey/tools/mbq.sh "<sql>"` (Metabase REST, 2000-row cap, needs `METABASE_API_KEY` in `../.env`, never print it). Fully qualify tables as `` `fomf-dl`.dataset.table ``. Table inventory, brand codes and gotchas: `../b2c-value-journey/docs/data-pipeline.md`.

Most relevant for this product: `analysis.dim_contents` (catalogue, brands), `analysis.fct_user_watched_content_events` (who watched what, minutes), `analysis.fct_content_progress_by_user` and `analysis.fct_content_certificates` (completion, CME points), `analysis.dim_users` (occupation, specialty v2), membership orders in `platform_raw_membershipservice.*`, marketing sources in `analysis.fct_membership_marketing_sources`, web behaviour in `segment_raw_unify.*`. Metabase: https://fomf2.metabaseapp.com (companion dashboard "B2C Membership Income", 1816).

Other systems: HubSpot (marketing / CRM, MCP connected), Notion (Executive Board space for strategy; check where SYFAT product docs live), Linear (Platform team projects), Slack. Use the MCP tools; do not guess state.

## Workstreams (the commercial funnel, in order)

1. **Baseline** — last-12-months B2C revenue on the agreed definition: (a) first-year and renewal fees of SYFAT-led members (reuse the intent logic from `../b2c-value-journey/sql/`), (b) stand-alone SYFAT course orders (find the order table; check `platform_raw_membershipservice.*`, `analysis.fct_course_bookings` and the content-order tables). Then the Sep 2027 target = 2× that. Confirm the number with Mahyar; align with Erfan (CFO) on the accounting view.
2. **Pricing and packaging** — the €590/€520 single course vs. €580+ membership tension; options: reposition the single course, bundle SYFAT with a membership tier for assistant doctors, exam-timed offers, per-specialty pricing. Price tests only with Mahyar's sign-off.
3. **Content roadmap** — which specialties next (largest assistant-doctor populations without a SYFAT course; check `dim_users` specialty v2 counts), update cadence, what "4 (inkl. Updates)" promises. With Marie (business owner) and the medical team, which owns production; the Notion roadmap (Psychiatrie next, livestream courses from 2027) is the starting point.
4. **Audience and positioning** — assistant doctors by specialty and exam timing, DACH split, messaging against the alternatives (books, repetitorien, peers).
5. **Channels and marketing** — owned first (fomf.de, newsletter, in-platform cross-sell to members who already watch SYFAT content), then paid and partnerships (clinics, Ärztekammern, specialty societies), referral. **~€50k budget**; plan spend by quarter and expected buyers per channel. Tina Hoffmann is the marketing contact so far; Mahyar decides on budget and priorities.
6. **Measurement** — a small recurring Metabase dashboard: revenue by source (membership-attributed vs. stand-alone), new buyers, course starts, completion; monthly review against the doubling path.

Log every decision and result in `docs/log.md` with the date.

## Answered by Mahyar (22 Sep 2026)

| Question | Answer |
|---|---|
| Revenue definition | Membership fees attributed to SYFAT-led members + stand-alone SYFAT sales; **B2C only**, no B2B |
| Product today | See fomf.de facts above: 4 courses, €590 / €520 single, membership from €580 |
| Team | Marie Fiebig is business owner (doctor), Isgard Eyberg co-lead, Tina Hoffmann marketing contact; medical team owns the content; no sales, no PM |
| Existing docs / campaigns | Marie's Notion project page (link above); small social and Google Search Ads pushes, no recorded results |
| Content roadmap in scope? | Probably yes |
| Budget | About €50k marketing budget |

## Still open

- Exact last-12-months baseline number (workstream 1 produces it) and whether Erfan's accounting view matches.
- Which table records stand-alone on-demand / SYFAT course purchases.
- Psychiatrie status (planned Jul–Sep 2026 on the Notion page, not on fomf.de yet).
- Results of the social / Google Ads pushes so far (ask Tina Hoffmann), and whether a CH price test ever happened.
- Whether the €50k is confirmed by the EB and who approves individual spends.

## How to work with Mahyar on this

- Lead every reply with the finding and the numbers in a small table, then one caveat. He uses these directly in EB slides.
- Short instructions ("simplify", "take this out", "add X"): do exactly that, nothing extra.
- **Language:** English for internal working docs, SQL and analysis in this folder. **German** for anything customer-facing (landing pages, newsletters, ads), for Executive Board communications and for Marie, Isgard, Tina and other marketing / medical colleagues. Ask when the audience is unclear.
- Ask before: changing an agreed definition, adding a data source outside `fomf-dl`, publishing anything customer-facing, writing to HubSpot / Notion / Linear / Slack, or pasting financials or member-level data into an external tool.
- Per-member extracts carry no identifiers; financial and member-level figures stay in `fomf-dl`, this folder and private artifacts.
- Pricing decisions, contract terms and revenue figures are **financials**: never paste them into external tools without explicit approval.

## Organic search (Search Console)

**Linear project "SYFAT SEO Baseline" (P-MKS-238, Marketing & SEO team + Platform, lead Mahyar, 22 Sep – 23 Oct 2026):** https://linear.app/fomf/project/syfat-seo-baseline-cc39cbac19f3. Four milestones: 1 Pages indexed (PLA-2014, MKS-254…256) · 2 Demand & competition known (MKS-257…261) · 3 Click value known (MKS-267, MKS-268) · 4 Baseline documented (MKS-264…266). Work the issues from here and comment results in Linear; MKS-258 and MKS-261 need Google Ads access via Tina Hoffmann and are unassigned.


Mahyar owns the Search Console properties (`sc-domain:fomf.de`, `fomf.at`, `fomf.ch` and others). `tools/gsc.sh` pulls the Search Analytics API read-only; auth is `gcloud auth application-default login` with the `webmasters.readonly` scope (command in the script header), quota project `fomf-dl` (API enabled 22 Sep 2026). Baseline and findings: `docs/organic-baseline.md`; raw extracts `data/gsc_*.tsv`.

## Folder

```
AGENTS.md / CLAUDE.md      this entry point (CLAUDE.md points here)
docs/                      log.md (decisions and results, dated) · organic-baseline.md (Search Console findings) · definitions.md (revenue definition, baseline, segments; once agreed)
sql/                       extracts and checks (fully qualified `fomf-dl` tables)
tools/                     gsc.sh (Search Console API, read-only)
data/                      extracts, no identifiers, each file states its extraction date
comms/                     drafts: EB updates (DE), marketing briefs (DE), team notes (EN)
```
