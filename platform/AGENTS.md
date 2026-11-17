# Learning platform

Product folder: what stays true about FOMF's learning platform (fomf.de, fomf.at, fomf.ch). Read this brief before any platform work, then the file in this folder that fits the task. It is not a topic: mandates, deals and their status live in the topic folders listed at the end.

## What it is

Medical continuing and specialist education, mostly CME (DFP in Austria), for physicians in every career stage, from the practical year to the specialist exam and ongoing CME, plus offers for nursing staff. Markets: fomf.de, fomf.at, fomf.ch and CMED UK. Two customer sides: participants (B2C, and B2B memberships for clinics and practices) and industry partners (sponsoring).

**The source of truth for FOMF's products, for now, is the Notion page "Produktwelt bei FOMF"** (Stand 29 Sep 2026): https://app.notion.com/p/fomf/Produktwelt-bei-FOMF-3ea7afedf309808e8bfcf1891a76175e (Mahyar, 17 Nov 2026), except for All Access tiers and prices (Notion "FOMF All Access") and for Eviplex (`../eviplex/knowledge/`). `knowledge/offer.md` orients and lists the rules that matter.

## Products

| Product | File | Owner |
|---|---|---|
| FOMF All Access (Free, Lite, Online, Hybrid, Praktisches Jahr, Klinik, Klinik+) | Notion "FOMF All Access" (tiers and prices), `knowledge/offer.md`, `knowledge/b2c-members.md` | – |
| On-Demand Accredited | `knowledge/products/on-demand-accredited.md` | Isgard Eyberg (project lead); commercials: Mahyar |
| SYFAT (specialist-exam preparation) | `knowledge/products/syfat.md` | Marie Fiebig (business owner); commercials: Mahyar |
| Live courses, webinars, other OnDemand, PJ-Begleiter, Pflege Kompetenz Plus, sponsoring | Produktwelt page | not recorded |
| FOMF Psychology Academy (in development) | Produktwelt page, section 11 | not recorded |

Mahyar owns the commercials of SYFAT and On-Demand Accredited (since Sep 2026, outside the CTO role): goal 2× B2C revenue by Sep 2027; the mandates are in `syfat/` and `on-demand-accredited/`.

## People

| Who | Role for the platform |
|---|---|
| Vahid | PM, Platform team |
| George | EM, Platform team |
| Kamran, Ignasi, Raman, Matheo, Rahim (also backend TL) | Engineers, Platform team |
| Shadi | Designer, Platform team |
| Viktor | Frontend TL |
| Simone | EM, Productivity team (internal back offices in Retool): Nikola, Tomislav, Borna, Farzam |
| Marie Fiebig | SYFAT business owner (a doctor) |
| Isgard Eyberg | On-Demand Accredited project lead |
| Tina Hoffmann | Marketing (Google Ads, On-Demand) |
| Raphaela | Head of Customer Support |
| Andreas Eberl | Holds the relationship with Ärztekammer Wien |

The medical team owns course content. Habib's EB project "PA-analysis" (SharePoint EB site) is the reference for print-mailing economics.

## Files in this folder

| File | What |
|---|---|
| `knowledge/offer.md` | Orientation over the product families, rules that matter (naming, figures, no exam simulations), what the Notion page does not say |
| `knowledge/b2c-members.md` | Agreed definitions and what we know about members: renewal, churn, acquisition, numbers by product |
| `knowledge/data.md` | Where the data lives: BigQuery tables, Metabase, how to query |
| `knowledge/tech-and-security.md` | Stack, legacy systems, incidents, bot traffic |
| `knowledge/products/` | One file per product: what it is, catalogue, prices, packaging, data model, audience |

## Where the sources live

| What | Where |
|---|---|
| Products and team rules | Notion "Produktwelt bei FOMF" (source of truth for now; not for Eviplex) |
| All Access tiers and prices | Notion "FOMF All Access": https://app.notion.com/p/fomf/FOMF-All-Access-12d7afedf30980ca8bb2ff2f0ace6e9c |
| Company figures | Notion "FOMF in Zahlen" (updated 15 Jan and 15 Jul) |
| Live offer and prices | fomf.de (`/content/<slug>`), fomf.at, fomf.ch |
| Product and project pages | Notion Product & Engineering; Marie's SYFAT page; Isgard's "OnDemand akkreditierte Kurse" |
| Roadmap and issues | Linear, Platform team (PLA) and Marketing & SEO (MKS) |
| Numbers | BigQuery `fomf-dl` and Metabase, see `knowledge/data.md` |
| Marketing and CRM | HubSpot |
| Strategy | Notion Executive Board space |

## Topics about the platform

Active: `syfat/`, `on-demand-accredited/`, `aekw/`; the security assessment `../cybersecurity/` covers it too. Done: the B2C analyses in `../archive/` (listed at the end of `knowledge/b2c-members.md`).

## Keeping this folder current

- Rewrite a line when its fact changes, and put who said it and when in brackets. Do not add "update" paragraphs.
- Status, dates and next steps belong in the topics, not here.
- A new analysis changes `knowledge/b2c-members.md` (one line per finding) and keeps its SQL in its own folder.
