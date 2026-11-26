# Patient documents in Eviplex

How doctors could bring their own documents (hospital letters, specialist reports, lab results) into Eviplex, and on what product, legal and hosting terms. The trigger was Benignia, who said on 18 Nov 2026 that this is the core need of GP practices in Switzerland. She also named AlpineAI as the data-protection benchmark that Swiss practices and hospitals compare against. Owner: Mahyar, as Eviplex PM. Started 18 Nov 2026.

## Status

**As of 25 Nov 2026:** Not started. Nothing goes to the EVP team until Mahyar has thought through how documents fit into Eviplex. Benigna introduced Mahyar to Hansueli Jud by mail on 24 Nov; a date for the call is open (sub-issue CTO-29).

- **Next step:** send Hansueli one or two dates in the mail thread and meet him (Mahyar). Then write a first product framing that covers the open points below (Mahyar).
- **Next date:** 18 Mar 2027, the doctors' networking meeting in Basel where Eviplex is presented alongside AlpineAI (Max presents, Mahyar attends)
- **Waiting on:** nobody

## Goal

A product decision on documents in Eviplex: which use case, which tiers, where the MDR and § 203 lines sit, and what hosting it needs for Switzerland. Once it is decided, it goes to Linear as a project. No target date yet.

## People

| Who | Role here |
|---|---|
| Mahyar | Eviplex PM; owns the product framing |
| Benigna Hassler ("Benignia" in the Eviplex brief) | FOMF CH; brings the Swiss demand (practice group with 120+ doctors, Hirslanden) and the contact to AlpineAI |
| Hansueli Jud | AI engineer at AlpineAI; son of a friend of Benignia's. She offered to arrange a call, probably before Basel |
| Max | Medical lead; owns the § 203 project; presents Eviplex in Basel on 18 Mar 2027 |
| Wafa | Co-founder; Swiss hospital sales with Benignia (Hirslanden) |
| Habib, Felix Dümpert | Owner of the AVV and terms; data protection officer. Documents change what the AVV has to cover |

## Open points

- **Use case.** One option is the GP inbox (summarise and extract from incoming letters), which is AlpineAI's ground. The other is evidence for this patient (a guideline answer grounded in the patient's document), which is Eviplex's own. (owner: Mahyar)
- **MDR.** Reading patient context probably makes Eviplex a medical device, class IIa or IIb; see `../knowledge/positioning.md`, "The MDR line", and the Linear project "MDR assessment" (P-EVP-245). AlpineAI stays outside the MDR by limiting itself to administrative use. (owner: Mahyar)
- **§ 203 and Art. 321 StGB.** Documents are patient data in clear text. The Google PSA is not signed and does not cover Switzerland; see `../avv/`. (owner: Mahyar, Habib)
- **Swiss hosting.** The Swiss practice group would adopt Eviplex only with data protection "equivalent to AlpineAI": Swiss hosting, Swiss-run models, ISO 27001, HIN. Eviplex runs on EU servers with OpenAI. Matching that is a strategic choice, not a feature. (owner: Mahyar)
- **Storage.** Should documents be kept, or used once per question? This decides the AVV, retention and the size of a breach. (owner: Mahyar)
- **Fit with Patient Context.** How documents relate to the Plus/Pro Patient Context feature (Linear project "Patient context in chat", P-EVP-246). (owner: Mahyar)
- **Germany.** Once patient data is processed in the cloud, § 393 SGB V asks for C5. (owner: Mahyar)
- **Partnering.** Is a partnership with AlpineAI worth exploring (their Swiss hosting and HIN, our evidence base), or are they a competitor once we add documents? (owner: Mahyar)

## Rules

- Until a decision is made, answer customers with the agreed upload wording in `../knowledge/claims-and-legal.md`: no uploads today, on the roadmap, no date.
- In a call with AlpineAI, share no roadmap details.
- Benignia writes in English and German; Mahyar answers her in English in their chat.

## Source map

| Where | What to search or open |
|---|---|
| Outlook | "AW: Kontaktaufnahme via AlpineAI Desk" (24 Nov 2026: Benigna introduces Mahyar to Hansueli Jud). "Swiss HealthAssist" (HIN and AlpineAI webinar, Oct–Nov 2025: Angela Beutler, Habib). Search `AlpineAI`, `HIN` |
| Teams | 1:1 chat Mahyar ↔ Benigna Hassler (17–18 Nov 2026: AlpineAI, Hansueli, Basel, PDF upload; 6 Oct 2026: Hirslanden data protection) |
| Slack | none yet |
| SharePoint | CH pitch with tech fact sheet: eng › 09-Eviplex/Marketing Planung/03_Pitches/Eviplex final |
| Notion | Meviq › 01 - Product › "KIS and PVS integration – research" |
| Linear | Board issue CTO-22 (private team cto-assistant), sub-issue CTO-29 (call with Hansueli). EVP: project "Patient context in chat" (P-EVP-246), project "MDR assessment" (P-EVP-245), backlog issues EVP-935 "Upload lab results and patient documentation" and EVP-1289 "Structured patient content" |
| Other | https://alpineai.swiss (pages /gesundheitswesen/, /sicherheit/, /produkt/; read 18 Nov 2026) |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
