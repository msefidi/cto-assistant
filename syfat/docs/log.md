# SYFAT: log

Newest first. One entry per event or result. Decisions go in `decisions.md`, one line each. Each entry ends with who said it and where, in brackets. Summarise the source; the original stays where it is.

## 2026-11-15: folder brought into the initiative shape; catch-up

Brief rewritten into the template shape, decisions moved to `decisions.md`, log converted. Catch-up searched Outlook, Teams, Notion and Linear from 22 Sep; Slack, SharePoint and HubSpot were not searched. The Linear project "SYFAT SEO Baseline" has not changed since 22 Sep: all 14 issues in Backlog, PLA-2014 unassigned, target date 23 Oct passed. No baseline was produced in this folder. (session of 15 Nov)

## 2026-11-12: user survey discussed

Vahid set up the meeting "Survey SYFAT" with Marie and Mahyar to consult on surveying SYFAT users. Marie shared her concept afterwards: a 9-question online survey of about 3 to 4 minutes for all SYFAT users in DE, AT and CH, running 10 weeks, plus 5 to 8 interviews; separate links for light users (under 1 hour watched, about 670), heavy users (about 940) and members who cancelled or did not renew. Her baseline from Metabase (2 Nov): 1,666 users, 2,127 enrolments, median about 102 minutes watched, 15% under 5 minutes, 74% of users are active members and 34% of those have submitted a cancellation; Gyn and Päd have only 22 and 12 enrolments. Still open on her list: survey tool, engineering integration or transactional e-mail, interview guide; no incentive for now. (Vahid, Outlook calendar "Survey SYFAT"; Marie Fiebig, Teams 1:1 chat and meeting chat, Notion "SYFAT User Survey - Konzept & Fragebogen")

## 2026-11-05: Notion project page updated

Marie's page (dated 28 Sep, last edited 5 Nov) now lists Tina and Mahyar as marketing and Isgard and Marie as project leads. New plans: Psychiatrie 11/2026 to 01/2027, Gyn and Päd content extension 09 to 12/2026 (running), AM and IM update 01 to 03/2027, FAQ, explainer video, KI chatbot and user survey with concepts written, competitor analysis done, a voucher after a passed Facharzt exam. The livestream course will probably get Dr. Landgraf as scientific lead. The "Marketing - SYFAT" sub-page lists channels: Google Ads per specialty, no social media running, last SYFAT newsletter Feb 2025, Jungärzte flyer mailed 09/2026, planned ChatGPT ads and Meta ads. (Marie Fiebig, Notion "SYFAT - Systematisiertes Facharzttraining" and "Marketing - SYFAT")

## 2026-10-26: marketing-performance dashboard in progress

In his first weekly update to Habib, Wafa and Erfan, Mahyar wrote that for On-Demand and SYFAT he is building a dashboard for marketing performance and will keep focusing on it. The dashboard is not in this folder or the Artifact Index. (Mahyar, Teams group chat, 26 Oct)

## 2026-10-14: Tina asks for a newsletter strategy and better URLs

Replying to the EB's priorities, Tina asked for reliable planning, fixed launch timings, technical support and operational relief. She wants one newsletter strategy across all offers and audiences rather than single newsletters for SYFAT or OnDemand accredited courses, with a two-day workshop with Andreas and Engineering. She also asked for a hierarchical URL structure with speaking URLs for SEA and SEO. (Tina Hoffmann, mail "AW: Prioritäten in der Vermarktung")

## 2026-10-13: EB sets marketing priorities

After Tina's message to the EB of 12 Oct about hurdles in marketing, the EB set marketing's priorities for the next two months and gave Mahyar the marketing responsibility for SYFAT and OnDemand accredited courses (line in `decisions.md`). Habib is also preparing a job posting for performance marketing. (Habib, mail "Prioritäten in der Vermarktung"; Tina Hoffmann, Teams, 12 Oct)

## 2026-10-08: Marketing - SYFAT page shared

Marie posted her Notion page "Marketing - SYFAT" in the medical team's meeting chat. Wafa wrote in the same chat that SYFAT and OnDemand will be taken to a new level. (Marie Fiebig and Wafa, Teams medical team meeting chat)

## 2026-10-07: team event station on OnDemand and SYFAT

The programme of the FOMF team event has a station B "OnDemand/SYFAT" run by Isgard and Marie, with Sina. What came out of it is not recorded. (Vanessa Schützl, mail "Vorbereitung für Teamevent / Infos zum Programm")

## 2026-10-05: SEO strategy for Facharzt pages missing

Daniela asked to prioritise Claneo's content analysis of the pages the first analysis left out, including CME OnDemand and Facharztvorbereitung pages, for which there is no SEO strategy yet; she could work on most of them without Engineering. The outcome of the jour fixe is not recorded. (Daniela König, mail "AW: Finale Freigabe neue Fachgebiete-Seite")

## 2026-09-25: Mahyar joins the medical team meeting

Wafa told the medical team that the EB decided Mahyar develops the product and marketing strategy for OnDemand and SYFAT with the business owners, and that he joins their Thursday meeting in her place. Marie was away the following week at the Medical Circle. (Wafa and Marie Fiebig, Teams medical team meeting chat)

## 2026-09-22: Linear project "SYFAT SEO Baseline" set up

Mahyar created the empty project P-MKS-238 on the Marketing & SEO team and asked to plan the baseline in it. Filled in: description (baseline = indexed pages, demand and competition, click value, documented KPI set), lead Mahyar, High, 22 Sep to 23 Oct 2026, Platform team added so PLA-2014 fits. Milestones and 14 issues: 1 Pages indexed (PLA-2014, MKS-254 request indexing, MKS-255 Pages/Links exports, MKS-256 hreflang) · 2 Demand and competition (MKS-257 query list, MKS-258 Keyword Planner volumes, MKS-259 SERP check, MKS-260 brand split, MKS-261 paid/organic overlap) · 3 Click value (MKS-267 Segment conversion, MKS-268 stand-alone purchases table) · 4 Baseline documented (MKS-264 KPI set and month-zero values, MKS-265 monthly tracking, MKS-266 review with Marie and Tina). The gap analysis behind it: Search Console covers only the supply side; demand volumes, competitors, conversion value, brand split, the full indexing picture, cross-domain setup and paid cannibalisation were missing. (Mahyar, session of 22 Sep)

## 2026-09-22: organic baseline from Search Console

Search Console API enabled in `fomf-dl`, `tools/gsc.sh` written, 16 months pulled for fomf.de, .at and .ch into `data/gsc_*.tsv`. Findings in `docs/organic-baseline.md`: 150 organic clicks in 16 months on fomf.de (about 1% of site clicks), all on the landing page and one legacy course URL; the four live course pages have zero impressions (not in any sitemap, no server-side internal links, thin server-rendered text, no H1 or canonical, legacy duplicate still live). Demand exists: 17.7k impressions on exam-intent queries; we rank 5 to 8 for the head terms with CTR under 1%, 13 to 49 for Innere Medizin, Gyn and Päd; Dermatologie and Psychiatrie have demand without a product. URL inspection of the Innere Medizin course page: unknown to Google, never crawled. Linear issue PLA-2014 created on the Platform team (High, Backlog), text in `comms/linear-syfat-indexing.md`. (Mahyar, session of 22 Sep)

## 2026-09-22: business owner and Notion page

Mahyar named Marie Fiebig as SYFAT's business owner. Her Notion page (then last edited 30 Jul) was read and folded into the brief: co-lead Isgard Eyberg, marketing contact Tina Hoffmann, approved prices, target group 3 to 12 months before the exam, Psychiatrie planned, the livestream "Facharztvorbereitungskurs" line from Feb/Mar 2027 at €490. Marie said running marketing is mainly Google Ads; only the Jungärzte flyer went out in September (it includes SYFAT); no social media at the moment. (Mahyar, session of 22 Sep; Marie Fiebig, Teams 1:1 chat)

## 2026-09-22: scope answered, product facts collected

Mahyar answered the scope questions: the revenue definition (in `decisions.md`), the medical team owns the content, no other team or docs exist, the content roadmap is probably in scope, marketing budget about €50k. fomf.de read: 4 courses, €590 / €520 single course without CME; the membership "from €580" includes all 4, so it costs less than one course. Next: the last-12-months baseline, starting with the stand-alone order table. (Mahyar, session of 22 Sep)

## 2026-09-22: project set up

Mahyar took over the commercials of SYFAT from the Executive Board, outside his CTO role, with the goal of doubling revenue by Sep 2027; folder and brief created, sister project `../on-demand-accredited/`. Starting facts from `../b2c-value-journey/` (data as of 21 Sep): SYFAT-led share of new B2C members 2% → 4% year over year, peaks 7 to 9% in Apr and Jul 2026; 234 SYFAT-led members paid €122k first-year fees (€523 per member); 9% of members watch SYFAT content in their first 12 months. (Mahyar, session of 22 Sep)
