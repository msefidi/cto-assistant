---
name: eviplex-ch-tech-factsheet
description: Oct 2026 Eviplex CH pitch + 3-slide technical fact sheet for Swiss hospitals (Hirslanden); legal wording decisions and open § 203 gaps; Google PSA status (11 Nov: PAYG template close, Enterprise Agreement needed for CH)
metadata:
  node_type: memory
  type: project
  originSessionId: ca082a45-0d39-4e95-9a76-bd0391e4bb5e
  modified: 2026-11-11T00:00:00.000Z
---

Built 8 Oct 2026 for Benignia (FOMF CH office) and Wafa, who are selling Eviplex B2B to Swiss hospitals (Hirslanden Zürich asked; cantonal DPOs may demand Swiss servers).
File: SharePoint eng › 09-Eviplex/Marketing Planung/03_Pitches/Eviplex final/"Eviplex V 1_1 (final) - CH - mit Tech-Factsheet.pptx" (pricing slide removed; slides 9–11 = fact sheet: architecture, data protection, security).

Decisions by Mahyar: EU hosting only, no Swiss-hosting offer; BigQuery not mentioned; OpenAI named explicitly; "§ 203 StGB" → "§ 203 dStGB" in CH deck; lawyer (Risch-Kerst opinion) wording: OpenAI's § 203 obligation "wirkt analog" for Art. 321 StGB (CH).

Facts as of 8 Oct 2026 (per Mahyar): only OpenAI has signed a § 203 confidentiality agreement; FOMF↔Eviplex agreement exists; Elastic gets no patient-related data; Datadog does not monitor LLMs; Braintrust gets masked names (PR #1005).
Remaining gap: Google Cloud (stores conversations, Google-managed keys, no § 203 addendum) — so "lückenlose Verschwiegenheitskette" was dropped from the footnote until that's closed. Encryption at rest does not remove Google from scope.

**Why:** hospital CTO/DPO will test every claim; Eviplex GmbH holds liability.
**How to apply:** before reusing the fact sheet (e.g. AT/DE versions), re-check these gaps and the code (meviq repo found on 7 Oct: chat still via Vercel AI Gateway, NER observe-only — Mahyar said both fixed same day; gateway still in path on 3 Nov, see [[eviplex-avv-review]]). Google NDA n91499 (Google Ireland ↔ FomF GmbH, Baden AT — the correct FOMF contracting entity per Mahyar) + proposed § 203 clause sent 5 Aug 2026; clause is inference-only (its para 5 forbids persistent storage) so it does not cover Cloud SQL/GKE/Storage — needs revision. Thread "Urgent: Gemini API Usage / Privacy Agreement" (Alex Vassileva, Rojan Gharadaghy). Possible fix for Google: CMEK + Access Transparency/Approval (~1 week) plus Google's § 203 addendum if one exists.

Update 9 Oct 2026: Google (Alex) declined custom § 203 language but offered (a) CDPA review, (b) Assured Workloads EU Data Boundary + personnel controls + Access Approval/Transparency, (c) Confidential Computing, (d) Cloud Master Agreement (CMA — FOMF currently has only the NDA, no CMA) + **Professional Secrecy Addendum (PSA, "Berufsgeheimnisträger-Addendum") for DACH healthcare**, eligibility-gated. PSA is the real fix for the Google gap; open questions: eligibility for a SaaS processor serving doctors (not itself a Geheimnisträger), CH/AT coverage, CMA+PSA bundled. Call proposed Mon 12 Oct afternoon.

Update 26 Oct 2026 (per Mahyar): Eviplex **Plus and Pro are the § 203-compliant tiers** ("Erweiterter Datenschutz"); Free is not, which is why Free warns on real patient names. The Patient Context feature (named patient records + documents) is Plus/Pro only. Unconfirmed whether the Google PSA/CMA was signed; ask before claiming the Google gap is closed.

Update 11 Nov 2026 (Mahyar + Habib met Google): first PSA is close. Google has two PSA versions: (1) **pay-as-you-go** customers (FOMF's current way of buying GCP) — fixed, non-negotiable template, good for DE + AT, not optimised for CH; (2) **Enterprise Agreement** customers — negotiable. Plan: get (1) as the minimum now, then negotiate an Enterprise Agreement to get a better PSA that can cover Switzerland. Until (2) exists, treat CH (Art. 321 StGB) as not covered by Google's PSA. Still unsigned as of 11 Nov.

Update 16 Nov 2026: Google has the final pay-as-you-go PSA (DE) ready for DocuSign since 11 Nov ("DRAFT version - PSA" mail); it waits on FOMF to name the signer and on counsel review. Log in cto-assistant/eviplex-avv/docs/log.md.
