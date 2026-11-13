# Security assessment: PCG vs Blaze (Oct 2026)

Context: Mandiant (M365 + GCP) was dropped in July 2026 as too expensive. These are the two replacement offers.

| | PCG (Public Cloud Group) | Blaze Information Security |
|---|---|---|
| Offer | SODE26002713, 30.07.2026, **valid until 29.08.2026 (expired)** | #2026.10.030, 21.10.2026, **valid until 21.11.2026** |
| Timing | KW 38/39 (already passed) | M365 Nov 2026 → GCP Dec 2026 → pentests Jan 2027 |
| Core price (net) | €12,480 baseline | €22,499 |
| Options (net) | GCP deep-dive €8,320 | OSINT/EASM €2,600 · GKE review €5,200 per cluster |
| Typical package (net / gross) | €20,800 / €24,752 | Core + OSINT: €25,099 / €29,868 |
| Effort visible | No day counts, fixed price | 17 consultant days core (€1,300/day) |
| Payment | 14 days | At project end, 30 business days |

## Scope

| Area | PCG | Blaze |
|---|---|---|
| Microsoft 365 / Entra ID | — | ✅ 4 days, CIS M365 benchmark (Entra, CA, Exchange, SharePoint, Teams, Intune, Defender, Copilot) |
| GCP configuration | ✅ "cloud security analysis" (services, audit logging) | ✅ 3 days, 4 projects, CIS GCP benchmark, SA keys, data lake, secrets, logging, AI services |
| GCP deep-dive (IAM least privilege, KMS, segregation, GKE→Cloud SQL lateral movement) | ✅ option €8,320 | Partly in core; in-cluster K8s only with the GKE option |
| Learning platform | Automated **basic scan** + "opportunistic" manual look | ✅ 7 days, **manual grey-box pentest**, 135 endpoints, 3 roles, B2B tenant segregation, Stripe |
| Eviplex web/API | Only if found externally ("opportunistic") | ✅ grey-box, 40 endpoints, 2 roles, org segregation |
| Eviplex mobile (iOS/Android) | — | ✅ MASVS/MASTG, reverse engineering |
| Eviplex AI/LLM (prompt injection, RAG leakage, cost abuse) | — | ✅ OWASP LLM Top 10 |
| (all Eviplex in 3 days total) | | |
| OSINT / external attack surface / shadow IT | ✅ in core | Option €2,600 (incl. leaked-credential checks) |
| Network scanning | ✅ internal + external, intrusive | External only via OSINT option |
| Organisational / ISMS workshop | ✅ 2 × 2 h | — |
| Retest | Implied for the seal, not specified | ✅ 1 round, up to 4 h, within 90 days |
| Compliance mapping | Proprietary "PCG Security Requirements Framework" (BSI/NIST blend) | **ISO 27001** controls; CIS / OWASP / CVSS per finding |
| Proof for sponsors/customers | "Security Assessed by PCG" seal (after fixing criticals) | Attestation letter (scope + completion) |
| Other | CSV export for Jira, real-time alert on criticals, social-media templates | VulnKeep portal, chat channel, CREST, ISO 27001-certified, €5M E&O insurance, data destroyed 30 days after retest |

Out of scope at Blaze: internal admin/back-office tools of both products, social engineering, DoS, in-cluster GKE config (option).

## Assessment

- **PCG** is a broad, scanner-led health check of GCP and the perimeter. Its strengths are the internal network scan, the ISMS workshop and the GCP deep-dive on lateral movement. It has no M365, no authenticated app testing, and nothing on Eviplex mobile or the AI layer. PCG is primarily a cloud MSP/partner, so its independence is weaker if it is also in our GCP supply chain.
- **Blaze** is a manual pentest and configuration review that covers the original Mandiant scope (M365 + GCP) plus both products. For about €4k more than PCG's full offer, we get M365, real pentests of both products, mobile, AI, a retest, ISO 27001 mapping and an attestation letter.
- The Oct 2026 legacy Drupal incident showed that the gaps sit in exposed legacy hosts, cluster network segregation, service-account keys and logging. OSINT/EASM and the GKE review cover the first two. The core GCP review covers the last two.

## Decision (27 Oct 2026)

**Blaze** is the preferred vendor. Externally we are still assessing: the email to Blaze says they are shortlisted, asks the open questions, and asks for a sample report and references. Planned scope: core + OSINT + GKE review for the learning-platform cluster = **€30,299 net / €36,056 gross**. The only workshop is the 1 h closing workshop (€399, included in core). We asked for per-phase debriefs or a longer closing session, plus an optional ISMS workshop quote. PCG is declined. Email drafts: `email-drafts-2026-10-27.md`. Not yet signed; the offer is valid until 21.11.2026.

## Alternatives and ISO path (quick research, 27 Oct 2026)

Goals: (1) fix most security issues, (2) get ready for ISO 27001, at least for Eviplex.

- **A pentest alone doesn't make us ISO-ready.** ISO 27001 needs an ISMS: scope, risk assessment, Statement of Applicability, policies, internal audit, management review, then a Stage 1/2 audit by an accredited body (TÜV, DQS, DEKRA …). A pentest is evidence for A.8.8 / A.8.29. It isn't strictly required, but auditors expect one.
- **Separate ISMS track:** a compliance platform (Secfix, Kertos, DataGuard, Vanta, Drata) or a consultant/vCISO. Secfix's own estimate is €10–30k (platform-led). Certification audits in the EU cost about €6–12k, plus yearly surveillance audits.
- **Eviplex scope question:** Eviplex GmbH is the controller, but FOMF hosts and runs everything. The ISMS scope must cover FOMF as the provider (supplier controls), or sit at FOMF and cover the Eviplex service.
- **Testing alternatives to Blaze:**
  - Similar boutiques: Compass Security (CH/DE, CREST, GCP + mobile; useful for Swiss hospitals), NVISO (BE/DE), Pentest Factory (Hamburg), Cure53 (Berlin, top app/code depth, no M365).
  - Established German firms: SySS, usd AG, HiSolutions, secuvera, ERNW. They're known names for German hospitals and auditors, but cost more and take longer to book.
  - PTaaS / crowd platforms (Cobalt, Intigriti, YesWeHack) suit continuous app testing. They're weak on M365/GCP configuration review.
- **Independent signal is thin.** Reddit could not be fetched and search found no threads. Most "best pentest firm" lists are written by vendors, including Blaze. Verify the CREST register, ask for a redacted sample report and named testers, and get references.

## API inventory (from repos, main branch, 27 Oct 2026)

Blaze assumed 135 endpoints for the learning platform and 40 for Eviplex.

- **Learning platform:**
  - The Apollo federation gateway (gateway-v2) composes 11 subgraphs in prod.
  - About 407 GraphQL operations: 170 queries and 237 mutations.
  - By `@Secured` role: about 57 ROLE_USER, about 100 with no annotation (public, or checked elsewhere), about 253 ROLE_ADMIN / ROLE_SYSTEM only. The biggest are booking (about 102), content (72), membership (52) and user (46).
  - Also about 100 Spring REST handlers (webhooks, Stripe, sync) and 16 Next.js API routes.
  - About 23 services in the repo.
- **Eviplex:**
  - One Express backend, deployed as chat, document, ingestion and search.
  - About 56 routes: chat 8, billing 4, admin 37, internal/ingestion 2, health 3.
  - Plus 5 Next.js API routes (admin 3, marketing 2) and Ory for auth.
- **Effect on the quote:** Eviplex is roughly in line. The learning platform is 2–4× Blaze's assumption, so expect the 7 days to grow. My guess is 10–12 days, +€3.9–6.5k net.

**Internal only, don't share before NDA:** things in the prod ingress (`frontend/k8s/prod-ingress.yaml`) to check, and possibly fix before the pentest:
- `api.fomf.org` routes each service's path prefix publicly (e.g. `/user-service`, `/booking-service`, `/survey-service`, `/webop-sync-service`). Subgraph GraphQL endpoints may be reachable directly, bypassing the gateway's limits.
- `/admin/graph` (the admin gateway) is publicly routed and has introspection enabled.
- The "unrestricted" gateway on `api-vercel.*` allows any CORS origin pattern.

## Open points before signing (Blaze)

1. Eviplex has 3 days for web + API + mobile + AI. Confirm that's realistic or add 1–2 days.
2. 4 h of retest across all phases is thin. Ask for more or a price.
3. Testing runs against production with read-only access to the data lake. Need an AVV (Art. 28 DPA) and an agreement on test data, windows and the LLM cost cap.
4. Eviplex GmbH is the data controller for Eviplex. Clarify who authorises the Eviplex pentest and who signs.
5. The MSA "as updated from time to time" prevails over the SOW. Legal should check liability and the governing version.
6. Back-office tools (Retool, admin consoles) are out of scope. Include them or accept the gap.
7. The proposal frames this as ISO 27001 preparation. Confirm that is the intent, or adjust the wording.
8. Optional: management summary in German for the EB.
9. Phase 1 (Nov) needs Andreas to grant M365 Global Reader. The Jan pentests need test accounts in 2 orgs per product.

## Update 6 Nov 2026: Blaze reply and revised offer

- **NDA:** fixed after our comments and signed by Habib. The internal ingress points above can now be shared with Blaze.
- **Revised offer (Caroline, Blaze):**
  - Eviplex goes from 3 to 9 days (web, ~40 API endpoints, iOS/Android, AI: prompt injection, RAG leakage, output handling).
  - The day rate drops from €1,300 to €1,100 for everything.
  - Total: 29 testing days. Core (4 M365 + 3 GCP + 7 LP + 9 Eviplex = 23 d) is €25,300. OSINT (2 d) adds €2,200 and the GKE review of the learning-platform cluster (4 d) adds €4,400.
  - **€31,900 net / €37,961 gross** (was €30,299 / €36,056). The days are hands-on testing only; reporting comes on top at no extra charge.
- **Answers to our 8 questions:**
  1. Endpoints: Blaze says 120 (LP) and 40 (Eviplex) fit the proposal, so no change. **This does not match our inventory** (LP about 160 user-reachable GraphQL ops + about 250 admin/system ops + about 100 REST + 16 Next.js routes; Eviplex about 56 + 5). The authz check on admin/system ops was not confirmed either.
  2. Eviplex: 9 days (see above).
  3. Retest: one round per phase, covering all fixed findings, within 90 days of that phase's report. Overruns beyond the planned 4 h are on Blaze.
  4. Wrap-up: a free 1 h debrief after each phase replaces the single closing workshop. The half-day ISMS workshop (vCISO team) needs our questions before they price it.
  5. DPA: Blaze's Art. 28 DPA (blazeinfosec.com/legal/dpa), signed before testing. Or we send our template.
  6. MSA: blazeinfosec.com/legal/terms; the version in force at signing applies for the whole engagement.
  7. Timeline: decide by mid-November, then Phase 1 (M365) starts in the last week of November. The slot is tentatively blocked.
  8. Redacted sample reports (cloud config, web app, AI/LLM) attached. References: Kaia Health, STADA, TeamViewer.
- **Still open on our side:** endpoint count / admin-op authz in the SOW; Eviplex GmbH as authoriser/signatory for the Eviplex pentest; DPA review (theirs or ours); archive PDFs of MSA + DPA at signing; ISMS workshop questions; back-office tools (Retool) out of scope; test data, test windows and LLM cost cap; Andreas: M365 Global Reader; test accounts in 2 orgs per product for January.

## Update 9 Nov 2026: DocuSign contract received

Blaze sent proposal #2026.11.013 (issued 6 Nov, valid until 6 Dec) via DocuSign, already signed by Julio Fort. The text was updated (Eviplex mobile/AI, ~400 endpoints, Portugal testers, data destruction), but the **price table, retest and workshop are still the 21 Oct offer** (€22,499, Eviplex 3 d, no OSINT/GKE, 4 h retest, one workshop), and the MSA still prevails "as updated from time to time". Not signed; we asked Blaze to reissue. Full review and reply draft: `blaze-contract-review-2026-11-09.md`.
