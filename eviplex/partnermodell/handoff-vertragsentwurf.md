# Handoff: first draft of the Eviplex partner contract

Paste everything below the line into a new Claude Code session started in `cto-assistant/`.

---

You are drafting the first version of the **Eviplex partner contract**, plus a cover memo to our external counsel **Risch-Kerst**, who will review it. You work for Mahyar Sefidi (CTO of FOMF, owner of this topic). The output is a draft for counsel. It is not a contract ready to sign.

## Read first

1. `eviplex-partnermodell/AGENTS.md`: the project brief and its rules.
2. `eviplex-partnermodell/konzept-stand-2026-11-12.md`: the commercial terms. This is your term sheet. Sections 3 and 4 are **decided**. Section 5 is **open**: never draft an open point as if it were settled.
3. The Claude Doc linked in AGENTS.md, if the Claude Docs connector is available. If it differs from the snapshot, the doc wins. Note any difference in your report.
4. Skills to use: `contract-drafter` for the contract and `brief-to-counsel-drafter` for the memo. Both are in `.claude/skills/`. Follow their method and output sections, and apply their "FOMF / Eviplex defaults".

## Decided parameters (don't ask about these again)

- **Contracting party:** Eviplex GmbH. FOMF is not a party. Exact company name, address and register number: placeholder.
- **Governing law and language:** German law, German contract text. Medichub is in Romania: draft in German and flag governing law, place of jurisdiction, mandatory Romanian commercial-agent protection and a possible bilingual version as points for counsel.
- **Posture:** a normal first draft that leans moderately in Eviplex's favour. Specifically:
  - Eviplex alone decides prices and how customers are credited to partners.
  - Eviplex may terminate for convenience with notice.
  - Partner liability for its marketing claims, with an indemnity.
  - Eviplex's own liability limited, to the extent the law allows.
  Don't lean on the commercial terms themselves (rates, periods, payout); take them exactly from the snapshot.
- **Structure:** one master contract for all partners plus annexes. A partner's specifics live only in its terms sheet.
  - **Main contract "Partnervertrag Eviplex":** at minimum these clauses:
    - definitions
    - subject and roles (referral to doctors, sales to hospitals/practices, introduction)
    - partner status (independent, no authority to sign for Eviplex, no sale in its own name)
    - crediting customers to partners
    - commission (basis, rates per terms sheet, period, years 3+, refunds and chargebacks, bundles, free users)
    - statements and payout (quarterly or Stripe Connect on the net amount, invoice or self-billing credit note, VAT)
    - partner's duties and costs
    - Eviplex's support
    - approval of advertising and claims
    - brand use
    - data protection (partner gets only aggregate reports)
    - confidentiality
    - no exclusivity
    - liability
    - term and termination, including commission running on after the contract ends
    - final provisions
  - **Annex 1, terms sheet (template)**, plus two filled versions:
    - **1a Medichub:** referral role, rate within 15–20 % as a placeholder, year 3 possibly 5 %.
    - **1b Webop:** referral via webop.de with payout through Stripe Connect, plus hospital sales and introduction. The question of hospitals that are already FOMF customers is a placeholder.
  - **Annex 2, rules for advertising and approvals:** approval process, claims that need approval (medicine, data protection, certificates), approved wording.
  - **Annex 3, crediting and statements:** partner link and partner code, 12-month window from registration to first paid subscription, registering hospital contacts in advance with exclusions, statement period, reporting.
- **Open simulation proposals (section 5):** draft them as bracketed options with a short note, e.g. `[Option: Rumänien-Tarif nur mit rumänischer Rechnungsadresse – Entscheidung Mahyar]`. Do not leave them out silently.
- **Questions for counsel (at least):**
  - Commercial agent or simple referral source, and how to avoid or price in a compensation claim under § 89b HGB.
  - Whether the standard-terms rules (AGB, §§ 305 ff. BGB) apply to this master contract used for many partners.
  - Governing law and jurisdiction for Romania, and mandatory local law that applies anyway.
  - Rules on advertising medical products (HWG) and the possible MDR status of Eviplex: what partners may say, and liability for their claims.
  - Consent needed to store the partner link on the account (TDDDG/GDPR).
  - Self-billing credit notes, reverse charge for a Romanian partner, and whether paying out through Stripe Connect is regulated.
  - Whether running commission after the contract ends and the year-3 clause hold up.
  - How this contract relates to the existing FOMF–Webop video contract.
  Frame each one as a question and say which decision depends on the answer. Do not answer them from memory.

## Deliverables (in `eviplex-partnermodell/vertrag/`)

1. `Partnervertrag Eviplex – Entwurf v0.1.docx`: main contract with annexes 1, 1a, 1b, 2 and 3, clause numbering, a header line "Entwurf v0.1 – vertraulich – zur anwaltlichen Prüfung".
2. `Entwurfsnotizen v0.1.md`, three parts: drafting notes (judgement calls and alternatives), open points and placeholders, and points for counsel to verify. This is the "Output" of `contract-drafter` minus the contract text.
3. `Anschreiben Risch-Kerst v0.1.docx`: memo following `brief-to-counsel-drafter`, in German, using the formal "Sie".
   - Mandate: review of the draft, with tracked changes or a redraft at their choice.
   - Short background on Eviplex GmbH and FOMF.
   - Decided business terms, with the note that they are not up for renegotiation.
   - Questions for counsel.
   - Enclosures.
   - Desired deadline as a placeholder.
   - At most two pages.

Build the Word files with python-docx in a venv in your scratchpad. Use Aptos 10.5 pt, headings in dark blue #1F2A44, and A4 page size. Render a preview with `qlmanage -t -s 1400 -o <dir> <file>` and look at it.

## Constraints

- Never invent: company names, addresses, register numbers, deadlines or amounts the snapshot doesn't give. Use a placeholder (`[● zu klären: …]`) or a counsel point (`[● Prüfpunkt Anwalt: …]`).
- Prices, rates and B2B terms are confidential. No web searches that contain them, and nothing sent to external tools.
- Do not send or upload anything: no email, no SharePoint, no Claude Docs edits. Mahyar sends it himself.
- Before finishing, check the draft as `contract-drafter` step 9 describes:
  - Definitions are used consistently.
  - Cross-references between clauses and annexes are correct.
  - The liability cap fits the indemnity.
  - Commission rules match the snapshot exactly: 15–20 % / 10 % / years 3+ negotiable; introduction 7.5 % in months 1–12, hospitals and practices only; net basis; 24 calendar months from first payment.

## Final report (in chat, English, short)

- Paths of the three files.
- Number of placeholders and counsel points.
- The 3–5 judgement calls Mahyar should look at first.
- Anything in the Claude Doc that differed from the snapshot.
