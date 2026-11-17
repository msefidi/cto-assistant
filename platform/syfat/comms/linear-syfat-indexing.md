# Linear issue PLA-2014 — "SYFAT course pages not indexed by Google"

Platform team · High · Backlog · labels SEO, Frontend, Learning Platform, Improvement, Management request
https://linear.app/fomf/issue/PLA-2014 — created 22 Sep 2026, shortened the same day on Mahyar's request ("keep it short and precise").

Text as posted:

**Problem:** the four SYFAT course pages (`/content/syfat-innere-medizin-de`, `-allgemeinmedizin-de`, `-paediatrie-de`, `-gynaekologie-de`) have zero Google impressions in 16 months. Search Console URL inspection: "URL is not known to Google". Cause: no sitemap entry, no server-side internal links, no `<h1>` / canonical, thin server-rendered content.

**To do**

- [ ] Add the landing page `/facharztvorbereitungskurs` and all SYFAT (`ADDON_COURSE`) course pages to the sitemap, on fomf.de, fomf.at and fomf.ch
- [ ] Course cards on `/facharztvorbereitungskurs` as server-side `<a href>` links to the course pages
- [ ] Course page head: `<title>` "Facharztvorbereitung <Fach> | SYFAT | FOMF" (current title has a trailing space), per-specialty meta description, self-referencing canonical, one `<h1>`
- [ ] Server-side render the course description, module / video list and FAQ
- [ ] 301 the legacy URLs `/on-demand/syfat-*` (all three domains) to the matching `/content/syfat-*` page
- [ ] Nice to have: schema.org `Course` markup; links to the course pages from `/fortbildungen/<fach>` and `/product/<code>`

**Done when:** Search Console URL inspection shows "URL is on Google" for all four course pages. Mahyar requests indexing after deploy.

Requester: Mahyar · Business owner: Marie Fiebig

---
Full evidence (site checks, Search Console numbers) stays in `../docs/organic-baseline.md`; not in the ticket by design.
