# SYFAT — decision log

Newest first. Every entry dated. Results with numbers, decisions with who decided.

## 2026-09-22 — Linear project "SYFAT SEO Baseline" set up

Mahyar created the empty project P-MKS-238 on the Marketing & SEO team and asked to plan the baseline in it. Filled in: description (baseline = indexed pages, demand & competition, click value, documented KPI set), lead Mahyar, High, 22 Sep – 23 Oct 2026, Platform team added so PLA-2014 fits. Milestones and 14 issues: 1 Pages indexed (PLA-2014, MKS-254 request indexing, MKS-255 Pages/Links exports, MKS-256 hreflang) · 2 Demand & competition (MKS-257 query list, MKS-258 Keyword Planner volumes, MKS-259 SERP check, MKS-260 brand split, MKS-261 paid/organic overlap) · 3 Click value (MKS-267 Segment conversion, MKS-268 stand-alone purchases table) · 4 Baseline documented (MKS-264 KPI set + month-zero values, MKS-265 monthly tracking, MKS-266 review with Marie and Tina). Gap analysis behind it: Search Console covers only the supply side; demand volumes, competitors, conversion value, brand split, full indexing picture, cross-domain setup and paid cannibalisation were missing.


## 2026-09-22 — organic baseline from Search Console

Mahyar owns Search Console; ADC login with the webmasters.readonly scope, Search Console API enabled in `fomf-dl` (Mahyar ran the command), `tools/gsc.sh` written, 16 months pulled for fomf.de/.at/.ch into `data/gsc_*.tsv`. Findings in `docs/organic-baseline.md`: 150 organic clicks in 16 months on fomf.de (about 1% of site clicks), all on the landing page and one legacy course URL; **the four live course pages have zero impressions** — not in any sitemap, no server-side internal links, thin server-rendered text, no H1/canonical, legacy duplicate still live. Demand exists: 17.7k impressions on exam-intent queries; we rank 5–8 for the head terms with CTR under 1%, 13–49 for Innere Medizin, Gyn, Päd; Dermatologie and Psychiatrie demand without a product. Search Console URL inspection of the Innere Medizin course page: **URL unknown to Google**, never crawled. SEOability dropped as a tool (Mahyar, 22 Sep). Linear issue **PLA-2014** created on the Platform team (High, Backlog, labels SEO / Frontend / Learning Platform / Improvement / Management request); Mahyar hands it over. Copy in `comms/linear-syfat-indexing.md`.


## 2026-09-22 — business owner and Notion page

Mahyar: **Marie Fiebig** is SYFAT's business owner (a doctor herself). Her Notion project page (last edited 30 Jul 2026) read and folded into `AGENTS.md`: co-lead Isgard Eyberg, marketing contact Tina Hoffmann; EB-approved prices Jul 2026 (€590/€520, CHF 890/780); primary target group 3–12 months before the exam; marketing so far only social pushes and Google Search Ads; Psychiatrie planned; livestream "Facharztvorbereitungskurs" line from Feb/Mar 2027 at €490. Content depth varies 58–217 videos across the four courses at two price points.

## 2026-09-22 — scope answered, product facts collected

Mahyar: revenue = membership fees attributed to SYFAT-led members + stand-alone sales, **B2C only**; medical team owns content, no other team or docs exist; content roadmap probably in scope; marketing budget about €50k.

fomf.de read (product page, course pages, comparison tables): SYFAT = Systematisiertes Facharzttraining. 4 courses (Innere, Allgemeinmedizin, Pädiatrie, Gyn), €590 / €520 single course, no CME; membership "from €580" includes all 4 — the membership costs less than one course. Details in `AGENTS.md`.

Next: workstream 1, the last-12-months baseline on this definition (find the stand-alone order table first).

## 2026-09-22 — project set up

Mahyar takes over the commercials of SYFAT (pricing through marketing) from the Executive Board, outside his CTO role. Goal: double SYFAT revenue within the coming year (to Sep 2027). Folder and brief created; sister project `../on-demand-accredited/`.

Starting facts carried over from `../b2c-value-journey/` (data as of 21 Sep 2026): SYFAT-led share of new B2C members 2% → 4% year over year, peaks 7–9% in Apr/Jul 2026; 234 SYFAT-led members paid €122k first-year fees (€523 per member); 9% of members watch SYFAT content in their first 12 months.

Open: revenue definition and baseline, current pricing and packaging, team and doc locations. See the open questions in `AGENTS.md`.
