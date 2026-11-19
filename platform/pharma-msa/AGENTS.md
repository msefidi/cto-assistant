# Pharma MSAs: Moderna and Madrigal

Habib (CGO) is negotiating master service agreements (MSAs) with two pharma sponsoring clients, Moderna and Madrigal, and needs Mahyar's input on the IT security and data protection parts. The answers should be reusable for later pharma contracts. Topic opened 19 Nov 2026.

## Status

**As of 19 Nov 2026:** Two requests from Habib are open, and Outlook shows no reply from Mahyar to either.

1. **Moderna** (MSA contract ID 102611, Moderna Switzerland GmbH): Moderna's security requirements (referenced in MSA Section 3.9) arrived on 22 Sep 2026 and need FOMF's acknowledgement or feedback. Habib wants the MSA final for 2027 before the end of the year.
2. **Madrigal**: the MSA is negotiated apart from details and includes a Data Privacy Addendum. Habib needs the list of sub-processors: every system that processes data about the pharma company's employees (he assumes Microsoft and HubSpot), plus the platform's services that process user data, because the client gets access to the platform. Felix has no overview because the platform's processing register (Verarbeitungsverzeichnis) is not final.

- **Next step:** Mahyar reads Moderna's security requirements and the Madrigal MSA/DPA and replies to Habib on both (week of 23 Nov).
- **Next date:** 27 Nov 2026 (target for the reply); year end (Moderna MSA final)
- **Waiting on:** Mahyar

## Goal

Habib has (a) FOMF's feedback on Moderna's security requirements and (b) a sub-processor list for Madrigal, both in time to sign before the end of 2026. The sub-processor list is kept as a reference for future pharma contracts.

## People

| Who | Role here |
|---|---|
| Habib Modabber | CGO; negotiates both MSAs and asked for the input |
| Alexander Bielau | FOMF sales, on the Moderna thread |
| Jennifer An | FOMF Key Account Administration (CH), handled the Moderna MSA review earlier |
| Felix Dümpert | Data protection officer; owns the processing register |
| Susanna Ott | External legal counsel (eventlawyers.de) on the Moderna MSA |
| Maciej Popis | Moderna, Global Contracting; sent the security requirements |

## Open points

- Moderna's security requirements: which FOMF can meet as written, which need changes. (owner: Mahyar)
- Sub-processor list: which systems process pharma-employee data (Microsoft 365, HubSpot, others?) and which platform services process user data (GCP and the platform's third-party services). Check against the platform stack in `../knowledge/tech-and-security.md` and the Eviplex subprocessor work in `../../eviplex/avv/`. (owner: Mahyar, with Felix)
- Whether the list should become part of the platform's processing register, so Felix keeps it current. (owner: Mahyar with Felix)

## Rules

- Contract terms (liability caps, cancellation fees, prices) stay in this folder, never on the board issue. Client names stay off the board issue too.
- Moderna's documents are confidential; do not paste them into external tools.
- Replies to Habib in German or English as the thread runs (the threads are in English).

## Source map

| Where | What to search or open |
|---|---|
| Outlook | Moderna: subject "MSA Contract ID 102611", search `102611`; Habib's forward of 22 Sep 2026 carries the security requirements attachment; nudge of 19 Nov 2026. Madrigal: subject "Madrigal Master Service Agreement" (Habib, 16 Nov 2026), attachment "FomF GmbH MSA_FomF GmbH MSA_clean.docx" |
| Teams | Chats with Habib Modabber or Felix Dümpert; search `MSA`, `Moderna`, `Madrigal`, `Sub-Processor` |
| Slack | none |
| SharePoint | none yet |
| Notion | none |
| Linear | Board issue CTO-27 (private team cto-assistant); no product project |
| Other | none |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
