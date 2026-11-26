# Security assessment with Blaze

An outside security assessment of FOMF: a configuration review of Microsoft 365 and Google Cloud, manual pentests of the learning platform and of Eviplex (web, API, iOS/Android, AI assistant), an OSINT check of the external attack surface and a review of the learning-platform GKE cluster. It is part of the cybersecurity priority in the root `AGENTS.md`. Mahyar owns it. The search started with Mandiant, dropped in July 2026 as too expensive. Blaze Information Security was chosen over PCG on 27 Oct 2026, and Mahyar signed the contract on 9 Nov 2026.

Since 18 Nov 2026 this folder also holds the start of **IT security management** with Andreas (devices, Entra and access, SharePoint, Exchange): a baseline in `it-security-management-2026-11-18.md`, to become the 2027 roadmap on 21 Dec with Blaze's Phase 1 input. That work runs on its own Linear board (Andreas's team); if it grows beyond the roadmap, it becomes its own topic.

## Status

**As of 25 Nov 2026:** Contract v4 (#2026.11.014, €31,900 net, 29 days) and Blaze's Art. 28 DPA signed since 9 Nov. Blaze confirmed our timeline on 16 Nov, in the client portal (ticket BCP-26), with exact dates: M365 7–10 Dec 2026; GCP 6–8 Jan 2027; OSINT 11–12 Jan; GKE 18–21 Jan; Eviplex pentest 25 Jan–4 Feb; learning-platform pentest 1–9 Feb. Our reply was missed until 25 Nov, because it came only as portal notifications. MSA 10.3 cancellation fees now apply to these dates. IT security management with Andreas has a first baseline (`it-security-management-2026-11-18.md`).

- **Next step:** answer Mariana: Phase 1 kick-off slot (Mon 30 Nov, 14:00–15:00 CET, Mahyar and Andreas), confirmation of the Phase 1 debrief by 11 Dec, and Phase 2 start 6 Jan with its kick-off in the week of 7 Dec. Then post the exact dates in #p-cybersecurity-assessment and make sure Andreas grants M365 Global Reader before 7 Dec and GCP access is ready by 6 Jan.
- **Next date:** Phase 1 kick-off, offered 30 Nov, 2 Dec or 3 Dec; Phase 1 testing 7–10 Dec, debrief by 11 Dec.
- **IT security management:** next is the in-person meeting on 21 Dec to set the 2027 roadmap, adjusted with Blaze's Phase 1 (M365) input. Mahyar follows up on the Mac surveys (CTO-24).
- **Waiting on:** Mahyar, to pick the kick-off slot and answer the GCP start question.

## Goal

All six parts tested, each phase reported and debriefed, the fixed findings retested within 90 days of each phase's report, and Blaze's attestation letter received. With the weeks we propose, testing ends in the week of 8 Feb 2027. Behind this sit two aims from 27 Oct: fix most security issues, and prepare for ISO 27001, at least for Eviplex. A pentest alone does not make FOMF ISO-ready; that needs a separate ISMS track.

## People

| Who | Role here |
|---|---|
| Mahyar | Owner. Chose the vendor, signed the contract on 9 Nov, agrees dates with Blaze |
| Habib (Habib Modabber) | CGO. Signed the NDA and its Amendment No. 1; checked the first DocuSign envelope |
| Sina (in Outlook and Teams: Martin S. Taheri) | Asked in the EB chat how often such a check should run |
| Erfan (Erfan Abedian) | CFO. Supplies the VAT ID, invoicing email and PO number for Blaze |
| Andreas (Head of IT; Andreas Langer in Slack) | Grants Blaze M365 Global Reader for Phase 1 and supports the M365 phase. Owns IT security management (devices, Entra, SharePoint, Exchange) and its Linear board. Event high season until 28 Nov; vacation from 27 Dec |
| Shervin | Supports Andreas with GCP/GKE access and configuration for Blaze; blocks the proposed weeks (asked 16 Nov) |
| Simone, George, Rahim | EM Productivity, EM Platform, TL Backend. Kept informed; test accounts, data and windows before the January pentests; fixes land in their teams as product work |
| Caroline "Carol" Galatoli (Blaze) | Cybersecurity Account Executive. Offers, contract, DPA |
| Mariana Teixeira (Blaze, PM Europe) | Schedules the kick-off call before each phase |
| Jan Weis (Blaze, in copy) | Blaze contact. Also wrote from Exaspace Security offering separate consulting |
| Julio Fort (Blaze) | Co-founder; signs for Blaze |
| Alexander "Alex" Stati (PCG) | Account manager of the declined vendor |
| Eviplex GmbH | Controller of Eviplex data; should co-authorise the Eviplex pentest (not yet arranged) |

## Open points

- Phase 1 kick-off slot and Phase 2 start (6 or 11 Jan) still to answer in BCP-26. Dates are confirmed, so MSA 10.3 cancellation fees apply; Andreas must hold 7–10 Dec. (owner: Mahyar)
- M365 Global Reader for Blaze before Phase 1; whether it is granted is not recorded. (owner: Andreas)
- Test accounts in two organisations per product for the January pentests; test data, test windows and the AI usage limit before Phase 3. (owner: Mahyar)
- The learning-platform pentest keeps 7 days although the scope grew to about 400 GraphQL operations and 100 REST handlers. Plan of 9 Nov: ask Carol how 7 days cover it, get a quote for 3 more days (€3,300 net at €1,100) and add them before the Phase 3 kick-off if her answer is thin. (owner: Mahyar)
- Eviplex is still "up to 40 endpoints" in v4 (ours: about 56 routes plus 5). Raise it at the Phase 3 kick-off, together with Eviplex GmbH co-authorising in the Rules of Engagement. (owner: Mahyar)
- Which GCP project is Blaze's "Shared Services"; confirm at the Phase 2 kick-off. Our known projects are `fomf-v2-prod`, `meviq-prod` and `fomf-dl`. (owner: Mahyar)
- Acceptance page of v4: VAT ID instead of HRB, invoicing email and PO number. Whether this was fixed at signing is not recorded. (owner: Mahyar, with Erfan)
- Signing authority: Mahyar signed a €37,961 gross order alone; whether that needed a Geschäftsführer or Prokura is not recorded. (owner: Mahyar)
- Archive the signed v4, the DPA, the NDA with Amendment No. 1, the MSA as of 9 Nov (blazeinfosec.com/legal/terms) and Carol's "dates not binding" email of 9 Nov in SharePoint. Where they are is not recorded. (owner: Mahyar)
- ISMS workshop: Blaze needs our questions before it can price it. (owner: Mahyar)
- Back-office tools (Retool, admin consoles) are out of scope. Include them or accept the gap. (owner: Mahyar)
- IT security management: 2027 roadmap with Andreas in person on 21 Dec, built on the 18 Nov baseline and Blaze's Phase 1 input. Needs the M365 phase and its debrief done by 11 Dec; the brief says Mahyar is away from 14 Dec, so check the 21 Dec date. (owner: Mahyar, with Andreas)
- Eli Lilly commitments: change management and the data inventory were due 1 Sep 2026 and are still open; security training is due 31 Dec 2026. Cover them in the 21 Dec roadmap (section 5 of `it-security-management-2026-11-18.md`). Replaces CTO-9 "Review quick wins with Andreas". (owner: Mahyar, with Andreas)
- Mac surveys (engineers and unit leads, Andreas's MS Forms) before onboarding Macs into device management. (owner: Mahyar; CTO-24)
- Andreas's Linear board for IT security management: not created yet; add it to the source map once it exists. (owner: Andreas)
- How often to repeat the assessment. Mahyar said once a year, later with more automated tools; not decided. (owner: Mahyar)

## Rules

- **Findings stay out of this brief, the log and the decisions.** Blaze's reports and findings go in `reports/` (git-ignored) and in SharePoint, and never into external tools.
- Only commit to dates that IT and the product teams can meet. Once a date is agreed, MSA 10.3 applies: cancelling within 15, 10 or 5 working days of the start costs 25, 50 or 100 % "of the quotation"; rescheduling at least 4 weeks ahead turns the days into credits.
- Internal security details go to Blaze only under the NDA, which is now signed.
- Requests to Blaze (a new test, a retest) go through the Blaze Client Portal.
- English with Blaze; German for the EB and IT, as in the root `AGENTS.md`.
- Contract prices may appear in this folder (the repo is private), but not in external tools.

## Source map

Where this topic lives outside this folder. A catch-up searches every row.

| Where | What to search or open |
|---|---|
| Outlook | Search `Blaze`, `blazeinfosec.com`, `Pentest`, `Security Assessment`, `PCG`, `Mandiant`. Threads: "Ihre Anfrage für einen Pentest bei Blaze Information Security" (main thread with Carol, cc Jan Weis and Habib: offers, answers, the 9 Nov "dates not binding" mail); "NDA \| Blaze <> FOMF", "NDA Blaze addition/changes", "NDA Blaze" (Habib, Amendment No. 1); "Blaze Contract" (Habib, 3 Nov); "Completed: Complete with Docusign: DPA FomF.docx.pdf, FomF x Blaze Security Assessment v4.pdf" (signed PDFs attached); "Kick-off call \| Blaze x FomF - Penetration test" (Carol, Mariana Teixeira, pm-europe@ and service-delivery@blazeinfosec.com); "[BCP-26] Kick-off call \| Blaze x FomF - Penetration test" (portal notifications from jira@blazeinfosec.atlassian.net: Mariana's replies arrive only this way, easy to miss); "Your access to Blaze Client Portal". PCG: "Fomf <> PCG Security Check - Google", "Kurze Frage zu unserem Projekt" (Alexander Stati). Exaspace: "InfoSec Consulting" (Jan Weis). |
| Teams | Search `Blaze OR Pentest OR "Security Assessment" OR Mandiant`. Group chat "Executive Board" (15 Oct, 26 Oct, EB memo 9 Nov, Sina's question 10 Nov); Mahyar's 1:1 chat with Habib (NDA, 27 Oct and 9 Nov). |
| Slack | Private channel #p-cybersecurity-assessment (C0CHXPGCWHH), created 16 Nov with Andreas, Shervin, Simone, George and Rahim: the team's project channel. Mahyar's DM with Andreas (D01N5T0MV9B): thread of 12 Nov on Blaze's dates (high season, 7 Dec earliest, vacation from 27 Dec); thread of 8 Oct with the Mac survey forms (engineers: "Engineering Hardware Survey – Zusammenarbeit"; unit leads). Not searched more widely. |
| SharePoint | Not searched yet. The place for the signed contract, DPA, NDA and the reports is not recorded. |
| Notion | Not searched yet. |
| Linear | Board issue CTO-2 (private team cto-assistant), sub-issue CTO-24 (Mac surveys). Project "Eli Lilly Cybersecurity" (P-ENG-190, lead Andreas): the quick wins promised to Eli Lilly, with a requirements table in its description. IT security management gets its own board under Andreas; not created yet (18 Nov). The Blaze assessment has no Linear project (checked 15 Nov 2026). |
| Other | Blaze Client Portal (blazeinfosec.atlassian.net; access since 12 Nov; scheduling ticket BCP-26); Blaze's VulnKeep portal for findings; DocuSign; Blaze MSA blazeinfosec.com/legal/terms and DPA blazeinfosec.com/legal/dpa. |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
| `vendor-comparison-2026-10.md` | PCG vs Blaze, ISO 27001 path, API inventory, open points before signing, updates of 6 and 9 Nov. Its "Internal only" section holds security details: do not copy them out |
| `blaze-nda-review-2026-10-27.md` | Review of Blaze's NDA and the reply to Carol |
| `blaze-contract-review-2026-11-09.md` | Review of #2026.11.013, the v4 check, the MSA date and cancellation rules, the learning-platform days |
| `email-drafts-2026-10-27.md` | Mails of 27 Oct: questions to Blaze (DE), decline to PCG (DE) |
| `email-draft-blaze-dates-2026-11-16.md` | Reply to Blaze with the weekly phase timeline and the reasons (EN), sent 16 Nov |
| `slack-draft-team-onboarding-2026-11-16.md` | Slack onboarding for Andreas, Shervin, Simone, George and Rahim (EN), posted 16 Nov in #p-cybersecurity-assessment |
| `it-security-management-2026-11-18.md` | IT security management baseline from Mahyar's 1:1 with Andreas on 18 Nov: devices, Entra and access, SharePoint, Exchange. Input for the 2027 roadmap on 21 Dec. Describes gaps: keep it off Linear and other external tools |
| `eb-memo-blaze-2026-11-09.md` | EB memo (DE) on the signed contract |
| `eviplex-field-encryption.html` | Design draft of 2 Nov 2026 for field-level encryption of Eviplex conversations, so Google cannot read them (§ 203 StGB). It belongs to the Eviplex § 203 / Google gap work (`../eviplex/avv/`, wording in `../eviplex/knowledge/claims-and-legal.md`), not to this assessment. Moving it is proposed, not confirmed by Mahyar |
| `reports/` | Blaze's findings and reports. Git-ignored; not created yet. Originals in SharePoint |

## Contract at a glance

Proposal v4, #2026.11.014, signed 9 Nov 2026, with Blaze's Art. 28 DPA. Day rate €1,100.

| Part | Days | Net |
|---|---|---|
| Phase 1: Microsoft 365 configuration | 4 | €4,400 |
| Phase 2: Google Cloud configuration (4 projects) | 3 | €3,300 |
| Phase 3: learning-platform pentest (about 400 GraphQL operations, about 100 REST) | 7 | €7,700 |
| Phase 3: Eviplex pentest (web, API, iOS/Android, AI) | 9 | €9,900 |
| OSINT and external attack surface | 2 | €2,200 |
| GKE review of the learning-platform cluster | 4 | €4,400 |
| **Total** | **29** | **€31,900 (about €37,961 gross)** |

- Retest: one round per phase, all fixed findings, within 90 days of that phase's report; time beyond 4 h per phase is on Blaze.
- Debriefs: a free 1 h debrief after each phase.
- Deliverables: ISO 27001 mapping, management summary, remediation roadmap, attestation letter. Reporting comes on top of the days at no charge.
- MSA: the version in force on the signature date applies for the whole engagement.
- Testers work remotely from Portugal; data and evidence are destroyed within 30 days of retest close, with written confirmation.
- Payment: due 30 days after the end of the project (one sentence says 30 business days after the invoice). Undelivered days become credits that expire 12 months after the contract start.
