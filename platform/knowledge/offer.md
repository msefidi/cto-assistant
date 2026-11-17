# Platform: offer

**Source of truth for FOMF's products, for now:** the Notion page "Produktwelt bei FOMF" (Strukturdokumente, Stand 29 Sep 2026): https://app.notion.com/p/fomf/Produktwelt-bei-FOMF-3ea7afedf309808e8bfcf1891a76175e. It covers every product family, the All Access tiers and prices, offers for special audiences, Eviplex, sponsoring, what is in development, team rules and a glossary. Read it there; this file only orients and adds what it does not say. If this file and the page disagree, the page wins (Mahyar, 17 Nov 2026). Two exceptions: **All Access tiers and prices** come from the Notion page "FOMF All Access" (https://app.notion.com/p/fomf/FOMF-All-Access-12d7afedf30980ca8bb2ff2f0ace6e9c), and **Eviplex** comes from `../../eviplex/knowledge/`, not from the Produktwelt page.

## Product families (orientation; detail on the Notion page)

| Family | Products |
|---|---|
| Live-Kurse | Refresher (incl. special variants), Update Refresher, Fortbildungstage, Studien- & Kongressupdates, SGMO Curriculum; on site and as livestream |
| Webinare | WebUp, WebUp Experten-Forum (WUEX), WebUp im Fokus (WUIF), Onko Experten-Forum, WebUp Skills; free for participants, financed by sponsoring |
| OnDemand | CME OnDemand (On-Demand Accredited, see `products/on-demand-accredited.md`), Vorträge OnDemand, SummedUp, Skills, Fachzertifikate, Kursbücher, MedKit |
| Facharztvorbereitung | SYFAT (`products/syfat.md`); livestream courses from 2027 |
| Pakete & Abos | FOMF All Access (Free, Lite/Residency, Online, Hybrid, Klinik, Klinik+), PJ-Begleiter, Pflege Kompetenz Plus |
| Tools | Eviplex (`../../eviplex/knowledge/`), AI search in the learning portal |
| Sponsoring | Package groups × package levels × price axes, plus add-ons; sold as HubSpot deals |

Two customer sides: participants (B2C, and B2B memberships for clinics and practices) and industry partners (sponsoring).

## Rules that matter for any text or analysis

- **Company figures:** use only the official "FOMF in Zahlen" page (updated on 15 Jan and 15 Jul), linked from the Produktwelt page. As of 15 Jul 2026: 140,000+ registered users (AT, DE, CH and CMED UK), 13,500+ paying members (B2B and B2C), 86,000+ course participations.
- **Naming:** externally only „FOMF All Access Fortbildungspaket", „FOMF All Access Paket" or „FOMF All Access", never „Mitgliedschaft" (since 1 Sep 2026; Linear PLA-1944). Internal analyses may say "membership" for the data concept.
- **No exam simulations today:** neither SYFAT, Refresher nor All Access is a simulated oral specialist exam; don't promise one. The planned SYFAT livestream courses (from 2027) may include exam simulations, but that is a plan, not built (Mahyar, 17 Nov 2026).
- **Pflege Kompetenz Plus** is its own annual subscription, not an All Access package.
- **B2B requests** (clinics, practices, teams) go to membership@fomf.org.
- **All Access prices:** only from the "FOMF All Access" page (https://app.notion.com/p/fomf/FOMF-All-Access-12d7afedf30980ca8bb2ff2f0ace6e9c; last edited 3 Nov 2026). There, Online is 670 € (DE, AT) and 990 CHF (CH); the 580 € on the SYFAT project page is outdated. The same page lists the Eviplex Plus and Pro terms per All Access tier.
- **Course prices:** re-read before quoting. On fomf.de, prices are rendered client-side: read `/content/<slug>` (`participantTypePrices`, in cents).

## Added here

- **Price increase 2026:** new members from 1 Sep 2026; existing members at renewal from 1 Oct 2026, announced by email 60 days before renewal. Its effect: `b2c-members.md`.
- **Ärztekammer Wien:** a streaming cooperation bringing ÄKW's doctors onto fomf.at from 01.02.2027 (topic `../aekw/`, confidential until ÄKW releases the award).
- **CMED UK** runs partly on the legacy Drupal stack (`legacy.cmed.org.uk`, see `tech-and-security.md`); the B2C analyses cover DACH only.
- **Not written down anywhere yet:** positioning per audience and against competitors; the pricing logic across All Access tiers, single courses and B2B.
