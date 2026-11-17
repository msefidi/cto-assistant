# Eviplex: customer support

How Eviplex customers get help. The rulebook for Customer Support is the Notion page "Eviplex – Customer Support: Zuständigkeiten, Abläufe & verbindliche Aussagen" (Notion Eviplex teamspace › 01 - Product, https://app.notion.com/p/3f37afedf3098181988cea3316d61b4e), written from Mahyar's answers to Raphaela's 18 questions on 8 Oct 2026. Use it for CS-facing answers and check its open (🟡) items first. Raphaela's own tracker: CS knowledge base "Eviplex – Offene Punkte & interne Klärungen".

## Who does what

- FOMF Customer Support (head: Raphaela) handles all Eviplex customer contact. There is no separate Eviplex support team; the Eviplex team supports CS internally (Mahyar, 8 Oct 2026).
- Escalations and status: Slack #triage-eviplex (C0C82GXJXE0).
- Not confirmed by Mahyar: Max as the medical reviewer of escalated answers; datenschutz@ handling deletion requests and DSARs.

## Addresses

- Eviplex has two addresses: **kontakt@eviplex.com** and **feedback@eviplex.com** (Mahyar, 17 Nov 2026). The app's support link uses kontakt@ (meviq `web/shared-brand/src/brands/eviplex.ts`).
- Still named on eviplex.com: support@ in the terms of use, info@ in the imprint and privacy page, datenschutz@ in the privacy page. Whether those mailboxes exist is not confirmed.
- eviplex.com mail is not in FOMF's Microsoft 365.

## What CS may say

- Quotas: Free 30 questions per calendar month, Plus 150, Pro 300, anonymous 3 (Mahyar, 12 Nov 2026). The CS page and training once said "Plus und Pro je 300"; check for that before quoting them. The "+500 % / +1000 %" marketing copy does not match these numbers.
- FOMF expert lectures: "full access for all Eviplex users soon". The training's "All Access feature" wording is outdated.
- Uploads and patient documents: the agreed answer in `claims-and-legal.md`.

## AI support concept (9 Oct 2026, not built)

Notion subpage "Konzept: KI-Agent für den Eviplex-Support" (https://app.notion.com/p/3f47afedf309814a9307d93c095290f1):

- One agent, reached through the CS shared mailbox and a chat CS uses during phone calls.
- It drafts replies, posts each case to #triage-eviplex, and issues go to Linear through the Slack integration. CS still sends every reply; the CS page is the agent's rulebook.
- Build pieces: a read-only Eviplex lookup MCP server in the meviq backend, and mailbox access.
