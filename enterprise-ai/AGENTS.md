# Enterprise AI platform

Which AI platform FOMF gives its non-technical departments (sales, marketing, events, customer service, operations, finance), and on what terms. Today that is Claude Enterprise; Glean, Langdock and Google's Gemini Enterprise are the alternatives on the table. Owner: Mahyar, with Andreas Langer (IT). Opened as a topic on 19 Nov 2026 from board issue CTO-8; the Claude Enterprise roll-out behind it dates from the Executive Board decision of 13 Jul 2026.

## Status

**As of 23 Nov 2026:** A Langdock pilot is decided, the platform is not. The Executive Board decided on 23 Nov to pilot Langdock with about 20 people for one month, until 15 Dec 2026. The initiative owners from the team event were proposed as participants. The proposed split: Langdock for sensitive data and broad team use; Claude stays for Product, Marketing and parts of the medical team. The final decision and the number of licences follow from the pilot. Governance and training run in parallel: a draft AI usage policy and an AI inventory template exist; no AI officer is named yet. Cost, security and migration are open; skills can be carried over and apps may need migrating. Langdock's written answers on hosting, retention, the DPA and usage limits are not yet requested. Staff have been told since 29 Oct that Claude is for general use only (no contracts, contact data or other personal data). Claude Enterprise runs for the non-technical departments (35 seats, prepaid to Jul 2027); Product & Engineering stays on Claude Team. The one Langdock trial seat runs to 22 Dec. The Glean evaluation is paused since 5 Nov; Google has never sent the Gemini Enterprise offer (CTO-7). Mahyar has the ball: set up the pilot.

- **Next step:** set up the Langdock pilot workspace and accounts for about 20 people (plan, EU-only models, retention setting) and collect feedback; send Langdock the open questions in writing (Mahyar)
- **Next date:** 1 Dec 2026, 11:00, onboarding of Wafa and Sina; 15 Dec 2026, end of the pilot; 9 Dec 2026, Microsoft switches Claude on in Copilot for tenants without a setting (CTO-25, due 4 Dec); 22 Dec 2026, Langdock trial seat renews
- **Waiting on:** Google, for the Gemini Enterprise offer (open since Jul 2026)

## What we know (19 Nov 2026)

- **claude.ai Enterprise has no EU residency.** Data is stored in the US; processing may run in the US, Europe, Asia or Australia. Only a US-only inference setting exists. EU-only Claude exists only via cloud APIs (AWS Bedrock EU profiles; Vertex), not in claude.ai.
- **No zero retention for Enterprise chat or Cowork.** Default is indefinite; custom retention down to 30 days (projects must be set separately). Local Cowork history sits on laptops outside retention. No training on FOMF data, except chats sent as feedback (kept 5 years; admins can switch rating off).
- **Contract:** Anthropic Ireland, Irish law; US transfers under EU SCCs (Modules 2 and 3) plus Swiss and UK addenda. The DPA does not use the EU-US Data Privacy Framework.
- **Law:** the DPF stands (General Court, 3 Sep 2025; appeal pending). German DSK guidance asks for an Art. 28 agreement, no training on inputs, Chapter V transfers, written internal rules, a DPIA check and staff training.
- **Langdock (vendor claims, checked 23 Nov 2026):** platform on Azure in Frankfurt; every Claude model including Opus 5.5 marked EU-hosted, served via Vertex and Bedrock (which model on which provider not stated; Anthropic itself named in the API docs but not in the DPA); claims zero retention at the model providers except Fable 5.x (30 days); chat retention settable down to 7 days; DPA under German law, sub-processors in the EU except Sentry and Cloudflare; ISO 27001, SOC 2 Type II; usage limits per 5-hour and weekly window are the main user complaint; native integrations (directory read 23 Nov 2026) for Notion, HubSpot, Slack, Linear, SharePoint, OneDrive, Outlook, Teams, Metabase (API key), BigQuery, Google Drive, Confluence and Jira, per-user OAuth, read and write, plus custom MCP servers and custom integrations; €23.20–31.20 per seat per month on annual billing.
- **Microsoft 365 Copilot:** runs under the Microsoft contract and DPA FOMF already has for SharePoint and Outlook. For EU customers it is an EU Data Boundary service ("EU traffic stays within the EU Data Boundary"); interactions are stored in the tenant's region, not used for training, retention set in Purview. Not zero retention. Microsoft's page also says LLM calls can go to other regions at high utilisation, with no explicit EU carve-out: to be confirmed for our tenant. Claude moves into the EU Data Boundary in early Dec 2026; on 9 Dec Microsoft switches it on for tenants that made no selection.
- **Glean (vendor claims):** Canvas makes documents, slides and interactive artifacts shared by link (out of preview since Jul 2026, possibly usage-priced); a remote MCP server makes Glean the knowledge layer inside Claude and Claude Code, permission-aware per user. EU residency and zero retention are not publicly documented. Figure of 2 Oct 2026: $85k per year without implementation, with no seat count in writing and given before FOMF sent its user numbers; no revised quote after the cost call of 9 Oct; token costs may come on top.
- **Copilot artifacts and knowledge:** Copilot Pages hold lightweight interactive apps and are shared like a file; outputs are otherwise Word, Excel and PowerPoint files in OneDrive and SharePoint. Microsoft-built federated connectors (live fetch, no index) exist for Notion, HubSpot, Linear and Slack, without a preview label in the gallery of 16 Nov 2026. None for Metabase or BigQuery; Metabase would need a custom connector on its own MCP server, untested.
- **Gemini Enterprise:** a separate app with connectors to SharePoint, Outlook and OneDrive; FOMF does not run on Google Workspace. Data residency only in the Standard and Plus editions; no offer from Google yet.

## Current set-up

| Product | Who | Seats | Cost (latest known) |
|---|---|---|---|
| Claude Team | Product & Engineering (Claude Code, Claude Design) | 32 (14 Premium, 18 Standard) | €1,852/month |
| Claude Enterprise | Other departments | 35 | $8,400/year seats, prepaid Jul 2026 to Jul 2027; usage credits on top, about $1,900 in Sep 2026 |
| Claude API | Internal agents | – | about $270 in Sep 2026 |
| Microsoft 365 Copilot (add-on) | Mahyar (since 23 Nov 2026); second seat unknown | 2 on the invoice to Sina's billing profile; other purchase channels not checked | €27.30 per seat per month net, billed monthly, one-year commitment |
| Langdock Core | Trial | 1 | €29/month, renewed to 22 Dec 2026 |

Source: Mahyar's spend snapshot to Glean, 8 Oct 2026; invoices in Outlook (Microsoft G196095340 of 5 Nov 2026, Langdock #2552-7832 of 22 Nov 2026). Plan for 70 to 80 users once the next 35 to 45 are onboarded. Mahyar's estimate on 8 Oct: 70 to 80 Enterprise users would cost about $5–8k/month on Claude.

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

- Langdock pilot: which FOMF company the workspace is billed to (it becomes the party to Langdock's data processing agreement, which needs no signature; question for Felix Dümpert), which plan (Core or Work, monthly billing), who the about 20 participants are, which workspace settings (EU-only models, retention), and how feedback is collected by 15 Dec (Mahyar)
- Final platform decision after the pilot: number of Langdock seats and Max seats, who keeps Claude, migration of Claude projects, skills and apps (Mahyar, Executive Board)
- AI governance (EU AI Act): name an AI officer; finalise the draft AI usage policy with a short legal review and have it approved for DE, AT and CH; keep the AI inventory; make a gate process binding (no new AI feature without an Annex III check); training plan for the AI Act and data protection with proof of attendance (Executive Board)
- For the Anthropic account team: EU residency plans and dates; what the Enterprise geolocation and US-only settings do; sub-processor list; shorter or zero retention for chat by agreement (Mahyar)
- For counsel: is Anthropic on the DPF list; does FOMF need its own transfer impact assessment under the SCCs; DPIA for speaker bank data and sponsor contacts; works agreement for the roll-out (Mahyar, counsel)
- For Langdock, in writing: which provider and region serves each Claude model; why Anthropic is not in the DPA; whether Microsoft's end of Modified Abuse Monitoring for new models affects zero retention; a hard EU-only lock; usage limits per seat (tokens or messages per window and model), whether Max seats (5× limits, €99 Core / €109 Work) can be assigned per person, and whether limits can change in the term; which plan has retention settings and audit logs; the live sub-processor list and the professional-secrecy addendum (Mahyar)
- What sales and events actually put into Claude: which tasks involve personal data (Mahyar with the ambassadors)
- Which "other solutions" are on the shortlist besides Glean and Langdock (Mahyar)
- Does FOMF still pay for ChatGPT Enterprise? Glean's recap of 21 Sep says FOMF uses it; nothing else in the mail confirms it (Mahyar)
- Microsoft 365 Copilot: which Microsoft 365 plan FOMF is on (decides Copilot Business or the standard add-on), who uses the 2 licences, whether more are bought elsewhere, and whether SharePoint permissions are clean enough for Copilot (Andreas)
- Does Copilot inference for our tenant always stay in the EU, given the "high utilisation" sentence on Microsoft's privacy page (Andreas, counsel)
- What happens to the 35 prepaid Claude Enterprise seats and to the 2 Copilot licences (one-year commitment) once Langdock is chosen (Mahyar, Executive Board)
- Whether the Langdock trial seat becomes part of the pilot workspace or is cancelled before 22 Dec (Mahyar)
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
| Notion | Decisions database: "Claude / AI Implementation" (13 Jul 2026); Executive Board Meetings database, page "2026.11.23" (pilot decision, governance duties, inventory template attached); page "Entwurf FOMF-KI-Nutzungsrichtlinie" (draft AI usage policy) |
| Linear | Board issue CTO-8 (private team cto-assistant); sub-issue CTO-7 (Google's offer) |
| Other | Glean decks attached to the 21 Sep recap mail; Claude Enterprise admin console (seats, usage) |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
| `langdock/company-description.md` | Draft of the Langdock workspace company description (German), from the Notion product pages |
| `eb-slides-2026-11-23/` | Deck for the Executive Board of 23 Nov 2026 (recommendation, comparison, costs) |
