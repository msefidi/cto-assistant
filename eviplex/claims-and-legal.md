# Eviplex: claims and legal wording

What may and may not be said about Eviplex in anything that leaves FOMF: decks, fact sheets, partner material, answers to customers. Eviplex GmbH carries the liability, and hospital CTOs and DPOs test every claim.

**Start with meviq `brand/README.md`, section "Claims".** It holds the published claims and the fixed German sentences; use them as written, and leave out anything marked "Zu prüfen" until Shadi and Anika confirm it. This file adds the decisions behind them and what is not public.

## Before reusing any claim

Re-check it against the code and against the AVV brief (`../eviplex-avv/AGENTS.md`). The subprocessor facts in the CH fact sheet were true on 8 Oct 2026 only, and several TOMs in the AVV were untrue on 3 Nov 2026.

## Professional secrecy (§ 203)

- Plus and Pro are the § 203 tiers; Free is not (Mahyar, 26 Oct 2026).
- On 8 Oct 2026 only OpenAI had signed a § 203 confidentiality agreement. Data sent to OpenAI is **not** anonymised; it is covered by zero data retention and the secrecy terms. Website text that says otherwise is wrong (Linear EVP-1349).
- **Google Cloud is a gap** until Google's Professional Secrecy Addendum (PSA) is signed: it stores conversations with Google-managed keys. Encryption at rest does not take Google out of scope. PSA status and history: `../eviplex-avv/`.
- Therefore never write „lückenlose Verschwiegenheitskette".
- **Switzerland:** the CH deck writes „§ 203 dStGB". Counsel's wording (Risch-Kerst): OpenAI's § 203 obligation „wirkt analog" for Art. 321 StGB. Plus and Pro do not yet fully cover Art. 321 StGB: the pay-as-you-go PSA covers DE and AT only; CH needs an Enterprise Agreement PSA.

## Hosting and countries

- Write „Datenspeicherung und -verarbeitung ausschließlich auf ISO 27.001 zertifizierten EU-Servern." "EU servers" and "Frankfurt" are the same; don't name a city (Mahyar, 12 Nov 2026).
- CH: EU hosting only, no Swiss-hosting offer. BigQuery is not mentioned; OpenAI is named (Mahyar, Oct 2026).
- Non-EU markets (UAE deck, Oct 2026): no compliance claims for the target country; German § 203 and GDPR are presented as the standard the product is built to; other data-residency rules are "assessed per project". Regional and in-country hosting may be offered. UAE law (Federal Law No. 2/2019, Art. 13) by default bars storing or processing UAE health data abroad; Ministerial Resolution 51/2021 adds exceptions. Do not reuse § 203 framing for a non-EU market without legal input.

## Third parties: open conflict

- The UAE deck (27 Oct 2026) replaced "no data storage with third-party services" with "zero data retention at the AI model provider", because Google Cloud stores conversations.
- The brand book lists „Keine Datenspeicherung bei Dienstleistungen und Produkten von Dritten" as a published claim confirmed on 12 Nov 2026.
- **Not resolved:** ask Mahyar which holds before using either sentence in new material.

## Patient documents and uploads

The agreed answer (Mahyar, 11 Nov 2026), for sales, events and CS:

- Today Eviplex is for evidence research in guidelines and studies. You cannot upload PDFs, reports or lab results. The Plus/Pro Patient Context feature holds no documents either.
- Bringing patient documents into a question is on the roadmap, with no date. It is being built, like Plus and Pro, for professionals bound by § 203.
- Plus and Pro do not yet fully cover Art. 321 StGB (CH).
- Images are not mentioned; don't promise them.

## Medical device

Eviplex is not a medical device under the MDR (EU 2017/745). Never use clinical verbs for Eviplex (entscheiden, empfehlen, bewerten, diagnostizieren, therapieren); the full list is in the brand book under "Voice". Where patient data starts to make it a device: `positioning.md`, "The MDR line".

## Where the decks are

- CH pitch with tech fact sheet (Oct 2026): SharePoint eng › 09-Eviplex/Marketing Planung/03_Pitches/Eviplex final/"Eviplex V 1_1 (final) - CH - mit Tech-Factsheet.pptx", slides 9–11.
- UAE deck (EN, Oct 2026): `../archive/eviplex-uae-pitch/`.
