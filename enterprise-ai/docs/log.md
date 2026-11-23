# Enterprise AI platform: log

Newest first. One entry per event or result. Decisions go in `decisions.md`, one line each. Each entry ends with who said it and where, in brackets. Summarise the source; the original stays where it is.

## 2026-11-23: Executive Board decides on a Langdock pilot

Mahyar presented the deck in `eb-slides-2026-11-23/`, which recommended Langdock for the departments, Claude for P&E and Copilot as fallback. The board decided on a pilot: about 20 people for one month, until 15 Dec. The proposed split is Langdock for sensitive data and broad team use, and Claude for Product, Marketing and parts of the medical team. The final decision and the licence count come after the pilot. Governance runs in parallel under the EU AI Act: as a deployer, FOMF needs a policy, an inventory and training with proof of attendance (Art. 4, 5). As a provider (learning platform, Eviplex), FOMF must avoid the high-risk category. A draft policy and an inventory template exist; the AI officer is not named. Onboarding of Wafa and Sina is on 1 Dec at 11:00. The board's notes repeat Langdock's own claims on EU hosting and zero retention, which are not yet confirmed in writing. (Executive Board; Notion Meetings, page "2026.11.23")

## 2026-11-23: Langdock checked (vendor claims)

Read on Langdock's own pages (models, docs, Terms and DPA v2.1, pricing):
- **Hosting:** platform on Azure in Frankfurt. All Claude models are marked EU-hosted and served via Vertex and Bedrock. No page says which provider or region serves which model. Anthropic is named in the API docs but not in the DPA.
- **Retention:** Langdock claims zero retention at the model providers, except Fable 5.x (30 days). This may conflict with AWS's docs and with Microsoft's end of Modified Abuse Monitoring for new models (17 Nov 2026). Chat retention can be set down to 7 days.
- **DPA:** German law, 14 days' notice of new sub-processors. Sub-processors are in the EU except Sentry and Cloudflare. ISO 27001 and SOC 2 Type II.
- **Integrations:** native for Notion, HubSpot, Slack, Linear, M365, Metabase, BigQuery and Google Drive, plus custom MCP. This corrects an earlier line that said there were none.
- **Features:** a Document Editor with live preview, and Apps with a built-in database.
- **Prices:** Core €23.20 and Work €31.20 per seat per month on annual billing; Max seats with 5× limits at €99 and €109.
- **Usage limits:** a 5-hour and a weekly window. These limits are the main user complaint on Reddit and Trustpilot (3.5/5), since a cut in Apr 2026. Model choice gets the most praise.

The cost scenario in the deck: 30 Claude seats plus 70 Langdock Work seats, 30 % of them Max, about €66,600 a year. (Claude, session with Mahyar; Langdock pages, Reddit via PullPush, Trustpilot)

## 2026-11-23: Microsoft 365 Copilot checked

Copilot is an EU Data Boundary service under the existing Microsoft DPA. It is not zero retention, and LLM calls may leave the region at high utilisation. Connectors exist for Notion, HubSpot, Linear and Slack, but not for Metabase or BigQuery. The nearest thing to artifacts is Copilot Pages. Skills and authoritative SharePoint sites exist; there is no tenant-wide instruction. FOMF holds 2 add-on licences on a one-year commitment, billed to Sina's profile. Mahyar assigned one to himself; the second holder is unknown. Gemini Enterprise has data residency only in the Standard and Plus editions; Google still has not sent an offer. (Claude, session with Mahyar; Microsoft Learn, Outlook invoices)

## 2026-11-23: Prep for the Executive Board exchange

Mahyar's lean going in was Copilot for sensitive data, with Claude for P&E and general use; it moved to Langdock during prep. Since 29 Oct, staff have been told Claude is for general use only and that a replacement would come by 15 Nov; Sina, Gerald Rupp and Wafa asked for it. The Langdock trial seat renewed to 22 Dec. (Mahyar; Teams, Outlook)

## 2026-11-19: Claude vs EU hosting researched

claude.ai Enterprise has no EU residency (US storage) and no zero retention; the minimum custom retention is 30 days. The contract is with Anthropic Ireland under SCCs, not the DPF; the DPF stands after the General Court ruling of 3 Sep 2025. Claude in Copilot moves into the EU Data Boundary in early Dec 2026. On 9 Dec it is switched on for tenants without a setting (CTO-25). (Claude research agent, session with Mahyar)

## 2026-11-19: Topic opened from CTO-8; the dilemma

Everyone wants to keep Claude, but it processes and stores data outside the EU. That matters for sales (sponsor data) and events (speaker contracts). An EU platform gives residency and short retention but loses the Claude interface. CTO-7 (Google's offer) became a sub-issue. (Mahyar, session with Claude)

## 2026-11-05: Glean evaluation paused

Mahyar told Glean FOMF needs more time to evaluate other solutions; Glean cancelled the call. (Mahyar, email "Glean <> FOMF")

## 2026-10-08: Spend snapshot sent to Glean

Claude Team €1,852/month for 32 seats; Claude Enterprise 35 seats, $8,400 prepaid Jul 2026 to Jul 2027, plus about $1,900 usage in Sep; Claude API about $270 in Sep. Estimate for 70 to 80 Enterprise users: about $5–8k/month. Glean had quoted $85k/year without implementation and with no seat count. (Mahyar, email "Glean vs Claude eval")

## 2026-09-29: Requirements stated to Glean

Gaps in Claude Enterprise: retention not below 30 days, no EU residency, about $100–150/month per mid-level user. Wanted: permission-aware search across SharePoint, Outlook, Notion, Slack, Linear and HubSpot, and agents grounded in company data for non-technical teams. (Mahyar, email "Questions before tomorrow")

## 2026-07-22: Google's answer on Gemini Enterprise

Google's standard terms and its zero-data-retention page were offered; there is no extra document to sign. The enterprise offer itself was not sent. (Alexandra Vassileva, forwarded in Teams)

## 2026-07-21: Claude Enterprise signed

35 seats at $240/seat/year plus $1,000 usage credits. (Mahyar, email "Glean vs Claude eval" of 8 Oct)
