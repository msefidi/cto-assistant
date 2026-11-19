# FOMF CTO Assistant

This folder is the home base for the agents (Claude Code, Codex) that support **Mahyar (CTO of FOMF)** in day-to-day work. It is not a product code repo — it is a workspace for operations, planning, architecture review, incident support, communication drafting, research, and cross-system orchestration at CTO level.


This file is the workspace guide for every agent. Claude Code loads it through `CLAUDE.md` (`@AGENTS.md`); other agents read it directly. Dated priorities and status lines below are context, not proof of the current external state. Mahyar's latest explicit instructions and corrections take precedence.

---

## About FOMF

FOMF is a medical learning company. Two products:

### Learning Platform
Medical continuing education (mostly CME) for doctors, assistant doctors and students on fomf.de, fomf.at and fomf.ch: single course bookings, the B2C membership ("FOMF-All-Access-Paket"), B2B memberships and sponsoring. Repo `fomf-code/fomf-learning-platform`, GCP project `fomf-v2-prod`.

**Everything that stays true about the platform** (offer, products, B2C definitions and findings, data, stack, incidents, people) **is in the product folder `platform/`: its `AGENTS.md` and `knowledge/`. Read `platform/AGENTS.md` before any platform work.**

### Eviplex (formerly Meviq)
Medical AI assistant: evidence-based answers to physicians' questions from curated guidelines and studies. Brought to market by **Eviplex GmbH** (controller, liability holder); **FOMF** provides it as SaaS (processor). Repo `fomf-code/meviq`, GCP project `meviq-prod`.

**Everything that stays true about Eviplex** (tiers, legal set-up, positioning, claims, support, brand, Linear, people, stack) **is in the product folder `eviplex/`: its `AGENTS.md` and `knowledge/`. Read `eviplex/AGENTS.md` before any Eviplex work.**

### Product source of truth
For now, the Notion page **"Produktwelt bei FOMF"** is the source of truth for all FOMF products (product families, offers for special audiences, sponsoring, team rules): https://app.notion.com/p/fomf/Produktwelt-bei-FOMF-3ea7afedf309808e8bfcf1891a76175e. The product folders point to it and add only what it does not say; where they disagree, the page wins. Two exceptions:
- **All Access tiers and prices:** the Notion page **"FOMF All Access"** is the source of truth: https://app.notion.com/p/fomf/FOMF-All-Access-12d7afedf30980ca8bb2ff2f0ace6e9c
- **Eviplex:** ignore what the Produktwelt page says about Eviplex; the source of truth is `eviplex/` (`AGENTS.md` and `knowledge/`; meviq `brand/` for wording).

Company figures come only from the page "FOMF in Zahlen", linked from the Produktwelt page.

### Shared / data
- **Datalake & main BigQuery:** GCP project `fomf-dl`

---

## Org

### Executive Board (FOMF leadership)
- **Wafa** & **Sina** — co-founders
- **Habib** — CGO
- **Erfan** — CFO
- **Mahyar** — CTO (this user)

### Mahyar's direct reports (6)
**Product & Engineering department** (one combined department, 5 reports):
- **Vahid** — PM, Platform team
- **George** — EM, Platform team
- **Simone** — EM, Productivity team
- **Viktor** — Tech Lead, Frontend
- **Rahim** — Tech Lead, Backend (also contributes on Platform team)

**IT department** (1 report):
- **Andreas Langer** — Head of IT (3 team members under him). Not Andreas Eberl, who holds the ÄKW relationship.

### Teams

**Platform team** — builds and runs the learning platform; EM George, PM Vahid. **Productivity team** — internal back offices in Retool; EM Simone. Members and roles: `platform/AGENTS.md`.

**Eviplex team** — the AI assistant product; PM: **Mahyar**. Members and roles: `eviplex/AGENTS.md`.

**IT team** — Andreas Langer + 3

---

## Current priorities (as of July 2026)

1. **Eviplex (ex-Meviq) launch & corporate separation** — dev started June 2025; v1 launched quietly December 2025 (~500 users). Answer-quality issues drove a rewrite; technical blockers (quality, latency, cost-per-question) are now resolved. Focus has shifted from tech to the **corporate/legal separation**: standing up **Eviplex GmbH** as the product-owning entity (regulatory/liability holder, GDPR controller) with **FOMF** as SaaS provider / asset company (GDPR processor). DPAs in preparation; FOMF↔Eviplex cooperation contract to be signed. See `eviplex/AGENTS.md`. Top near-term focus.
2. **Cybersecurity** — hardening custom + cloud workloads (GCP-hosted and Microsoft-side alike). A joint M365 + GCP assessment was scoped with Mandiant but **not commissioned (too expensive, decided July 2026)**; on 27 Oct 2026 **Blaze Information Security** was chosen over PCG (M365 + GCP review, pentests of the learning platform and Eviplex incl. mobile/AI, + OSINT + GKE review of the learning-platform cluster; revised 6 Nov 2026 to €31,900 net for 29 days at €1,100/day, Eviplex now 9 days; NDA signed by Habib; Phase 1 can start last week of Nov if decided by mid-Nov; contract signed by Mahyar on 9 Nov 2026 (v4, #2026.11.014)). See `cybersecurity/vendor-comparison-2026-10.md`.

Ask Mahyar to confirm/refresh this section when it feels stale — priorities shift and this list should reflect reality.

---

## Commercial ownership (from September 2026, outside the CTO role)

The Executive Board handed Mahyar the **commercials of two learning-platform products** — pricing, packaging, positioning, go-to-market and marketing. This is a business-owner mandate, not engineering work; keep it separate from Platform / Eviplex in comms and docs.

- **SYFAT** (Facharzt / specialist-exam preparation) — brief in `platform/syfat/AGENTS.md`
- **On-Demand Accredited** (CME-point-bearing on-demand courses) — brief in `platform/on-demand-accredited/AGENTS.md`

Goal for both: **double revenue in the coming year** (to Sep 2027). Revenue = membership fees attributed to product-led members + stand-alone course sales, **B2C only**. The medical team owns the content. SYFAT has a business owner, **Marie Fiebig** (a doctor), and a Notion project page; On-Demand Accredited has a project lead, **Isgard Eyberg**, and marketing by Tina Hoffmann (Notion project page since 23 Oct 2026); how her role relates to Mahyar's commercial ownership is not recorded. Content roadmap is probably in scope; marketing budget about €50k (internal figure). Baselines are the first deliverable in each folder. Established numbers and the agreed definitions are in `platform/knowledge/b2c-members.md`; the products are described in `platform/knowledge/products/`.

---

## Topics

A **topic** is a folder of work. A topic that belongs to one product lives inside that product's folder (`platform/syfat/`, `eviplex/avv/`); a topic that spans products or none lives at the top level (`cybersecurity/`, `signals/`). `TOPICS.md` lists the active and recurring topics and each active topic's board issue; it is loaded at the end of this section. `TOPICS-DONE.md` lists the finished ones and is read only when needed. Topics sit in three groups:

| Group | What | The folder holds |
|---|---|---|
| **Active** | Work that runs longer than one session: a deal, a project, a vendor process, a product mandate | The four files below, copied from `_template/` |
| **Recurring** | Work that repeats with no end: a weekly memo, a changelog, a collection of posts | An `AGENTS.md` that says what recurs, its format and where to start |
| **Done or reference** | A finished topic, or one output finished in a session (an analysis, a deck) | Lives in `archive/`: the files that rebuild it; a finished topic keeps its four files |

- **Opening a topic:** work that will run longer than this session gets the four files; work that repeats gets an `AGENTS.md`; an output finished in this session is a plain folder in `archive/` with a line in `TOPICS-DONE.md`. A question that leaves no files is not a topic. Done when the folder holds what its group needs and its line is in `TOPICS.md` or `TOPICS-DONE.md`.
- **A topic changes group** (a one-off analysis turns into a project, a recurring job gets a goal): add the files the new group needs and move its line, between `TOPICS.md` and `TOPICS-DONE.md` if needed. A topic that comes back moves out of `archive/` again.
- **Product folders:** `platform/` and `eviplex/` each hold one product. Their `AGENTS.md` is the product brief and `knowledge/` holds what stays true (offer or tiers, positioning, definitions and findings, data, stack, people, how it is run); every other subfolder is a topic about that product. Before work on a product, read its `AGENTS.md`. When you learn a lasting fact, rewrite the matching file in `knowledge/` (who said it, when), not memory; status and next steps stay in the topics. Point to sources (repo, Notion, Linear) instead of copying them.
- **Not topics:** the product folders themselves and their `knowledge/`; `_template/`, `_guide/` and `artifact-index/` (workspace tooling); `archive/` (finished topics). They have no line in `TOPICS.md`.
- **Board:** every active topic has one issue on Mahyar's Linear board, next to his tasks; how new work is captured and when a task becomes a topic is in "Board" below.

### Board

Mahyar's private Linear team **cto-assistant** (key `CTO`) holds all his work as issues of three kinds: a **task** (the issue is its whole record), a **topic issue** (one per active topic; the brief stays the record) and a **sub-issue** (a task that belongs to a topic, filed under its topic issue).

- **New work:** create an issue in `CTO`; it lands in *Triage*. Sorting empties Triage: work that belongs to an open topic becomes a sub-issue of its topic issue (results go to that topic's log, decisions to its `decisions.md`); everything else is a task.
- **A task becomes a topic** as soon as one of these happens, or is certain to:
  1. it must keep something an issue may not hold: contract terms, prices, counsel advice, security findings, a confidential name;
  2. it produces files that rebuild an output: a draft, analysis, SQL, deck or contract;
  3. a decision is made that later work relies on;
  4. continuing needs a catch-up across several rounds, people or threads. Waiting for one reply is still a task.

  Then start the topic (section "One shape for active topics"). The issue keeps its number and becomes the topic issue, its description and comments become the first log entry, and related issues become its sub-issues. An output finished within one session goes to `archive/` instead.
- **Statuses:** *Triage* is unsorted. *Backlog* holds every issue not due in the current week (Monday to Sunday) or without a due date. *Todo* and *In Progress* are Mahyar's move. *Delegated/Waiting* is with someone else, and the issue names who. *Done* and *Canceled* end an issue. The view *Week Plan* (https://linear.app/fomf/view/9350eb27-d908-4104-8569-d6e8516958af) shows everything outside Backlog, so it is Mahyar's week plan: when an issue's due date falls in the current week, move it out of Backlog.
- **Issue content:** a short status (state only, as in the brief), the next step, the next date as due date, a label (Platform, Eviplex, Medical, Cross) and, on a topic issue, the folder path.
- **Sync:** a SessionStart hook (`.claude/hooks/linear-board.sh`, Linear key in GCP Secret Manager, secret `cto-assistant-linear-api-key` in `fomf-common`, cached as `LINEAR_API_KEY` in each machine's `.env`) prints the open issues and those changed since the last session into the context. Write into the brief whatever Mahyar changed there (status, due date, description). If the hook reports it was skipped or failed, read the board with `list_issues` (team `CTO`). At the end, update the topic issue to match the brief.
- **Guardrails:** contract terms, prices, commission rates, security findings and confidential partner names stay in the repo, never on an issue. Name another team's issue, project or pull request in words, never as a link or identifier: Linear shows the reference on the other side, and a linked GitHub PR can move the issue when it merges.

### One shape for active topics

Every active topic has the same four files:

| File | Holds | Changes by |
|---|---|---|
| `AGENTS.md` | The brief: status, goal, people, open points, rules, source map. States what is true now, never how it got there | Rewriting, so it is always current |
| `docs/decisions.md` | Every decision, one line each, newest first, with who and where | Appending only; a changed decision gets a new line saying what it replaces |
| `docs/log.md` | Events and results, newest first; each entry names who and where | Appending only |
| `CLAUDE.md` | `@AGENTS.md`, an import, so Claude Code loads the brief | Never |

- **Starting one:** copy `_template/` to a kebab-case folder, inside the product folder when it belongs to one product, else at the top level. Done when every heading of the brief is filled (write "none" where there is nothing), the log has its first entry, decisions made so far have their lines, `TOPICS.md` has its line and the board has its topic issue (the existing issue when the topic grew from a task).
- **Working in one:** read the brief, the decisions and the newest log entries first. For each event or result: log it; if something was decided, also give it a line in `decisions.md`; if it changes the current state, rewrite the affected part of the brief so it reads true today. **State, not story:** the Status says what exists, what is pending and who has the ball. Dates are fine as facts ("ready since 12 Nov", "due 25 Nov"); who said what to whom, and when, belongs in the log. Done when each decision of the session has its line in `decisions.md`, each result is logged and the brief's Status and the board issue match it. The flow is drawn in `_guide/topic-session.html`.
- **"Catch up on X":** search every row of X's source map from the newest log date to today. Done when the news is logged, new decisions have their lines, the Status and the board issue are updated and each new thread, chat or person is in the source map. Then tell Mahyar what changed.
- **Sources stay where they are.** The log summarises an email, chat or contract with who, where and when. The original stays in Outlook, Teams or SharePoint.
- **Memory** keeps one pointer note per active topic. The history goes in the log.
- **Linear:** when part of a topic becomes product work, link the Linear project in the brief. Linear tracks that part.
- **Finished:** write the outcome at the top of the brief, `git mv` the folder into `archive/` (flat, also from a product folder), move its line from `TOPICS.md` to `TOPICS-DONE.md` with the new path, move its board issue to *Done*, and mark the memory pointer note closed (date, outcome and new path). Then update every path that pointed at the old folder: other briefs, memory notes and the `repo` field of its Artifact Index rows. Logs and decisions are not rewritten. Done when `grep -rn "<folder>/"` finds no live reference to the old path.
- **Older folders** are listed under "Not yet in shape" in `TOPICS.md`. Bring one in line when you next work in it, and keep its existing files where they are.

Read `TOPICS.md` at the start of every session: it lists the active and recurring topics and their board issues. Status and next steps are in the briefs and on the board. (Claude Code loads it through the import below.)

@TOPICS.md

Security findings and pentest / audit results (e.g. Blaze reports) go in `cybersecurity/reports/`, which git ignores. Keep the originals in SharePoint.

---

## Artifact Index — record every output

The **Artifact Index** (https://claude.ai/artifact/KPVNKWy8eCpyvHexVeJFuZ) is the single register of what this workspace has produced: Claude pages, docs, decks and designs, Office files, emails and memos, skills, and things that live in Metabase, Notion, Linear or Figma. Its rows are in the page's database, not in the HTML.

- **Looking for an earlier output?** Read the index first: `ArtifactData` with `action: "list"`, `collection: "outputs"`.
- **Produced or changed an output?** Add or update its row in the same session with `ArtifactData` (`set` / `update` on `outputs/<slug>`). Do not republish the page for this.
- **Row fields:** `title`, `kind` (`page`, `doc`, `deck`, `design`, `ds`, `data`, `file`, `message`, `skill`, `metabase`, `notion`, `linear`, `figma`, `other`), `status` (`live`, `done`, `draft`, `reusable`, `check`, `archived`, `unsorted`), `url` (where the real thing lives, https only, may be empty), `repo` (path in this repo that rebuilds it), `project` (folder name where one exists), `date` (`YYYY-MM-DD`), `note` (one or two plain sentences; put a SharePoint location here when there is no link).
- **The repo keeps what rebuilds it:** save a Claude page's source HTML, the SQL, scripts, templates and prompts in the project folder, not in a temp directory. Final sent versions of Office files go to SharePoint.
- **Leave out** personal items and HR documents.
- The page source is `artifact-index/artifact-index.html`; change it only to change the page itself.

---

## Memory

Claude Code's memory for this repo lives in `claude-memory/` at the repo root: one fact per file, indexed in `MEMORY.md`. Claude Code reaches it through `autoMemoryDirectory` in `.claude/settings.json` and a symlink from its path-keyed memory folder, so memory changes appear in `git status`; commit them with the rest of the work. Repo files (briefs, logs, SQL) stay the source of truth; memory holds decisions, preferences and pointers.

- **What goes in:** how Mahyar works (preferences and corrections), people and their names, one pointer note per active topic, pointers to things outside the repo (dashboard, card or Figma node ids), and conclusions that should shape later work across topics.
- **What stays out:** status and dates that will change (they go in `TOPICS.md` and the brief), history and a topic's decisions (its log and `decisions.md`), outputs (the Artifact Index), security findings (`cybersecurity/reports/`), and anything the repo or git already records.
- **A topic pointer note** names the folder, the rules that hold for the whole topic (confidentiality, approvals) and nothing that changes week to week.
- **A note that turns out wrong or outdated** is corrected or deleted in the same session. Do not append "Update:" paragraphs; that turns memory into a second log.

---

## Recurring rituals

| Day | Slot | Meeting |
|---|---|---|
| Monday | morning | Executive Board |
| Tuesday | morning | Unit-manager meeting with EB |
| Tuesday | afternoon | Executive Board |
| Wednesday | afternoon | Platform weekly (with other EB members reviewing platform projects) |
| Friday | morning | Eviplex weekly (Mahyar runs it as PM) |

- **1:1s** with all six direct reports on a rolling cadence.

---

## Tooling landscape

### FOMF workspace (Microsoft-driven)
- SharePoint, Exchange/Outlook

### Product development
- **Miro** — whiteboarding
- **Linear** — issue tracking. Mahyar interacts at project level across most teams; **personally manages the Eviplex Linear team** (as Eviplex PM). His private team **cto-assistant** (`CTO`) is the topic board, not product work (section "Topics").
- **Notion** — three primary workspaces he lives in:
  - **Product & Engineering**
  - **Meviq**
  - **Executive Board**

### Cloud & infrastructure
- **GCP** — all custom workloads on two GKE clusters (learning platform, meviq)
- GCP projects: `fomf-v2-prod`, `meviq-prod`, `fomf-dl`

### Connected MCP servers (via claude.ai)
Linear · Notion · Slack · Microsoft 365 · Figma · HubSpot · Miro
Check which connectors are actually available in the current session; don't assume they are connected. In Claude Code their schemas are deferred and must be loaded through `ToolSearch` before calling.

### Local CLIs available
`gh`, `gcloud`, `bq`, and others. Fall back to REST APIs when a CLI isn't installed.

---

## How to work with Mahyar here

- This workspace is for CTO-level support, not product code — expect planning, architecture review, vendor evaluation, drafting comms, triaging across Linear/Notion/Slack/Outlook, incident investigation prompts, research.
- Many tasks span external systems. Use the appropriate MCP tool; don't guess state.
- If a task clearly belongs inside a product repo (`fomf-learning-platform` / `meviq`), call that out — code changes don't land in this folder.

### Language
- **English** when drafting *to or for Product & Engineering* (team Slack, Linear comments, eng-facing docs, PR/issue text).
- **German** for everyone else: Executive Board communications, IT, customer-facing content, HR/ops, company-wide messages.
- When unsure about audience, ask before drafting.

### Data sensitivity — do not paste into external tools without explicit approval
- Patient- or user-identifiable data from the platform or Meviq databases
- Financials and B2B contract terms
- Unreleased strategy documents from the Executive Board Notion space
- Security findings and pen-test / audit results

"External tools" includes web fetches to third parties, diagram renderers, pastebins, eval platforms, and any destination outside FOMF-controlled systems. When in doubt, ask.

### Read-only system access — preapproved
- **GitHub:** reading issues, PRs, and code across the `fomf-code` org via `gh` is fine without asking.
- **GCP:** read-only `gcloud` and `bq` commands against `fomf-v2-prod`, `meviq-prod`, and `fomf-dl` are fine without asking.
- Write/mutating actions against any of the above still need explicit approval.
