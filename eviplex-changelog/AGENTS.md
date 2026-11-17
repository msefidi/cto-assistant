# Eviplex changelog email

Recurring. An internal email that tells FOMF teams (Sales, CS, EB and everyone else) what changed in Eviplex, in plain language, not technical. German, "ihr" form, company-wide. The first edition was drafted on 9 Nov 2026; there was no earlier changelog mail.

## Sources

- Linear view "Eviplex changelog" (done EVP issues, newest first): https://linear.app/fomf/view/eviplex-changelog-a73f93b736b3
- Platform work for Eviplex (e.g. project P-EVP-241 Express registration, built by Platform as PLA issues)
- meviq PRs for features behind flags (state the flag and whether it is on)

## Format

- Mahyar's main points first, then "Außerdem neu", then "Ausblick · noch nicht live".
- Brand rules from `brand/` in the meviq repo: no "empfehlen" or "diagnostizieren", no data-retention claims. § 203 is left out.
- Keep it short (see the memory note `comms-style-short`).

## Files

| File | What |
|---|---|
| `src/2026-11-changelog.template.html` | Template; copy it for the next edition |
| `2026-11-changelog.html` | First edition, logo embedded as base64 (Outlook cannot show SVG) |
| `assets/eviplex-logo-powered-by-fomf-600.png` | Logo PNG, rendered from the Eviplex Brand design-system artifact |

## Next edition

Start from the Linear view's completions after the previous edition's date (the first one covered up to 9 Nov 2026) and reuse the template. Name the new file `YYYY-MM-changelog.html`.
