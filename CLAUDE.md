# FOMF CTO Assistant

This folder is the home base for Claude Code agents that support **Mahyar (CTO of FOMF)** in day-to-day work. It is not a product code repo — it is a workspace for operations, planning, architecture review, incident support, communication drafting, research, and cross-system orchestration at CTO level.

---

## About FOMF

FOMF is a medical learning company. Two products:

### Learning Platform
Medical content (primarily CME — Continuing Medical Education, plus other formats) for doctors, assistant doctors, and students. Monetization: individual course bookings, B2C membership, B2B membership. German instance: **fomf.de**.

- **Repo:** https://github.com/fomf-code/fomf-learning-platform
- **Backend:** Kotlin + Node.js microservices on GKE
- **Frontend:** Next.js on Vercel
- **CI/CD:** GitHub Actions + Vercel
- **Storage:** Cloud SQL (relational) + Elastic Cloud (BM25 + semantic search)
- **Analytics:** BigQuery + Metabase
- **Logs, monitoring, observability:** Datadog (a July 2026 move to Elastic Observability serverless was reverted; confirmed August 2026). Elastic Cloud is used for search only.
- **GCP project:** `fomf-v2-prod`

### meviq → Eviplex
Medical AI assistant — evidence-based answers to doctors' questions, grounded in curated guidelines and studies. Being rebranded from **Meviq** to **Eviplex** (brand + product name).

- **Repo:** https://github.com/fomf-code/meviq
- **Backend:** multiple Node.js services + Vercel AI SDK
- **Frontend:** Next.js + Vercel AI SDK
- **CI/CD:** GitHub
- **Evals & traces:** Braintrust
- **GCP project:** `meviq-prod`

**Corporate separation (in progress, as of July 2026):** the product is being split into an asset-company / operating-company structure.
- **Eviplex GmbH** — new legal entity that launches and owns the market-facing medical AI product (Eviplex). It is the **regulatory and liability holder** (EU AI Act / MDR exposure sits here) and the **GDPR data controller**.
- **FOMF** — the **asset company / SaaS provider**. Holds the assets (code, IP, hosting, curated medical knowledge base) and provides the software as a service to Eviplex. Acts as **GDPR data processor**. May later be spun into its own separate company.
- **Data processing agreements (DPAs)** between FOMF and Eviplex are being prepared.
- A **cooperation contract** between FOMF and Eviplex is to be signed — IP ownership, license/SaaS terms, and intercompany questions will be settled there.
- **Technical blockers resolved:** answer quality, latency, and cost-per-question are now at acceptable levels (specific figures TBD — Mahyar to provide from Braintrust evals + latency/cost metrics).

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
- **Andreas** — Head of IT (3 team members under him)

### Teams

**Platform team** — builds/operates the learning platform
- EM: George · PM: Vahid
- Engineers: Kamran, Ignasi, Raman, Matheo, Rahim (also TL), George (EM)
- Designer: Shadi

**Productivity team** — internal dashboards/back offices built on top of our backend, primarily in Retool
- EM: Simone
- Engineers: Nikola, Tomislav, Borna, Farzam

**Eviplex team** — the AI assistant product (formerly Meviq team)
- PM: **Mahyar** (himself, for now)
- Medical Lead: **Max**
- Designers: Shadi, Bardia
- Engineering: Parham, Anah (data eng), Ehsan (data scientist), Josip (mobile), Viktor (frontend TL)

**IT team** — Andreas + 3

---

## Current priorities (as of July 2026)

1. **Eviplex (ex-Meviq) launch & corporate separation** — dev started June 2025; v1 launched quietly December 2025 (~500 users). Answer-quality issues drove a rewrite; technical blockers (quality, latency, cost-per-question) are now resolved. Focus has shifted from tech to the **corporate/legal separation**: standing up **Eviplex GmbH** as the product-owning entity (regulatory/liability holder, GDPR controller) with **FOMF** as SaaS provider / asset company (GDPR processor). DPAs in preparation; FOMF↔Eviplex cooperation contract to be signed. See the meviq → Eviplex section above. Top near-term focus.
2. **Cybersecurity** — hardening custom + cloud workloads (GCP-hosted and Microsoft-side alike). A joint M365 + GCP assessment was scoped with Mandiant but **not commissioned (too expensive, decided July 2026)**; on 27 Oct 2026 **Blaze Information Security** was chosen over PCG (M365 + GCP review, pentests of the learning platform and Eviplex incl. mobile/AI, + OSINT + GKE review of the learning-platform cluster; revised 6 Nov 2026 to €31,900 net for 29 days at €1,100/day, Eviplex now 9 days; NDA signed by Habib; Phase 1 can start last week of Nov if decided by mid-Nov; contract signed by Mahyar on 9 Nov 2026 (v4, #2026.11.014)). See `cybersecurity/vendor-comparison-2026-10.md`.

Ask Mahyar to confirm/refresh this section when it feels stale — priorities shift and this list should reflect reality.

---

## Commercial ownership (from September 2026, outside the CTO role)

The Executive Board handed Mahyar the **commercials of two learning-platform products** — pricing, packaging, positioning, go-to-market and marketing. This is a business-owner mandate, not engineering work; keep it separate from Platform / Eviplex in comms and docs.

- **SYFAT** (Facharzt / specialist-exam preparation) — brief in `syfat/AGENTS.md`
- **On-Demand Accredited** (CME-point-bearing on-demand courses) — brief in `on-demand-accredited/AGENTS.md`

Goal for both: **double revenue in the coming year** (to Sep 2027). Revenue = membership fees attributed to product-led members + stand-alone course sales, **B2C only**. The medical team owns the content. SYFAT has a business owner, **Marie Fiebig** (a doctor), and a Notion project page; On-Demand Accredited has no owner, marketing or docs yet. Content roadmap is probably in scope; marketing budget about €50k (internal figure). Baselines are the first deliverable in each folder. Established numbers come from `b2c-value-journey/` (data as of 21 Sep 2026) and its agreed definitions apply.

---

## Sub-project folders

| Folder | What it is | Entry point |
|---|---|---|
| `b2c-value-journey/` | Interactive dashboard on monthly B2C member cohorts for the Sep 2026 EB strategy meeting | `b2c-value-journey/AGENTS.md` |
| `b2c-income-dashboard/` | SQL behind the Metabase dashboard "B2C Membership Income" (1816) | `b2c-income-dashboard/sql/` |
| `syfat/` | SYFAT commercials: pricing → marketing, 2× revenue goal | `syfat/AGENTS.md` |
| `on-demand-accredited/` | On-Demand Accredited commercials: pricing → marketing, 2× revenue goal | `on-demand-accredited/AGENTS.md` |
| `registration-funnel/` | Web registration drop-off funnel (Segment), Jul–Oct 2026 | `registration-funnel/AGENTS.md` |
| `ai-hackathon-2026/` | AI Hackathon at the FOMF Teamtreffen, Tue 20 Oct 2026: plan, teams, workstreams | `ai-hackathon-2026/AGENTS.md` |
| `eviplex-partnermodell/` | Eviplex partner commission model (Medichub, Webop) and partner contract for counsel review, Nov 2026 | `eviplex-partnermodell/AGENTS.md` |
| `signals/` | Posts and thoughts on leading product & tech into the AI age: capture, themes, monthly reflection (since Nov 2026) | `signals/AGENTS.md` |
| `acquisition-sources/` | New B2C customers by survey source, skipped-June-mailing economics, Sep 2026 | `acquisition-sources/new-customer-sources.html` |
| `price-increase-cancellations/` | Cancellations after the Oct 2026 renewal price rise | `price-increase-cancellations/cancellations.html` |
| `cybersecurity/` | Security assessment vendor choice (Blaze), NDA/contract reviews, EB memo, Oct–Nov 2026 | `cybersecurity/vendor-comparison-2026-10.md` |
| `eviplex-avv/` | Review of the FOMF↔Eviplex AVV (Anlage 2.1/2.2, § 203), Nov 2026 | `eviplex-avv/avv-pruefung-2026-11-03.html` |
| `eviplex-changelog/` | Internal Eviplex changelog emails (DE) | `eviplex-changelog/src/` |
| `eviplex-uae-pitch/` | EN pitch deck for the UAE contact, Oct 2026 | the `.pptx` in the folder |
| `eviplex-weekly/` | Weekly Eviplex plan memos, one file per week | latest dated `.md` |
| `artifact-index/` | Source of the Artifact Index page (see below) | `artifact-index/artifact-index.html` |

Folders with an `AGENTS.md` also have a `CLAUDE.md` pointing at it; read that brief before working in the folder. The others are smaller and have no brief.

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

Claude Code's memory for this repo lives in `../claude-memory/` (the repo root folder `claude-memory/`): one fact per file, indexed in `MEMORY.md`. Claude Code reaches it through a symlink, so memory changes appear in `git status`; commit them with the rest of the work. Repo files (briefs, logs, SQL) stay the source of truth; memory holds decisions, preferences and pointers.

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
- **Linear** — issue tracking. Mahyar interacts at project level across most teams; **personally manages the Eviplex Linear team** (as Eviplex PM).
- **Notion** — three primary workspaces he lives in:
  - **Product & Engineering**
  - **Meviq**
  - **Executive Board**

### Cloud & infrastructure
- **GCP** — all custom workloads on two GKE clusters (learning platform, meviq)
- GCP projects: `fomf-v2-prod`, `meviq-prod`, `fomf-dl`

### Connected MCP servers (via claude.ai)
Linear · Notion · Slack · Microsoft 365 · Figma · HubSpot · Miro
(Schemas must be loaded through `ToolSearch` before calling — they are deferred.)

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
