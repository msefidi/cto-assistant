# Eviplex: how brand work is organised

The brand itself (messages, voice, claims, look) is in the meviq repo; this file says how it is organised and how to work on it. Concept agreed with Mahyar on 12 Nov 2026; the history is in meviq PRs #1072 (closed), #1102 (merged) and #1103 (design system), and their commits.

- **Words:** meviq `brand/`: `README.md` (the brand book), `texts.de.md` (official German texts), `brand.json` (tokens). Changes go through PRs that Shadi and Anika approve.
- **Look:** the code is the source: colours, logos and assets in `web/shared-brand` (Eviplex config). `brand.json` is updated in the same PR. Marketing's print colours (#0077C8, #1B365D) and print logo variants stay in Notion Brand Assets, for print only.
- **What is published is the brand:** eviplex.com copy, the App Store and Google Play listings and the LinkedIn posts. A new message on one of them is a brand change.
- **Owners:** Shadi (design) and Anika (marketing) approve every change and sign off claims. Eviplex GmbH owns brand and trademark; FOMF hosts them in its repo.
- **One design system:** "EVP - DS Web", built from the code by `web/design-system`, tokens exactly as in code. The brand book is a separate generated HTML page, "Eviplex Brand Book", not a design system. The old "Eviplex Brand" design-system artifact (https://claude.ai/artifact/VAyMzP5CT8fHRVadtH8wCM) is to be retired once that page is live; check before using it.
- **Notion** (03 - Marketing / Brand) stays Marketing's hub for pitches, videos, trainings and print files.

## Syncing the design-system artifacts

- Copy `out/` to the scratchpad; the Artifact tool reads only the working directory and the scratchpad.
- An asset upload creates a new version: do a full `read` of the artifact before the files publish, and publish the index last.
- The DS page appends its own "Consuming this system / Index" section to `README.md`; keep it when republishing.
