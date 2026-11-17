---
name: eviplex-ch-tech-factsheet
description: "Eviplex CH pitch + tech fact sheet (Oct 2026): approved § 203 wording for external claims; Google Cloud is a gap until the PSA is signed (status in eviplex-avv)"
metadata:
  type: project
---

Built 8 Oct 2026 for Benignia (FOMF CH office) and Wafa, who sell Eviplex B2B to Swiss hospitals (Hirslanden Zürich asked; cantonal DPOs may demand Swiss servers). File: SharePoint eng › 09-Eviplex/Marketing Planung/03_Pitches/Eviplex final/"Eviplex V 1_1 (final) - CH - mit Tech-Factsheet.pptx" (slides 9–11 = fact sheet: architecture, data protection, security; pricing slide removed).

Wording decisions by Mahyar, to reuse in any external claim:
- EU hosting only, no Swiss-hosting offer (the UAE deck differs, see [[eviplex-uae-pitch]]). BigQuery not mentioned. OpenAI named explicitly.
- CH deck says "§ 203 dStGB". Counsel's wording (Risch-Kerst): OpenAI's § 203 obligation "wirkt analog" for Art. 321 StGB (CH).
- "Lückenlose Verschwiegenheitskette" is not used while Google Cloud is a gap: it stores conversations with Google-managed keys and has no signed § 203 addendum yet. Encryption at rest does not take Google out of scope. Until an Enterprise Agreement PSA exists, treat CH (Art. 321 StGB) as not covered by Google. PSA status and history: `cto-assistant/eviplex-avv/` (brief and log).
- Eviplex **Plus and Pro are the § 203 tiers** ("Erweiterter Datenschutz"); Free is not, which is why Free warns on real patient names (Mahyar, 26 Oct 2026).

**Why:** hospital CTOs and DPOs test every claim; Eviplex GmbH holds the liability.

**How to apply:** before reusing the fact sheet (AT/DE versions, partners), re-check each claim against the code and the AVV brief; the subprocessor facts it states were true on 8 Oct 2026 only. Related: [[eviplex-avv-review]], [[eviplex-document-upload-answer]].
