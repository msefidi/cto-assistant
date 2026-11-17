---
name: eviplex-brand-concept
description: "Eviplex brand: words live in meviq brand/, the look follows the code (web/shared-brand); one design system (EVP - DS Web); brand book a separate generated page"
metadata:
  type: project
---

Concept agreed with Mahyar on 12 Nov 2026. The history is in the meviq PRs (#1072 closed, #1102 merged, #1103 for the design system) and their commits; check GitHub for the current state.

- **Words:** `brand/` in the meviq repo (README.md = brand book text, texts.de.md = official German texts, brand.json = tokens). Marketing approves changes on PRs.
- **Look:** the code is the source: colours, logos and assets in `web/shared-brand` (Eviplex config); brand.json is updated in the same PR. Marketing's print colours (#0077C8, #1B365D) and print logo variants stay in Notion Brand Assets for print only.
- **One design system:** "EVP - DS Web" (built from the code by `web/design-system`, tokens exactly as code). The brand book is a separate generated HTML page "Eviplex Brand Book", not a design system. The old "Eviplex Brand" design-system artifact (https://claude.ai/artifact/VAyMzP5CT8fHRVadtH8wCM) is to be retired once that page is live.
- **Owners:** Shadi and Anika sign off brand values and claims ([[anika-eviplex-marketing]]). Eviplex GmbH owns brand and trademark; FOMF hosts it.
- **What is published is the brand:** eviplex.com copy (`web/marketing/messages/de-DE.json`), the App Store listing and LinkedIn posts count as brand source.
- **Claims:** privacy, § 203, DSGVO and ZDR claims marked "Zu prüfen" are not published until Shadi and Anika confirm. "EU servers" and "Frankfurt" are the same: write "ausschließlich auf ISO 27.001 zertifizierten EU-Servern". Data sent to OpenAI is not anonymised (covered by ZDR and the professional secrecy terms), so website wording that says otherwise is wrong (Linear EVP-1349). "Eviplex" in running text, EVIPLEX only as the logo.

Sync lessons for the design-system artifacts: copy `out/` to the scratchpad (the Artifact tool reads only cwd and scratchpad); an asset upload creates a new version, so do a full `read` before the files publish and publish the index last; the DS page appends its own "Consuming this system / Index" section to README.md, keep it when republishing.

**Why:** the brand existed in three copies (Notion, repo mirror, artifact) with manual sync and no review gate on binding wording.

**How to apply:** for Eviplex copy or designs, follow the brand voice rules in `brand/` (banned verbs, fixed wordings, Sie). Brand work lands in the meviq repo (local checkout `/Users/mahyar/Development/Repositories/fomf/meviq`), not in cto-assistant. Related: [[eviplex-ch-tech-factsheet]].
