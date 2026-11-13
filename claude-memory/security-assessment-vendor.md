---
name: security-assessment-vendor
description: "Blaze security assessment: contract signed 9 Nov 2026 (v4, €31,900 net, 29 d); next step = Mahyar gives Blaze the final phase dates"
metadata:
  node_type: memory
  type: project
  originSessionId: ab6f3fd4-c6d2-4f65-bb3c-2214f787b7a6
  modified: 2026-11-06T15:50:39.760Z
---

On 27 Oct 2026 Mahyar chose **Blaze Information Security** (offer #2026.10.030; contacts Jan and Caroline "Carol" Galatoli) over Public Cloud Group (PCG; offer expired 29.08.2026, declined).

**NDA:** after our comments Blaze fixed it, and Habib signed it (by 6 Nov 2026). Internal ingress findings may now be shared with Blaze.

**Revised offer (6 Nov 2026):** Eviplex went from 3 to 9 days, and the rate dropped from €1,300 to €1,100/day for everything. That gives 29 testing days: M365 4, GCP 3 (4 projects), learning-platform pentest 7, Eviplex 9, OSINT 2, GKE review of the LP cluster 4. Price: **€31,900 net / €37,961 gross** (core €25,300). Reporting is extra to the day count but not billed.
- Retest: one round per phase, within 90 days; overrun is on Blaze.
- A free 1 h debrief after each phase. The ISMS workshop (vCISO) needs our questions before they price it.
- They offer their own DPA and MSA (version at signing is fixed).
- Decide by mid-Nov, then Phase 1 starts in the last week of Nov 2026; GCP in Dec; pentests in Jan 2027, all against production.

**9 Nov 2026, DocuSign contract #2026.11.013:** Blaze (Julio Fort) signed, but the price table, retest and workshop were still the 21 Oct offer (€22,499, Eviplex 3 d, OSINT/GKE not selected). The MSA still prevails "as updated from time to time", there's no DPA reference, and the endpoint figures contradict each other (135 vs ~400). Mahyar was advised not to sign and to ask Caroline to reissue. Review and reply: cto-assistant/cybersecurity/blaze-contract-review-2026-11-09.md.

**9 Nov 2026, v4 (#2026.11.014, valid to 9 Dec):** all requested fixes are in: €31,900 with OSINT + GKE, retest and debrief per phase, MSA fixed at the signing version, ~400 GraphQL + ~100 REST incl. an admin-op authz check, DPA referenced in § 8. Verdict: ready to sign. Remaining: USt-IdNr instead of HRB on the acceptance page, invoicing email/PO, signing authority, DPA before Phase 1.

**Still open after 6 Nov:**
- Blaze's 120 LP / 40 Eviplex endpoints vs our inventory (~400 GraphQL ops + ~100 REST on the LP; ~60 on Eviplex); admin-op authz not confirmed.
- Eviplex GmbH as authoriser/signatory.
- DPA review; archive MSA + DPA PDFs at signing.
- ISMS questions.
- Andreas to grant M365 Global Reader; test accounts.

**Why:** PCG has no M365, only an automated scan of the learning platform and nothing on Eviplex. Blaze matches the dropped Mandiant scope (M365 + GCP) plus both products. The GKE add-on targets the in-cluster gaps from [[php2shell-drupal-incident]].
**How to apply:** the full history is in cto-assistant/cybersecurity/vendor-comparison-2026-10.md (see "Update 6 Nov 2026"). Before advising, check whether the contract is signed and the open points are closed.

9 Nov 2026: Carol confirmed by email that the SOW phase months (Nov/Dec/Jan) are not binding; dates are agreed with Blaze's PM team after signing, no contract change needed. MSA 10.3 cancellation fees (25/50/100% inside 15/10/5 working days) apply once a date is agreed, so commit only to dates IT/product teams can meet and reschedule ≥4 weeks ahead.

Signed by Mahyar on 9 Nov 2026 (v4, #2026.11.014). EB memo (DE): cto-assistant/cybersecurity/eb-memo-blaze-2026-11-09.md.

**Status 13 Nov 2026 (Mahyar):** contract signed; next step is to give Blaze the final dates for each phase (M365, GCP, pentests). Pick dates IT and the product teams can meet, because of the MSA 10.3 cancellation fees above. Findings, once they arrive, go in `cto-assistant/cybersecurity/reports/` (git-ignored) and SharePoint.
