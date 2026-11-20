# Enterprise AI platform

Which AI platform FOMF gives its non-technical departments (sales, marketing, events, customer service, operations, finance), and on what terms. Today that is Claude Enterprise; Glean, Langdock and Google's Gemini Enterprise are the alternatives on the table. Owner: Mahyar, with Andreas Langer (IT). Opened as a topic on 19 Nov 2026 from board issue CTO-8; the Claude Enterprise roll-out behind it dates from the Executive Board decision of 13 Jul 2026.

## Status

**As of 19 Nov 2026:** No decision. Preference: keep Claude if the data question can be solved; the issue is processing outside the EU for sales (sponsor data) and events (speaker contracts). The facts are researched (`research-claude-vs-eu-hosting-2026-11-19.md`); the questions for Anthropic, counsel and Langdock are not yet sent. Claude Enterprise runs for the non-technical departments (35 seats, prepaid to Jul 2027); Product & Engineering stays on Claude Team. The Glean evaluation is paused since 5 Nov. One Langdock Business seat is on trial until 22 Nov. Google has never sent the Gemini Enterprise offer (CTO-7). Mahyar has the ball.

- **Next step:** pick the option to pursue; send the open questions to the Anthropic account team and counsel (Mahyar)
- **Next date:** 9 Dec 2026, when Microsoft switches Claude on in Copilot for tenants without a setting (CTO-25, due 4 Dec); Claude Enterprise renewal in Jul 2027
- **Waiting on:** Google, for the Gemini Enterprise offer (open since Jul 2026)

## What we know (19 Nov 2026)

Details and sources in `research-claude-vs-eu-hosting-2026-11-19.md`.

- **claude.ai Enterprise has no EU residency.** Data is stored in the US; processing may run in the US, Europe, Asia or Australia. Only a US-only inference setting exists. EU-only Claude exists only via cloud APIs (AWS Bedrock EU profiles; Vertex), not in claude.ai.
- **No zero retention for Enterprise chat or Cowork.** Default is indefinite; custom retention down to 30 days (projects must be set separately). Local Cowork history sits on laptops outside retention. No training on FOMF data, except chats sent as feedback (kept 5 years; admins can switch rating off).
- **Contract:** Anthropic Ireland, Irish law; US transfers under EU SCCs (Modules 2 and 3) plus Swiss and UK addenda. The DPA does not use the EU-US Data Privacy Framework.
- **Law:** the DPF stands (General Court, 3 Sep 2025; appeal pending). German DSK guidance asks for an Art. 28 agreement, no training on inputs, Chapter V transfers, written internal rules, a DPIA check and staff training.
- **Langdock (vendor claims):** EU on Azure; lists Claude Opus 4.8 and Sonnet 4.6 as EU, behind Anthropic's current 5.x; host of the Claude models not named; no Notion, HubSpot, Slack or Linear connectors found; €23.20–31.20 per seat per month on annual billing.
- **Microsoft 365 Copilot:** Claude moves into the EU Data Boundary in early Dec 2026; on 9 Dec Microsoft switches it on for tenants that made no selection.

## Current set-up

| Product | Who | Seats | Cost (latest known) |
|---|---|---|---|
| Claude Team | Product & Engineering (Claude Code, Claude Design) | 32 (14 Premium, 18 Standard) | €1,852/month |
| Claude Enterprise | Other departments | 35 | $8,400/year seats, prepaid Jul 2026 to Jul 2027; usage credits on top, about $1,900 in Sep 2026 |
| Claude API | Internal agents | – | about $270 in Sep 2026 |
| Microsoft 365 Copilot | Unknown | Unknown | Billed monthly, one-year commitment |
| Langdock Business | Trial | 1 | €29/month |

Source: Mahyar's spend snapshot to Glean, 8 Oct 2026; invoices in Outlook. Plan for 70 to 80 users once the next 35 to 45 are onboarded. Mahyar's estimate on 8 Oct: 70 to 80 Enterprise users would cost about $5–8k/month on Claude.

## Goal

A decision on the platform for the non-technical departments, made in time to act before the Claude Enterprise renewal in Jul 2027, that meets the criteria below at a cost FOMF can justify for every employee. Date for the decision: to be set by Mahyar.

**Criteria named so far** (Mahyar to Glean, 29 Sep 2026): data retention (zero or short), EU data residency, cost per moderate user, one permission-aware search across SharePoint, Outlook, Notion, Slack, Linear and HubSpot, and agents grounded in company data that non-technical teams can build and use.

## People

| Who | Role here |
|---|---|
| Mahyar | Owner; decides with the Executive Board |
| Andreas Langer | Head of IT; joined the Glean calls (from his private address) |
| Habib | Executive Board; asked for individual Claude access for marketing (Aug 2026) |
| William O'Brien, Jack VandeMerkt, Nickhil Kumar | Glean (Account Executive, colleague, first contact) |
| Stefanie Wonneberger, Laura | Google interim account team since 30 Oct 2026; Alexandra Vassileva handed over |

## Open points

- Which option to pursue: Claude for all with rules and settings, a split by data type, an EU platform with Claude models, Claude via Copilot, a custom connector that pseudonymises or processes sponsor and speaker data in the EU before Claude sees it, or waiting for Anthropic EU residency (Mahyar)
- For the Anthropic account team: EU residency plans and dates; what the Enterprise geolocation and US-only settings do; sub-processor list; shorter or zero retention for chat by agreement (Mahyar)
- For counsel: is Anthropic on the DPF list; does FOMF need its own transfer impact assessment under the SCCs; DPIA for speaker bank data and sponsor contacts; works agreement for the roll-out (Mahyar, counsel)
- For Langdock: who hosts the Claude models and where; retention terms with that host; Claude versions in the EU; AVV; missing connectors (Mahyar)
- What sales and events actually put into Claude: which tasks involve personal data (Mahyar with the ambassadors)
- Which "other solutions" are on the shortlist besides Glean and Langdock (Mahyar)
- Does FOMF still pay for ChatGPT Enterprise? Glean's recap of 21 Sep says FOMF uses it; nothing else in the mail confirms it (Mahyar)
- How many Microsoft 365 Copilot licences FOMF holds and who uses them (Andreas)
- Google's Gemini Enterprise offer, promised since Jul 2026 (Google account team, CTO-7)
- Does § 203 / patient data matter here, or only for Eviplex? If staff may paste medical or pharma partner data, the same AVV questions as in `eviplex/avv/` apply (Mahyar)

## Rules

- Vendor prices and quotes stay in this folder, never on a Linear issue.
- Drafts to the Executive Board in German; to vendors in English.
- Research findings are sourced facts only; vendor claims are marked as claims.

## Source map

| Where | What to search or open |
|---|---|
| Outlook | "Glean vs Claude eval", "Recap and next steps: Glean × FOMF", "Glean <> FOMF", "Questions before tomorrow" (Glean); "Urgent: Gemini API Usage / Privacy Agreement", "Agentspace Information and Security aspect" (Google); "personalisierte Accounts für MKT Mitarbeiter für claude" (Habib); Langdock and Microsoft invoices |
| Teams | Chat with Alexandra Vassileva's forwarded note on Gemini Enterprise ZDR (22 Jul 2026); Jaquelin Matthes asking for Claude Enterprise or Copilot (24 Jul 2026) |
| Slack | none so far |
| SharePoint | none so far |
| Notion | Decisions database: "Claude / AI Implementation" (13 Jul 2026) |
| Linear | Board issue CTO-8 (private team cto-assistant); sub-issue CTO-7 (Google's offer) |
| Other | Glean decks attached to the 21 Sep recap mail; Claude Enterprise admin console (seats, usage) |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
| `research-claude-vs-eu-hosting-2026-11-19.md` | Sourced research: Claude data location, retention, DPA; Langdock; GDPR and DSK; Copilot with Claude |
