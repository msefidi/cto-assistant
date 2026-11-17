# SYFAT

A learning-platform product. Business owner: Marie Fiebig (Notion project page). Mahyar owns its commercials (mandate, status and plans: `../../syfat/AGENTS.md`).

## Facts from fomf.de (22 Sep 2026)

- **SYFAT = Systematisiertes Facharzttraining.** Structured on-demand video courses preparing assistant doctors for the Facharztprüfung, built along the official learning-objective catalogue ("nach offiziellem Lernzielkatalog"), updated yearly. Product page: https://www.fomf.de/syfat. Marketing label on course pages: "Facharztvorbereitung".
- **Catalogue (German instance): 4 courses**: Innere Medizin, Allgemeinmedizin, Pädiatrie, Gynäkologie und Geburtshilfe (`/content/syfat-<fach>-de`). Each about 178 on-demand videos. No CME points on the stand-alone course.
- **Pricing and packaging** (all participant types pay the same):

| Offer | Price | What you get |
|---|---|---|
| Single course (Einzelkurs) | €590 Innere Medizin, Allgemeinmedizin · €520 Pädiatrie, Gynäkologie | one Facharztvorbereitung course, ~178 videos, FOMF Free content; no CME, no slides or notes, no certificates |
| FOMF All Access Online/Hybrid 50 (membership) | from €580 on the course pages then; now Online 670 € (see the "FOMF All Access" page) | all 4 SYFAT courses incl. updates, 6,000+ videos, 150+ premium courses, 50 CME, slides and notes, certificates, livestreams, 6 on-site days (Hybrid 50) |

  Reading: the membership is priced at or below a single SYFAT course. Stand-alone SYFAT is effectively an on-ramp to the membership, not a product with its own price logic. Any pricing work starts from this fact.
- In the platform data model SYFAT courses are `ADDON_COURSE` content (course pages) built from `LECTURE` items; in analytics they carry brand `SYFAT` or `SPECIALIST_CERTIFICATE` (`analysis.dim_contents.brand_type`, `analysis.fct_user_watched_content_events.content_brand`). Enrolments do not create booking rows; watching (`fct_user_watched_content_events`) and progress (`fct_content_progress_by_user`) are the usage signals. Stand-alone purchases should appear as orders; which table holds them is the first thing to check (workstream 1 in `../../syfat/AGENTS.md`).
- Timeline: SYFAT watching visible from Oct 2024; content re-tagged in 2025, so brand-based history before 2025 is unreliable (open check: growth vs. re-tagging effect, see `../../../archive/b2c-value-journey/docs/log.md`).
- Prices on fomf.de are rendered client-side; to re-read them, fetch `/content/<slug>` and parse `participantTypePrices` (cents) from the embedded JSON. Comparison tables on the course pages are the source for the packaging above.

## Audience and format (from the project page)

- **Target group:** primary = doctors in training 3 to 12 months before the Facharztprüfung. Secondary = returners, career changers, doctors refreshing knowledge, doctors anxious about the oral exam, clinics and practices as employers. Needs: structured preparation, confidence for the oral exam, realistic exam cases, orientation in the material.
- **Format:** on-demand online course plus course book / digital materials; didactic focus on exam-relevant topics, structured approach, differential-diagnostic thinking, guideline-based therapy decisions.
