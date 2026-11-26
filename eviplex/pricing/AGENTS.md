# Eviplex pricing

Prices and question quotas of the Eviplex B2C tiers (Free, Plus, Pro) in DE/AT and CH, monthly and yearly. Mahyar (Eviplex PM) owns it and works it out with Wafa; started 25 Nov 2026 from their talk on lowering prices and quotas. It also covers the annual-payment pricing fix (CTO-16).

## Status

**As of 26 Nov 2026:** A proposal exists (table below): Free from 30 to 15 questions, Plus DE/AT €19.90 / €199.90 with 75 questions, Plus CH CHF 39.90 / 405.90 with 150, Pro DE/AT €72.90 / €742.90 and Pro CH CHF 72.90 / 742.90 with 300 each. Nothing is decided. A worst-case cost check at 10 ct per question shows every tier in profit at full use (lowest break-even: Pro DE/AT yearly at 17 ct per question). The prices live today in Stripe; what is live is not recorded here.

- **Next step:** check what is live today in Stripe and on eviplex.com, confirm the real cost per question (heavy users included), then settle the proposal with Wafa. (Mahyar, by 27 Nov)
- **Next date:** check-in 27 Nov 2026 (CTO-30).
- **Waiting on:** Mahyar.

### Proposal (Mahyar with Wafa, 25 Nov 2026, not decided)

| Tier | Monthly | Yearly | Questions per month |
|---|---|---|---|
| Free | – | – | 15 (today 30) |
| Plus DE/AT | €19.90 | €199.90 | 75 (today 150) |
| Plus CH | CHF 39.90 | CHF 405.90 | 150 |
| Pro DE/AT | €72.90 | €742.90 | 300 |
| Pro CH | CHF 72.90 | CHF 742.90 | 300 |

### Cost check (session with Mahyar, 25 Nov 2026)

Assumption: 10 ct per question (Mahyar's figure, not yet sourced), every question of the quota used, VAT removed (AT 20 % for DE/AT as the worse case, CH 8.1 %), payment fees and fixed costs left out.

| Tier | Net / month | Max cost | Margin at full use | Break-even per question |
|---|---|---|---|---|
| Plus DE/AT monthly | €16.58 | €7.50 | €9.08 (55 %) | 22 ct |
| Plus DE/AT yearly | €13.88 | €7.50 | €6.38 (46 %) | 19 ct |
| Plus CH monthly | CHF 36.91 | ~CHF 15 | CHF 21.91 (59 %) | 25 ct |
| Plus CH yearly | CHF 31.29 | ~CHF 15 | CHF 16.29 (52 %) | 21 ct |
| Pro DE/AT monthly | €60.75 | €30 | €30.75 (51 %) | 20 ct |
| Pro DE/AT yearly | €51.59 | €30 | €21.59 (42 %) | 17 ct |
| Pro CH monthly | CHF 67.44 | ~CHF 30 | CHF 37.44 (56 %) | 22 ct |
| Pro CH yearly | CHF 57.27 | ~CHF 30 | CHF 27.27 (48 %) | 19 ct |

## Goal

Prices and quotas decided with Wafa, live in Stripe and the backend quota, and the plan copy, CS wording and `../AGENTS.md` updated. Annual-payment pricing fixed (CTO-16). Date not set.

## People

| Who | Role here |
|---|---|
| Mahyar | Eviplex PM; owns pricing and this topic |
| Wafa (Wafa Enayati) | Co-founder; decides prices and quotas with Mahyar; drives B2B and partners |
| Raphaela | Head of Customer Support; needs the new quota wording |
| Shadi, Anika Kröll | Brand owners; sign off the changed plan copy |

## Open points

- The 10 ct per question: is it the average over all questions, and do heavy users (long follow-ups) cost more? Source it from the cost metrics. (owner: Mahyar)
- Free at 15 instead of 30 halves the most a free user can cost (€3.00 to €1.50 a month); its effect on conversion is unknown. (owner: Mahyar)
- All Access members get Plus through the cross-sell; if it is included, those users cost money without Eviplex revenue. Check their terms on Notion "FOMF All Access". (owner: Mahyar)
- CH Pro has the same number as DE/AT Pro (72.90) but in CHF, while CH Plus is twice DE/AT Plus. In CH, Pro costs 1.8× Plus for 2× the questions; in DE/AT it costs 3.7× for 4×. Intended? (owner: Mahyar with Wafa)
- Plus DE/AT at 75 questions sits next to the Romania partner assumption of €14.90 with 75 questions (`../partnermodell/`). Keep the two consistent. (owner: Mahyar)
- What the annual-payment fix (CTO-16) is about is not recorded. (owner: Mahyar)
- No in-app purchase code found in the meviq repo (25 Nov 2026), so no App Store / Play Store cut assumed. If app sales come (CTO-15), Plus DE/AT yearly would keep about €2 margin at full use. (owner: Mahyar)

## Rules

- Prices, quotas and the cost per question are confidential: they stay in this folder, never on a Linear issue or in external tools.
- Prices are true only in Stripe and the backend billing plan registry; never quote a live price from this file.
- Once decided, change these together: Stripe, `chatConfig.quota` in the meviq backend, the plan copy in `web/shared-ui/pricing/plan-content.ts` (the "+500 % / +1.000 %" lines), the CS rulebook in Notion, `../AGENTS.md` (Tiers) and `../knowledge/support.md`. The code changes land in the meviq repo as EVP product work.

## Source map

Where this topic lives outside this folder. A catch-up searches every row.

| Where | What to search or open |
|---|---|
| Outlook | Search `Eviplex Preis`, `Preisänderung`, `Kontingent`, `Wafa`. None found yet. |
| Teams | Mahyar's 1:1 chat with Wafa; search `Preis`, `Kontingent`, `Eviplex`. Not searched yet. |
| Slack | none |
| SharePoint | Sales Membership › Preislisten GMS › "2025_08_Staffelpreise GMS DE-AT-CH inkl. Klinik-Modell.xlsx" (Eviplex block, hospital prices). The proposal spreadsheet from 25 Nov: location not recorded (screenshot in the session only). |
| Notion | "FOMF All Access" (Eviplex terms for members per tier); Eviplex CS rulebook "Eviplex – Customer Support: Zuständigkeiten, Abläufe & verbindliche Aussagen". |
| Linear | Board issue CTO-30 (private team cto-assistant), sub-issue CTO-16 (annual payments); related CTO-15 (selling outside the app stores). Product work in team EVP: none yet. |
| Other | Stripe (live prices); meviq repo: `chatConfig.quota`, `web/shared-ui/pricing/plan-content.ts`; eviplex.com pricing page. |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
