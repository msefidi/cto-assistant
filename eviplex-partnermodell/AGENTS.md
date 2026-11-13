# Eviplex Partnermodell

Commission model and partner contract for Eviplex sales partners. First partners: Medichub (Romania, referral of doctors) and Webop (surgery video platform, referral via webop.de plus hospital sales or introductions). Owner: Mahyar. Started 12 Nov 2026 from Wafa's request in the mail thread "UTM Parameters Eviplex 4 Medichub".

## Sources of truth

- **Concept:** Claude Doc "Eviplex Partnermodell – Eckpunkte für Partnerverträge" (https://claude.ai/artifact/E1wgJe6ZdsKanfKCWTBfoz), including the "Simulation" tab. If the doc and a local file disagree, the doc wins.
- **Frozen snapshot for drafting:** `konzept-stand-2026-11-12.md`. It separates decided terms from open points.
- **One-pager for Wafa:** `Eviplex Partnermodell - Kurzfassung.docx` (German, one page).

## Rules

- Audience is the Executive Board, partners and counsel, so documents are in German.
- Eviplex GmbH is always the contracting party. FOMF is not a party.
- Commission is always calculated on net revenue (without VAT).
- Prices, commission rates and B2B terms are confidential. Don't paste them into external tools.
- External counsel is Risch-Kerst. Every contract draft goes to them before it is used.
- Skills for the contract work: `contract-drafter` and `brief-to-counsel-drafter` in `.claude/skills/`. Both are adapted from rohasnagpal/legal-ai-skills (MIT license).

## Files

| File | What |
|---|---|
| `konzept-stand-2026-11-12.md` | Concept snapshot used as the term sheet input |
| `Eviplex Partnermodell - Kurzfassung.docx` | One-pager for Wafa |
| `handoff-vertragsentwurf.md` | Prompt for the agent that drafts the contract |
| `vertrag/` | Contract drafts and the memo to Risch-Kerst (created by the drafting agent) |
