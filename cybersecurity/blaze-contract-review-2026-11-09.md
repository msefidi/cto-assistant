# Blaze contract review (9 Nov 2026)

Source: `Complete_with_Docusign_FomF_x_Blaze_Security.pdf`, DocuSign envelope F2284869-8C23-86AA-8323-E3E47B055DAF. Commercial proposal **#2026.11.013**, issued 06/11/2026, valid until 06/12/2026. Julio Fort signed for Blaze on 6 Nov. The FomF fields are still empty, with "Mahyar Sefidi" pre-filled as the name.

**Verdict: don't sign yet.** Blaze updated the text, but the price table, retest and workshop are still the **old 21 Oct offer**. The acceptance clause says "accepted in its integrity, without any modifications", so signing it binds us to that old version.

## What the PDF says vs. what Blaze agreed on 6 Nov

| Item | PDF (§ 9 pricing, § 6 deliverables) | Agreed 6 Nov (Caroline's email) |
|---|---|---|
| Day rate | €1,300 | €1,100 |
| Eviplex (web, API, mobile, AI) | 3 days, €3,900 | 9 days, €9,900 |
| Core total | **€22,499** (17 d + €399 workshop) | **€25,300** (23 d) |
| OSINT | Optional, €2,600, not selected | Included, 2 d, €2,200 |
| GKE review (LP cluster) | Optional, €5,200/cluster, not selected | Included, 4 d, €4,400 |
| Grand total | €22,499 (no options) | **€31,900 net / €37,961 gross** |
| Retest | "Up to 4 hours", one round within 90 days of the completed assessment | One round **per phase**, all fixed findings, within 90 days of that phase's report; overruns on Blaze |
| Debrief | One 1 h closing workshop (€399) | Free 1 h debrief **after each phase** |
| MSA | MSA "as updated from time to time", and the MSA **prevails** over the SOW (§ 8) | Version in force at signing applies for the whole engagement |
| DPA (Art. 28) | Not mentioned | Blaze's DPA signed before testing |

## Other points in the PDF

- **Endpoints contradict each other.** The scope table and price table say LP "up to 135 endpoints". The assumptions (§ 5) say the quote is "based on … around 400 endpoints". They need one number. Our inventory: about 407 GraphQL ops + about 100 REST + 16 Next.js routes on the LP; about 56 + 5 on Eviplex (PDF: up to 40).
- **The LP is described as "backend REST APIs".** It is mainly an Apollo GraphQL federation (11 subgraphs). Name GraphQL in the scope so the gateway and subgraphs are clearly covered.
- **Admin/system operations:** we asked that they at least test that normal users can't call them. That isn't written anywhere. "Internal admin and back office tools" stay out of scope, which is fine as long as the authz check on admin ops on the public API is in.
- **Eviplex GmbH** isn't mentioned. FomF GmbH is the only client party. The Eviplex pentest runs against production with data that Eviplex GmbH controls. Eviplex GmbH should at least co-authorise in the Rules of Engagement. This doesn't need to block signing.
- **GCP scope:** 4 projects in europe-west3, "Learning Platform production, Eviplex production, Data Lake and Shared Services". Our known projects are `fomf-v2-prod`, `meviq-prod` and `fomf-dl`. Confirm which project is "Shared Services". (I couldn't check: gcloud needs re-auth.)
- **AI section:** says OpenAI and Gemini run "through EU endpoints". The AVV review found no EU pin for OpenAI (see `eviplex-avv/`). It isn't a contract term, but it shouldn't sit in a document as our statement.
- **Payment:** § 9 says "30 business days of … the invoice" in one sentence and "30 days from the end of the project" in the next. Unused days become credits that expire after 12 months, so we pay in full even if we push a phase.

## Good, and now in the text

- Testers work remotely from Portugal (Blaze's own team, Europe). VulnKeep is hosted in Amsterdam, encrypted.
- Data, credentials and evidence are destroyed within 30 days of retest close, with written confirmation (matches our NDA ask).
- Production safeguards: agreed test windows, pause + notify within 1 h if production degrades, AI usage limits agreed before Phase 3, fixed source IPs 188.166.41.114 and 178.128.142.127.
- ISO 27001 mapping, management summary, remediation roadmap, attestation letter, € 5M Hiscox E&O.

## Before signing

1. Blaze reissues the envelope with the 6 Nov price table (€31,900, OSINT + GKE included), per-phase retest and debriefs, and the fixed MSA version.
2. One endpoint figure (or "about 400 GraphQL operations + REST"), GraphQL named, admin-op authz check written into the scope.
3. A DPA clause or reference: Blaze's Art. 28 DPA signed before any testing. Archive the MSA and DPA PDFs at signing.
4. Confirm signing authority. Habib signed the NDA. Check whether Mahyar can sign a €38k gross order alone or whether it needs a Geschäftsführer/Prokura.
5. Acceptance fields: registered name FomF GmbH (Forum für medizinische Fortbildung), Am Untertor 4, 65719 Hofheim; VAT ID, invoicing email and PO number from Finance (Erfan).

## Reply to Caroline (English)

**Subject:** Re: FomF x Blaze – contract #2026.11.013

Hi Caroline,

thanks for sending the contract via DocuSign. Before I sign, a few points from our call and your email of 6 November didn't make it into the document. Could you send an updated envelope?

1. **Pricing (§ 9):** The table still shows the earlier offer (€1,300/day, Eviplex 3 days, €22,499 total). Please update it to what we agreed: €1,100/day, Eviplex 9 days, core €25,300, plus the OSINT assessment (2 days, €2,200) and the GKE review of the learning-platform cluster (4 days, €4,400) as included items. Total €31,900 net.
2. **Retest:** One round per phase, covering all fixed findings, within 90 days of that phase's report, with any overrun beyond 4 hours on Blaze.
3. **Debriefs:** A free 1-hour debrief after each phase, instead of the single closing workshop.
4. **MSA (§ 8):** Please state that the version of the MSA in force on the signature date applies for the whole engagement, rather than "as updated from time to time".
5. **Endpoints:** The scope says "up to 135 endpoints" for the learning platform, and § 5 says "around 400 endpoints". Please use one figure. The learning-platform API is mainly GraphQL (about 400 operations across 11 subgraphs) plus about 100 REST endpoints. Please name GraphQL in the scope, and include a check that admin and system operations can't be called by normal users.
6. **DPA:** Please reference your Art. 28 DPA in the contract and send it for signature with the envelope, so both are in place before Phase 1.

Small point: § 4.5 says the models run through EU endpoints. Please change it to "OpenAI and Gemini APIs", without the EU part.

With these changes I can sign right away, so Phase 1 can still start in the last week of November.

Best regards,
Mahyar

---

## v4 check (9 Nov 2026, later): ready to sign

Source: `FomF x Blaze Security Assessment v4.pdf`, proposal **#2026.11.014**, issued 09/11/2026, valid until 09/12/2026. It's a plain PDF, not yet a DocuSign envelope, and neither party has signed it.

All 6 requested changes and the EU-endpoint fix are in:

| Point | v4 |
|---|---|
| Pricing | €1,100/day. M365 4 d €4,400 · GCP 3 d €3,300 · LP 7 d €7,700 · Eviplex 9 d €9,900 · OSINT 2 d €2,200 · GKE 4 d €4,400 (one LP cluster) = **€31,900 net** (≈ €37,961 gross) ✅ |
| Retest | One round per phase, all fixed findings, within 90 days of that phase's report; extra time beyond 4 h per phase absorbed by Blaze (§ 6.2 and § 9) ✅ |
| Debriefs | 3 × 1 h, one after each phase, free ✅ |
| MSA | The version in force on the signature date applies for the whole engagement (§ 8) ✅ |
| Endpoints | ~400 GraphQL ops across 11 subgraphs + ~100 REST, the same in the scope, the assumptions and the price table. Includes an explicit check that normal users can't call admin/system GraphQL/REST ops ✅ |
| DPA | § 8: the engagement is governed by the NDA incl. Amendment No. 1 and by an Art. 28 DPA "to be signed before any testing starts" ✅ |
| AI models | "OpenAI and Gemini APIs", no EU claim ✅ |

Still to do (none of it blocks signing):
- Acceptance page: the tax-number field says "Handelsregister: HRB 78202". Put in the USt-IdNr instead (from Erfan), plus the invoicing email and PO number (or N/A).
- Check that the DocuSign envelope is #2026.11.014 at €31,900, not the old #2026.11.013.
- Signing authority (Habib signed the NDA).
- Sign the DPA before Phase 1, and archive the MSA (blazeinfosec.com/legal/terms) as a PDF on the signature date.
- Eviplex is still "up to 40 endpoints" (ours: ~56 routes, 37 of them admin). The re-scope clause covers this. Raise it at the Phase 3 kick-off, together with Eviplex GmbH co-authorising in the Rules of Engagement.
- Confirm which GCP project is "Shared Services" at the Phase 2 kick-off.
- Minor, unchanged: payment terms say "30 business days" after the invoice in one sentence and "30 days from the end of the project" in the next.

## Dates and cancellation (MSA check, 9 Nov 2026)

The SOW gives no fixed dates. It says M365 in Nov 2026, GCP in Dec 2026 and pentests in Jan 2027, all as plans. The binding rules are in the MSA (blazeinfosec.com/legal/terms, "last update 16 Oct 2026"). This is a summary from a web fetch, so check the exact wording before relying on it:
- 2.6: Blaze and FomF agree the schedule together. Delays caused by the client "may necessitate … payment of additional fees, at the sole discretion of the Contractor".
- 10.3: cancelling within 15 working days of the scheduled start costs 25% "of the quotation". Within 10 working days it costs 50%, and within 5 working days 100%. Rescheduling with at least 4 weeks' notice turns the days into credits.
- 4.6 + SOW § 9: undelivered tranches become prepaid credits. Payment is due 30 days after the end of the project, and credits expire 12 months after contract start.
- 9.2: termination for convenience on 30 days' notice. Only services already performed are paid.

Risk: once a phase start is agreed, a postponement at short notice costs money. "Of the quotation" could mean the whole €31,900, not just that phase. Phase 1 (planned for the last week of November) is the closest: it's about 10 working days away, so it's already inside the 50% window if that date is treated as agreed.

**Carol's answer (9 Nov 2026):** "No, the dates are not binding at all." Clients agree dates with Blaze's Project Management team after signing. The SOW months were only a suggestion and can change without amending the contract. Keep this email with the signed contract. Once dates are agreed with the PM team, MSA 10.3 applies to them: only commit to dates IT and the product teams can meet, and move them at least 4 weeks ahead.

## LP pentest days (9 Nov 2026)

The LP keeps 7 days although the scope grew from 135 endpoints to ~400 GraphQL ops + ~100 REST. Eviplex has 9 days for ~40 endpoints, but it covers 4 surfaces (web, API, iOS/Android, AI). Our earlier estimate for the LP was 10–12 days (+3–5 d, +€3.3–5.5k net at €1,100). Plan: sign now, ask Carol how 7 days covers the LP scope, get a quote for +3 days at €1,100/day, and add them before the Phase 3 kick-off (January) if her answer is thin.
