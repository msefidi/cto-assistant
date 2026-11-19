# ÄKW: Ärztekammer Wien streaming cooperation

FOMF bid in the public tender of the Ärztekammer Wien (ÄKW) for a streaming platform with medical education content: group access for about 15,300 ÄKW members and about 1,000 KPJ students, starting 01.02.2027. The deal is strategic: FOMF cut the price from about €1M to about €300k a year to bring ÄKW's doctors onto fomf.at. Sales ran the tender; Mahyar owns the technical concept and its delivery. Started 5 Oct 2026, when the tender was published.

## Status

**As of 13 Nov 2026:** Won unofficially (by phone, 11 Nov); the official award is pending. Delivery is not planned: no owner per build item, no Linear project.

- **Next step:** plan the delivery for 01.02.2027 (proposed, not yet confirmed by Mahyar). The first item would be the silent-SSO prototype.
- **Next date:** official award, which the tender schedules for KW 49 (30 Nov to 6 Dec 2026). Service start 01.02.2027.
- **Waiting on:** ÄKW and Breitenfeld for the official award.

## Goal

On 01.02.2027 ÄKW doctors reach FOMF content from ÄKW's Ärzte Service Portal (ÄSP) without a second login, as promised in the concept v2 and the clarification answers of 11 Nov. The ÄSP is a new app ÄKW is building for Vienna's doctors; our content stays on fomf.at and the ÄSP embeds and links to it. ÄKW said verbally that a smooth login matters most to them (not binding, tender 1.15).

## People

| Who | Role here |
|---|---|
| Mahyar | Technical concept, SSO and data-model decisions, delivery |
| Sina (in Outlook and Teams: Martin S. Taheri) | Co-founder. Signs the tender documents; was at the ÄKW meeting on 27 Oct |
| Wafa | Co-founder. Reviews the tender documents with Sina |
| Ute Schellerer | Prepared the tender documents and the submission |
| Andreas Eberl | Holds the relationship with Dr. Glaser; arranges contact with ÄKW's IT |
| Felix Dümpert | Data protection officer; in copy on the tender thread |
| Dr. Glaser (ÄKW) | Our contact at ÄKW; argued for FOMF in ÄKW's Präsidialsitzung |
| ÄKW's head of IT (name not recorded) | Mahyar's counterpart for the ÄSP interface |
| RA Kröswang, Breitenfeld Rechtsanwälte | Runs the tender for ÄKW; formal communication goes through their portal |

## Open points

- Silent SSO inside an iFrame is unproven. Prototype `prompt=none` in Safari, Firefox and Chrome before building on it. (owner: Mahyar)
- It is not confirmed that the ÄSP supports OIDC. ÄKW's effort depends on it. (owner: Mahyar, with ÄKW's head of IT)
- The full-account data model contradicts ÄKW's demand that FOMF neither uses nor stores member data: contract clause 15.3, and Beilage 2 takes precedence over our concept (contract 2.2). (owner: Mahyar)
- The concept made the 01.02.2027 start conditional on an award by 15 Nov. The tender awards in KW 49. Whether the date still holds is not settled. (owner: Mahyar and Sina)
- Back-channel logout, the consent dialog, the leaver signal, per-specialty video selection, KPJ registration and the 20 % discount are new work with no owner yet. The SSO would run through Hydra/Keycloak in the user-service, like DocCheck. (owner: Mahyar)
- The bid price and the final contract are not recorded in this folder. The April 2026 offer in SharePoint names €280k net a year.

## Rules

- **The win is unofficial.** Share it with nobody beyond the people above until ÄKW releases it (Dr. Glaser's request, passed on by Andreas Eberl on 12 Nov).
- During the tender FOMF may formally not contact ÄKW directly; formal communication goes through Breitenfeld's portal. Andreas Eberl arranged a direct line between Mahyar and ÄKW's head of IT on the condition that it stays confidential (mail thread "Ausschreibung ÄK Wien!", 7 and 8 Oct).
- Everything written for ÄKW is German. Prices and contract terms are confidential.
- Texts for ÄKW leave out FOMF's partner pages and SGMO.
- All FOMF promotion to ÄKW members needs ÄKW's approval (binding Q&A).

## Source map

| Where | What to search or open |
|---|---|
| Outlook | Search `ÄKW`, `ÄK Wien`, `Ärztekammer Wien`, `256139-00`. Threads so far: "Start Ausschreibung Ärztekammer Wien", "Ausschreibung ÄK Wien!", "Kooperation Ärztekammer Wien/Schnittstelle IT", "Claude soll das Konzept", "Abgabeprotokoll ÄK Wien", "eAbgabe: Abgabeinformation zu dem Verfahren 256139-00", "ÄKW antworten". Senders: Ute Schellerer, Andreas Eberl, Martin S. Taheri (Sina, who also writes from a private address as "S. M. Taheri"), Wafa Enayati. |
| Teams | Search `ÄKW OR Ärztekammer OR "ÄK Wien" OR "ÄK-Wien" OR Zuschlag`. Mahyar's 1:1 chat with Sina; the meeting chat where Andreas Eberl posted the win on 12 Nov; the group chat that arranged the 27 Oct presentation. |
| Slack | Not searched yet. |
| SharePoint | `Sales Membership/Ausschreibung Ärztekammer Wien`. Our drafts are the `_US` files. `original/` holds the tender documents, `Aktualisierung 16.10.2026/` the binding Q&A (`Bieteranfragen-161026.pdf`), `Unsere Angebote an Ärztekammer Wien/` the April 2026 offer. Concept as submitted: `ÄKW (Stream)-Konzept_Entwurf_MS_US_ST_v2.docx`. The letter of 4 Nov: `ÄKW _Stream_-Aufforderungsschreiben-041126.pdf`, shared in the Teams chat with Sina. |
| Notion | none |
| Linear | Board issue CTO-6 (private team cto-assistant, neutral title). No project yet (checked 13 Nov 2026). |
| Other | Tender portal breitenfeld.vergabeportal.at, Verfahren 256139-00, Aktenzahl 30/22-8. Claude Doc "ÄKW Konzept – Kapitel 4 & 5" (https://claude.ai/artifact/Lajot7bsky1A4DyCxhHy3U), an early draft that the Word v2 replaced. |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
