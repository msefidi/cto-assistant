# Eviplex

Product folder: what stays true about Eviplex. Read this brief before any Eviplex work, then the file in this folder that fits the task. It is not a topic: deals, projects and their status live in the topic folders listed at the end. Owner: Mahyar (Eviplex PM).

## What it is

Eviplex is an AI-supported information system for physicians in hospitals and practices. It analyses international medical guidelines and current studies and returns structured, evidence-based answers with their sources, complemented by FOMF expert lectures. The physician checks, judges and decides; Eviplex finds, structures and presents evidence. (meviq `brand/README.md`)

- **Audience:** licensed physicians, who register with their EFN; the messaging also speaks to advanced medical students (PJ, WSJ, KPJ). Pharmacists, nursing staff and MFA follow later.
- **History:** development started June 2025; v1 launched quietly in December 2025 (about 500 users); answer-quality issues led to a rewrite. Answer quality, latency and cost per question are now at acceptable levels (figures to come from Braintrust and the cost metrics, Mahyar). Formerly **Meviq**; the repo and the GCP project still carry that name.
- **Not a medical device** under the MDR. Every wording must keep it that way, see `knowledge/claims-and-legal.md`.

## Legal set-up

- **Eviplex GmbH** (founded 2026 as a spin-off of FOMF) brings the product to market. It holds the regulatory risk and the liability (EU AI Act, MDR), is the GDPR **controller**, and owns the brand and trademark.
- **FOMF** is the asset company and SaaS provider: code, IP, hosting and the curated medical knowledge base. It is the GDPR **processor**.
- Between them: data processing agreements (AVV) and a cooperation contract on IP, licence and intercompany terms. Their status is in the topics, see `avv/`.

## Tiers

| Tier | Name in code | Questions per month | § 203 tier | Notes |
|---|---|---|---|---|
| Free | `starter` | 30 | no | Warns when a real patient name is entered |
| Plus | `plus` | 150 | yes | Highlighted on the pricing page; cross-sold to FOMF All Access members |
| Pro | `pro` | 300 | yes | |
| Anonymous | – | 3 messages | no | No account |

- Quotas: Mahyar, 12 Nov 2026 (Plus is 150, never 300). The values come from `chatConfig.quota` in the meviq backend.
- Plus and Pro are the § 203 tiers ("Erweiterter Datenschutz"). Their Patient Context feature (named patient records) holds **no documents** today (Mahyar, 17 Nov 2026).
- **Prices** come from Stripe through the backend billing plan registry; the plan copy is in `web/shared-ui/pricing/plan-content.ts`. Never quote a price from memory: check eviplex.com or the code.

## Areas

The roadmap is organised by the Linear **Tracks**: Core product · Answer quality · Growth · Admin & analytics · Tech health · Product research and UX. The current projects and owners are in the Linear roadmap view and the latest weekly memo (`weekly/`); how Linear is set up is in `knowledge/pm.md`.

## People

| Who | Role for Eviplex |
|---|---|
| Mahyar | PM; runs the Friday Eviplex weekly; owns the EVP Linear team |
| Max | Medical lead; owns the professional-secrecy (§ 203) project |
| Shadi | Designer; brand owner with Anika, signs off claims |
| Anika Kröll | Marketing manager; brand owner with Shadi; reviews brand PRs; write to her in German |
| Bardia | Designer |
| Parham, Josip (mobile), Viktor (frontend TL) | Engineering |
| Anah, Ehsan | Data engineering, data science |
| Habib | CGO and Geschäftsführer; owns the AVV, the terms of use and the FOMF↔Eviplex agreements |
| Wafa | Co-founder; drives B2B sales (CH hospitals) and partners |
| Felix Dümpert | Data protection officer |
| Raphaela | Head of FOMF Customer Support, which handles all Eviplex customer contact |
| Benignia | FOMF CH office; sells to Swiss hospitals with Wafa |

## Stack

Repo `fomf-code/meviq` (local checkout `/Users/mahyar/Development/Repositories/fomf/meviq`): Node.js backend services with the Vercel AI SDK, Next.js web app and marketing site, mobile app. GCP project `meviq-prod`. Evals and traces in Braintrust; product analytics in Mixpanel; errors in Sentry. Code changes land in the meviq repo, never in this workspace.

## Where the sources live

Point to these; do not copy them into this folder.

| What | Where |
|---|---|
| Eviplex terms for FOMF All Access members, per tier | Notion "FOMF All Access": https://app.notion.com/p/fomf/FOMF-All-Access-12d7afedf30980ca8bb2ff2f0ace6e9c |
| Messages, voice, claims, official German texts | meviq `brand/README.md` and `brand/texts.de.md` (owners Shadi and Anika) |
| Look: colours, logo, assets | meviq `web/shared-brand`; design system artifact "EVP - DS Web" |
| Website copy | meviq `web/marketing/messages/de-DE.json` |
| Roadmap and issues | Linear team EVP, roadmap view https://linear.app/fomf/projects/view/eviplex-b5e71e7aedfe |
| Product pages | Notion Eviplex/Meviq teamspace › 01 - Product (CS page, KIS research) |
| Marketing material | Notion 03 - Marketing / Brand; SharePoint eng › 09-Eviplex/Marketing Planung/03_Pitches |
| Escalations | Slack #triage-eviplex |

## Files in this folder

| File | What |
|---|---|
| `knowledge/positioning.md` | Core message, markets and channels, differentiation, competitors, the MDR line |
| `knowledge/claims-and-legal.md` | What we may and may not claim: § 203, hosting, countries, uploads |
| `knowledge/support.md` | How Customer Support handles Eviplex: owners, addresses, quotas, escalation |
| `knowledge/brand.md` | How brand work is organised and synced |
| `knowledge/pm.md` | Linear scheme, weekly memo, changelog |

## Topics about Eviplex

Active: `avv/` (AVV and secrecy agreement, Google PSA), `partnermodell/` (partner commissions), `documents/` (patient documents in Eviplex), `tmn-press/` (press coverage vs. traffic). Recurring: `weekly/`, `changelog/`. Done: `../archive/eviplex-uae-pitch/`. The security assessment `../cybersecurity/` covers Eviplex too.

## Keeping this folder current

- Rewrite a line when its fact changes, and put who said it and when in brackets. Do not add "update" paragraphs.
- Status, dates and next steps belong in the topics, not here.
- A fact that is not confirmed is marked "not confirmed" or left out.
