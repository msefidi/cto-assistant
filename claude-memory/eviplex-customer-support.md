---
name: eviplex-customer-support
description: "Oct 2026 decisions on how FOMF Customer Support handles Eviplex requests (CS stays in front, support@ only address, quotas 30/150/300, lectures for all soon); Notion page for Raphaela"
metadata:
  node_type: memory
  type: project
  originSessionId: 07738500-6526-490f-80c6-a837104910de
  modified: 2026-11-12T13:04:51.809Z
---

On 8 Oct 2026 Mahyar answered Raphaela's (Head of FOMF CS) 18 questions on Eviplex support. Page: Notion Eviplex teamspace › 01 - Product › "Eviplex – Customer Support: Zuständigkeiten, Abläufe & verbindliche Aussagen" (https://app.notion.com/p/3f37afedf3098181988cea3316d61b4e). Her own tracker: CS KB "Eviplex – Offene Punkte & interne Klärungen".

Decisions (Mahyar):
- No separate Eviplex support team for the next few months. FOMF CS handles all Eviplex customer contact, the Eviplex team only supports CS internally.
- support@eviplex.com is the single customer support address, decided 9 Oct, replacing the 8 Oct kontakt@ choice because the live terms already name support@. It is routed to FOMF CS; kontakt@ forwards to it; info@ is for general, press and partners; datenschutz@ is for privacy. eviplex.com mail is not in FOMF M365.
- Quotas the CS page states: Free 30/calendar month, Plus 300, Pro 300, anonymous 3. This clashes with the "+500%/+1000%" marketing copy. **Correction (Mahyar, 12 Nov 2026): Plus was never 300, it is 150 questions/month; Pro is 300.** Check the CS page and training material for the old "je 300" wording before quoting them.
- FOMF expert lectures: "full access for all Eviplex users soon". The training's "All Access feature" wording is outdated.

Internal escalation + status channel: Slack #triage-eviplex (C0C82GXJXE0, created by Mahyar 9 Oct). My assumptions in the page that Mahyar should confirm: Max as the medical reviewer; datenschutz@ handles deletion/DSARs.

**Why:** the training material had no support path; the sources (website, terms, handout, code) contradict each other.
**How to apply:** use the page as the source of truth for CS-facing Eviplex answers. Check its 🟡 open items before reusing it. See [[eviplex-ch-tech-factsheet]] for legal wording.

AI-native support concept (9 Oct 2026), a subpage of the CS page: "Konzept: KI-Agent für den Eviplex-Support" (https://app.notion.com/p/3f47afedf309814a9307d93c095290f1).
- One agent built on Claude Team, reached two ways: the CS shared mailbox (M365) and a chat CS uses during phone calls.
- The agent drafts replies, posts cases to #triage-eviplex (one thread per case), and issues go to Linear Eviplex Product via the Slack integration.
- CS still sends every reply. The CS page is the agent's rulebook.
- Build pieces: a read-only Eviplex lookup MCP server in the meviq backend, and mailbox access (it's unknown whether the M365 connector supports shared mailboxes).
