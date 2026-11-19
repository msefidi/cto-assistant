# Eviplex Partnermodell

The commission model and the partner contract for Eviplex sales partners. The first partners are Medichub (Romania, referral of doctors) and Webop (surgery video platform: referral via webop.de, plus hospital sales or introductions). Wafa asked for a real partner contract on 5 Nov 2026 and later for a general model for all partners. Mahyar owns it; work started on 12 Nov 2026.

## Status

**As of 19 Nov 2026:** Concept settled. Contract draft v0.1, drafting notes and the cover letter to counsel Risch-Kerst are ready since 12 Nov, not yet sent to counsel. Medichub knows a written agreement comes before go-live and expects it by Wed 25 Nov, together with answers to their launch questions.

- **Next step:** agree with Wafa (call asked for on 12 Nov), fill the four placeholders in the cover letter and send the draft to Risch-Kerst (see Anhang C of `vertrag/Entwurfsnotizen v0.1.md`). Prepare the reply to Medichub for 25 Nov. Medichub expects the agreement itself by then; if counsel has not reviewed it, the reply must say what they get instead (e.g. the terms sheet, or a date for the reviewed contract).
- **Next date:** 25 Nov 2026, promised reply to Medichub.
- **Waiting on:** Mahyar (sending to counsel, reply to Medichub).

## Goal

A partner contract reviewed by counsel that Eviplex GmbH can sign with Medichub and Webop, and later with any partner, using one master contract and a terms sheet per partner. Partner attribution must be stored on the account before the first commission statement. No target date is recorded.

## People

| Who | Role here |
|---|---|
| Mahyar | Owner. Wrote the concept and the draft; decides the open points; sends the draft to counsel himself |
| Wafa (Wafa Enayati) | Co-founder. Asked for the contract (5 Nov) and for a general model for all partners (Teams, 6 Nov). Got the one-pager on 12 Nov. Settles the Romania price and quota with Mahyar |
| Habib (Habib Modabber) | CGO. Ran the Medichub mail thread until 12 Nov, then said he has no capacity for the Romanian requests |
| Sina (in Outlook and Teams: Martin S. Taheri) | Co-founder. In copy on the Medichub and Webop mails |
| Erfan (Erfan Abedian) | CFO. In copy on the Webop Stripe Connect thread |
| Viktor | Builds the Mixpanel attribution funnel for partner activities in Romania (EVP-1312) |
| Parham | Wrote the Medichub UTM link scheme that Habib sent on 30 Oct |
| Ionut Stroea, Cristina Marin, Simona Melnic (Medichub) | Medichub, Bucharest. Ionut and Cristina are business development managers and run the campaign; Simona was at the August meeting |
| Ileana (Mediamed) | Second Romanian partner at the 21 Aug meeting. No exclusivity promised |
| Guido Gruhn (Webop) | CEO of Webop GmbH, Köln. Proposed the webop.de embedding with Stripe Connect; introduces Eviplex to Swiss hospitals. Co-managing director: Simone Heiss |
| Prof. Dr. Mandy Risch-Kerst | External counsel (risch@eventlawyers.de). Reviews every contract draft. The contact person in the cover letter is still a placeholder |

## Open points

- Send draft v0.1 and the cover letter to Risch-Kerst. Before that: fill the placeholders (contact person, date, client, deadline), decide whether Eviplex GmbH or FOMF is the client and pays, ask for conflicts (Webop, Medichub), decide whether the concept and the FOMF–Webop contract go along. (owner: Mahyar)
- Drafting choices not yet confirmed by Mahyar, starred in the notes: E1 only the terms sheet is signed; E2 rates only in the terms sheet; E3 no duty to act for the partner; E6 hospital registrations; E18 trademark; E20 liability cap for Eviplex only; E21 only Eviplex may terminate for convenience; E22 commission after termination. The posture "moderately Eviplex-favourable" was the drafting agent's default, not explicitly confirmed. (owner: Mahyar)
- Three options from the simulation are undecided: O1 Romania price only with a Romanian billing address; O2 commission clock follows the person when an individual moves to a hospital seat; O3 Stripe Connect splits on the net amount. (owner: Mahyar)
- Who owns the trademark "Eviplex" (Eviplex GmbH or FOMF) and whether Eviplex may license it to partners (K12). Depends on the FOMF↔Eviplex cooperation contract. (owner: Mahyar)
- Webop: are hospitals that are already FOMF customers commissionable when they buy Eviplex (K36)? To agree with Webop. Related: individual FOMF members who register via a partner link are commissionable under the current rule unless they buy a FOMF bundle (E12). (owner: Mahyar)
- Attribution is not built. UTM values reach Segment only with analytics consent and are not stored on the account. EVP-1348 "Store partner attribution on the account for commission payouts" is in Backlog with no assignee. (owner: Mahyar, Eviplex team)
- Romania price and quota: €14.90 a month with 75 questions is a working assumption, to settle with Wafa and Medichub. Mahyar recalls a lower price with a lower quota agreed with the partners in August; no written record found. (owner: Mahyar with Wafa)
- B2B prices: the Executive Board has not decided them yet. (owner: Executive Board)
- Medichub's launch questions are unanswered (reply promised for 25 Nov): review of the campaign material, vector "Powered by FOMF" logo, use of the Eviplex symbol alone, who validates the Romanian disclaimer, written confirmation of the zero-data-retention wording, utm_content for print, Meta Ads budget (decided: Eviplex does not contribute, not yet told to Medichub as far as recorded), webinar date and demo. Who answers them is not recorded. (owner: Mahyar with Wafa)
- Wafa's one-pager of 12 Nov 15:01 still says 5–10 % for introductions; the rate changed to 7.5 % that evening. Whether she has the updated file is not recorded. (owner: Mahyar)
- 44 business placeholders (K01–K44) and 16 counsel questions (P01–P16) are listed in `vertrag/Entwurfsnotizen v0.1.md`. (owner: Mahyar; P-points: Risch-Kerst)

## Rules

- Documents for the Executive Board, partners and counsel are in German. This brief and the log are in English.
- Eviplex GmbH is always the contracting party, for partners and customers. FOMF is not a party. The reason: Eviplex GmbH holds liability and is GDPR controller, so the partner must not sell in its own name, set prices or hold customer data.
- Commission is always calculated on net revenue (without VAT).
- Prices, commission rates and B2B terms are confidential. Do not paste them into external tools or web searches.
- External counsel is Risch-Kerst. Every contract draft goes to them before it is used. Mahyar sends it himself; agents do not send, upload or edit anything outside this folder.
- The Claude Doc "Eviplex Partnermodell – Eckpunkte für Partnerverträge" is the concept. If it and a local file disagree, the doc wins. `konzept-stand-2026-11-12.md` is the frozen snapshot the draft was built from; it separates decided terms from open points.
- Check `docs/decisions.md` before reusing any term; the rates changed several times on 12 Nov.
- Marketing claims by partners need the approved wording, e.g. "zero data retention beim KI-Modellanbieter" (see `../knowledge/claims-and-legal.md`).
- Skills for the contract work: `contract-drafter` and `brief-to-counsel-drafter` in `.claude/skills/`, adapted from rohasnagpal/legal-ai-skills (MIT license).

## Source map

Where this topic lives outside this folder. A catch-up searches every row.

| Where | What to search or open |
|---|---|
| Outlook | Search `Medichub`, `Webop`, `Guido Gruhn`, `Partnervertrag`, `Partnermodell`, `Risch-Kerst`, `Stripe Connect`. Threads: "UTM Parameters Eviplex 4 Medichub" (also "Eviplex 4 Medichub", Wafa's "Fw:" of 5 Nov, Mahyar's reply of 12 Nov with the one-pager), "Habib Modabber hat den Ordner "Eviplex" mit Ihnen geteilt" (Medichub asks for UTM links), "Stripe Connect Infos für Einbindung Eviplex auf webop.de", "Vorstellung Eviplex (klinische Wissensrecherche) der FOMF" (Guido to Solothurner Spitäler). Senders: Ionut Stroea, Cristina Marin (medichub.ro), Guido Gruhn (webop.de), Habib Modabber, Wafa Enayati, Prof. Dr. Mandy Risch-Kerst (eventlawyers.de; earlier threads with her are on § 203, not this contract). |
| Teams | Search `Medichub OR Webop OR Partnervertrag OR Partnermodell OR Rumänien`. Wafa's message of 6 Nov in the group chat with Habib ("allgemeine Vertragskonstellation mit Partnern"). The Eviplex weekly meeting chat (plan memo of 6 Nov gives Viktor the attribution funnel). Mahyar's 1:1 chat with Habib, 13 Oct, on sharing data with Webop via Metabase (may concern the existing video contract). |
| Slack | Not searched yet. |
| SharePoint | Sales Membership › Preislisten GMS › "2025_08_Staffelpreise GMS DE-AT-CH inkl. Klinik-Modell.xlsx" (Eviplex block, hospital prices). Executive Board site › Freigegebene Dokumente › Public › Eviplex (marketing assets Habib shared with Medichub on 26 Oct). Where the sent contract will be filed: not recorded. |
| Notion | Executive Board › Documents › Eviplex › "Eviplex Romenia" (21 Aug 2026 meeting with Medichub and Mediamed; the 25 Sep follow-up has no notes). |
| Linear | Board issue CTO-3 (private team cto-assistant). No project (checked 15 Nov 2026). Issues in Eviplex Product: EVP-1348 "Store partner attribution on the account for commission payouts" (Backlog), EVP-1312 "Mixpanel: Build attribution funnel and test end to end" (Viktor, Todo), EVP-1310 "Save UTM values on the user profile at sign-up" (canceled 12 Nov). |
| Other | Claude Doc "Eviplex Partnermodell – Eckpunkte für Partnerverträge" with tab "Simulation" (https://claude.ai/artifact/E1wgJe6ZdsKanfKCWTBfoz). Codex thread "Review Medichub Partnership Contract" (12 Nov). |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
| `konzept-stand-2026-11-12.md` | Frozen concept snapshot (German), the term sheet for the draft |
| `Eviplex Partnermodell - Kurzfassung.docx` | One-page German summary for Wafa |
| `handoff-vertragsentwurf.md` | Prompt for the agent that drafted the contract |
| `vertrag/Partnervertrag Eviplex – Entwurf v0.1.docx` | Draft master contract, 29 pages: §§ 1–18, Anlage 1 terms sheet template, 1a Medichub, 1b Webop, Anlage 2 advertising and approvals, Anlage 3 attribution and statements |
| `vertrag/Entwurfsnotizen v0.1.md` | Drafting choices E1–E31, placeholders K01–K44, options O1–O3, counsel points P01–P16, doc-vs-snapshot diff, checklist before sending |
| `vertrag/Anschreiben Risch-Kerst v0.1.docx` | Two-page cover letter to counsel with eight questions |

## Working notes

- The Word files were built with python-docx in a scratch venv; the scripts were not kept.
- Layout check that works: copy the .docx into `~/Library/Containers/com.microsoft.Word/Data/Documents/`, export to PDF through Word via AppleScript, rasterise with PyMuPDF, then delete the copies. `qlmanage -t` shows only page 1 and falls back to Times, because Aptos lives inside the Word bundle.
