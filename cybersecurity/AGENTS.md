# Security assessment with Blaze

An outside security assessment of FOMF: a configuration review of Microsoft 365 and Google Cloud, manual pentests of the learning platform and of Eviplex (web, API, iOS/Android, AI assistant), an OSINT check of the external attack surface and a review of the learning-platform GKE cluster. It is part of the cybersecurity priority in `cto-assistant/CLAUDE.md`. Mahyar owns it. The search started with Mandiant, dropped in July 2026 as too expensive. Blaze Information Security was chosen over PCG on 27 Oct 2026, and Mahyar signed the contract on 9 Nov 2026.

## Status

**As of 16 Nov 2026:** Contract v4 (#2026.11.014, €31,900 net, 29 days) and Blaze's Art. 28 DPA were signed on 9 Nov. Blaze proposed phase dates on 12 Nov, starting with M365 on 23–26 Nov. Those dates do not work: Andreas is in event high season until 28 Nov, Mahyar is away from 14 Dec, and nobody can support the work from 25 Dec to 5 Jan. On 16 Nov Mahyar sent Blaze a weekly timeline (`email-draft-blaze-dates-2026-11-16.md`) in which Blaze fits its own dates: only Phase 1 and its debrief in December, GCP and everything else from 6 Jan, same phase order.

- **Next step:** wait for Blaze to confirm the weeks and set exact dates; make sure Andreas holds the week of 7 Dec (he called it optimistic) and that GCP access for Blaze is ready by 6 Jan.
- **Next date:** proposed weeks, one per part: Phase 1 kick-off week of 30 Nov; M365 week of 7 Dec, with the debrief by 11 Dec; GCP 6–8 Jan, kick-off in the same week; OSINT week of 11 Jan; GKE week of 18 Jan; Eviplex pentest from 25 Jan; learning-platform pentest from 1 Feb 2027.
- **Waiting on:** Blaze's answer to the timeline sent on 16 Nov. The team was onboarded the same day in #p-cybersecurity-assessment; post the exact dates there once Blaze confirms.

## Goal

All six parts tested, each phase reported and debriefed, the fixed findings retested within 90 days of each phase's report, and Blaze's attestation letter received. With the weeks we propose, testing ends in the week of 8 Feb 2027. Behind this sit two aims from 27 Oct: fix most security issues, and prepare for ISO 27001, at least for Eviplex. A pentest alone does not make FOMF ISO-ready; that needs a separate ISMS track.

## People

| Who | Role here |
|---|---|
| Mahyar | Owner. Chose the vendor, signed the contract on 9 Nov, agrees dates with Blaze |
| Habib (Habib Modabber) | CGO. Signed the NDA and its Amendment No. 1; checked the first DocuSign envelope |
| Sina (in Outlook and Teams: Martin S. Taheri) | Asked in the EB chat how often such a check should run |
| Erfan (Erfan Abedian) | CFO. Supplies the VAT ID, invoicing email and PO number for Blaze |
| Andreas (Head of IT; Andreas Langer in Slack) | Grants Blaze M365 Global Reader for Phase 1 and supports the M365 phase. Event high season until 28 Nov; vacation from 27 Dec |
| Shervin | Supports Andreas with GCP/GKE access and configuration for Blaze; blocks the proposed weeks (asked 16 Nov) |
| Simone, George, Rahim | EM Productivity, EM Platform, TL Backend. Kept informed; test accounts, data and windows before the January pentests; fixes land in their teams as product work |
| Caroline "Carol" Galatoli (Blaze) | Cybersecurity Account Executive. Offers, contract, DPA |
| Mariana Teixeira (Blaze, PM Europe) | Schedules the kick-off call before each phase |
| Jan Weis (Blaze, in copy) | Blaze contact. Also wrote from Exaspace Security offering separate consulting |
| Julio Fort (Blaze) | Co-founder; signs for Blaze |
| Alexander "Alex" Stati (PCG) | Account manager of the declined vendor |
| Eviplex GmbH | Controller of Eviplex data; should co-authorise the Eviplex pentest (not yet arranged) |

## Open points

- Blaze to confirm the weekly timeline sent on 16 Nov. Once agreed, MSA 10.3 cancellation fees apply, and the week of 7 Dec is already within 15 working days, so Andreas must hold it. (owner: Mahyar)
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
- How often to repeat the assessment. Mahyar said once a year, later with more automated tools; not decided. (owner: Mahyar)

## Rules

- **Findings stay out of this brief, the log and the decisions.** Blaze's reports and findings go in `reports/` (git-ignored) and in SharePoint, and never into external tools.
- Only commit to dates that IT and the product teams can meet. Once a date is agreed, MSA 10.3 applies: cancelling within 15, 10 or 5 working days of the start costs 25, 50 or 100 % "of the quotation"; rescheduling at least 4 weeks ahead turns the days into credits.
- Internal security details go to Blaze only under the NDA, which is now signed.
- Requests to Blaze (a new test, a retest) go through the Blaze Client Portal.
- English with Blaze; German for the EB and IT, as in `cto-assistant/CLAUDE.md`.
- Contract prices may appear in this folder (the repo is private), but not in external tools.

## Source map

Where this topic lives outside this folder. A catch-up searches every row.

| Where | What to search or open |
|---|---|
| Outlook | Search `Blaze`, `blazeinfosec.com`, `Pentest`, `Security Assessment`, `PCG`, `Mandiant`. Threads: "Ihre Anfrage für einen Pentest bei Blaze Information Security" (main thread with Carol, cc Jan Weis and Habib: offers, answers, the 9 Nov "dates not binding" mail); "NDA \| Blaze <> FOMF", "NDA Blaze addition/changes", "NDA Blaze" (Habib, Amendment No. 1); "Blaze Contract" (Habib, 3 Nov); "Completed: Complete with Docusign: DPA FomF.docx.pdf, FomF x Blaze Security Assessment v4.pdf" (signed PDFs attached); "Kick-off call \| Blaze x FomF - Penetration test" (Carol, Mariana Teixeira, pm-europe@ and service-delivery@blazeinfosec.com); "Your access to Blaze Client Portal". PCG: "Fomf <> PCG Security Check - Google", "Kurze Frage zu unserem Projekt" (Alexander Stati). Exaspace: "InfoSec Consulting" (Jan Weis). |
| Teams | Search `Blaze OR Pentest OR "Security Assessment" OR Mandiant`. Group chat "Executive Board" (15 Oct, 26 Oct, EB memo 9 Nov, Sina's question 10 Nov); Mahyar's 1:1 chat with Habib (NDA, 27 Oct and 9 Nov). |
| Slack | Private channel #p-cybersecurity-assessment (C0CHXPGCWHH), created 16 Nov with Andreas, Shervin, Simone, George and Rahim: the team's project channel. Mahyar's DM with Andreas (D01N5T0MV9B): thread of 12 Nov on Blaze's dates (high season, 7 Dec earliest, vacation from 27 Dec). Not searched more widely. |
| SharePoint | Not searched yet. The place for the signed contract, DPA, NDA and the reports is not recorded. |
| Notion | Not searched yet. |
| Linear | No project for this (checked 15 Nov 2026). "Eli Lilly Cybersecurity" (P-ENG-190) is a different matter by its name. |
| Other | Blaze Client Portal (blazeinfosec.atlassian.net; access since 12 Nov); Blaze's VulnKeep portal for findings; DocuSign; Blaze MSA blazeinfosec.com/legal/terms and DPA blazeinfosec.com/legal/dpa. |

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
| `eb-memo-blaze-2026-11-09.md` | EB memo (DE) on the signed contract |
| `eviplex-field-encryption.html` | Design draft of 2 Nov 2026 for field-level encryption of Eviplex conversations, so Google cannot read them (§ 203 StGB). It belongs to the Eviplex § 203 / Google gap work (`../eviplex-avv/`, wording in `../eviplex/claims-and-legal.md`), not to this assessment. Moving it is proposed, not confirmed by Mahyar |
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
