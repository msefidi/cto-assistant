# Eviplex AVV and FOMF↔Eviplex secrecy agreement

Eviplex GmbH needs a data processing agreement (AVV) with the doctors who book Plus or Pro, because it processes what they type into the chat on their behalf. Felix Dümpert (DPO) drafts the AVV; Habib owns the documents. Mahyar checks Anlage 2.1 (TOMs) and Anlage 2.2 (subprocessors) and whether FOMF can keep the "Interne Verschwiegenheitsvereinbarung" (§ 203 StGB) between FOMF and Eviplex, which Habib needs before FOMF employees are pledged. The work started in July 2026; Mahyar wrote his review for Habib on 3 Nov 2026.

## Status

**As of 15 Nov 2026:** Mahyar sent the review and the wording changes to Habib on 3 and 4 Nov and confirmed that the documents describe the end state FOMF will build. The OpenAI EU pin and EU dictation are merged (meviq PR #1093, 10 Nov); TLS for Postgres and Redis (PR #1079) is still open. No reply from Habib, Felix or counsel on the AVV after 4 Nov was found.

- **Next step:** close the remaining technical items (PR #1079, the Vercel gateway location, the unverified TOMs), then tell Habib the documents can go out (proposed, not confirmed by Mahyar). Owner: Mahyar.
- **Next date:** none
- **Waiting on:** Habib for the certificate wording and § 9 liability (with Erfan and counsel); Felix for the Art. 26 question and the DPIA; FOMF on the Google Professional Secrecy Addendum (PSA): Google has the final version ready for DocuSign since 11 Nov and needs the signer's name; Risch-Kerst asked on 16 Nov whether to sign now, answer due 20 Nov.

## Goal

Habib can hand out the user AVV (V-05 or later) and sign the FOMF↔Eviplex secrecy agreement, and every TOM and subprocessor line in them is true in production. Then FOMF employees are pledged under § 203. No target date is recorded.

## People

| Who | Role here |
|---|---|
| Mahyar | Checks Anlagen 2.1 and 2.2 and the secrecy agreement against code and GCP; owns the technical fixes |
| Habib Modabber | CGO and Geschäftsführer. Owns the AVV, the terms of use and the secrecy agreement; hands them out once everything is live |
| Felix Dümpert | Data protection officer. Drafts the AVV (V-05 on 5 Oct); raised the Art. 26 vs. Art. 28 question about Braintrust |
| Erfan | CFO. Decides the § 9 liability question with Habib and counsel |
| Prof. Dr. Mandy Risch-Kerst (eventlawyers.de) | Counsel on § 203; wrote the Berufsgeheimnis documentation in Sep 2026. Whether she is "the Anwältin" for the AVV is not recorded |
| Parham | Eviplex engineer; named with Mahyar for the technical fixes |
| Shervin | Fixes some of the open points (Mahyar in Teams, 3 Nov); role not recorded |
| Josip | Changes the dictation system (Mahyar in Teams, 3 Nov). PR #1093 is by GitHub user jole141, probably Josip (not confirmed) |
| Max | Owns the "Professional secrecy (§203)" project in the Eviplex weekly memo |
| Stefanie Wonneberger and Laura (Google) | Took over the Google PSA/CMA case on 30 Oct |
| Wafa | Co-founder; commented on the AVV in July |

## Open points

- PR #1079 (TLS for Postgres and Redis) is open. (owner: Mahyar)
- Whether PR #1093 is deployed to prod is not verified. (owner: Mahyar)
- The Vercel AI Gateway location and OpenAI retention are not confirmed; Anlage 2.2 says "Ort wird noch bestätigt". (owner: Mahyar)
- TOMs not verified on 3 Nov: admin roles, least privilege, alerting, subprocessor certificates. Further technical gaps from the review are listed in the review page, not here. (owner: Mahyar)
- Certificates: Anlage 2 of the secrecy agreement names ISO 27001, BSI C5 and SOC 24/7, and Anlage 2.1 says "ausschließlich zertifizierte Unterauftragnehmer"; FOMF has none of these. Mahyar asked Habib on 4 Nov whether to strike them or set them as a dated goal. (owner: Habib)
- § 9 unlimited liability between the sister companies. (owner: Habib, with Erfan and counsel)
- Braintrust: Art. 26 (joint controllership) or quality checks on Eviplex's behalf under Art. 28. (owner: Felix, with counsel)
- DPIA status. (owner: Felix)
- Google PSA: the pay-as-you-go version is final and ready for DocuSign (11 Nov); Google needs the signer's name and any questions from counsel. It does not cover Switzerland. Until it is signed, Google is a gap in the § 203 chain. (owner: Mahyar and Habib)
- The review planned Anlagen 2.1 and 2.2 as tracked changes in a V-06 with legal entity names and a data-flow diagram. Whether V-06 exists is not recorded. (owner: Mahyar)
- Habib announced on 28 Oct a revised terms of use that separates Free and paid; not seen yet. (owner: Habib)
- The review page in this folder lists security gaps and is tracked in git. `cto-assistant/CLAUDE.md` puts security findings in `cybersecurity/reports/`, which git ignores. Whether to move it is for Mahyar to decide. (owner: Mahyar)

## Rules

- Write to Habib and Felix in German.
- The review page is local only; do not publish it. It contains security gaps (see "Data sensitivity" in `cto-assistant/CLAUDE.md`).
- The documents describe the end state. Habib hands them out only when everything in them is live, and Mahyar tells him when that is.
- Re-verify a TOM claim in code and GCP before reusing it. Fixes land in the meviq repo and `meviq-prod` and need Mahyar's approval.
- Anlage 2.2 lists only services that receive chat content that may hold personal (patient) data (Habib, 10 Oct).

## Source map

| Where | What to search or open |
|---|---|
| Outlook | Main thread "AVV und Datenschutzerklärung Eviplex" (Jul to Nov; Habib, Felix, Mahyar). Earlier: "Datenschutz / AVV Topics" (27–28 Jul), "Datenschutzerklärung und AVV für Ziliar/Eviplex" (20 Jul), "Impressum und Nutzungsbedingungen Eviplex", "Datenfluss mit OpenAI" (5 Oct). Counsel: "EVIPLEX / OpenAI – § 203 StGB in der LLM-Lieferkette unsere Fragen", "Berufsgeheimnis -Dokumentation 1. Entwurf und to does", "Empfehlung für Bewerbung und Finales Compliances-Gutachten als Dokumentation für Berufsgeheimnis" (risch@eventlawyers.de). Google PSA: "Urgent: Gemini API Usage / Privacy Agreement" and "DRAFT version - PSA" (wonneberger@google.com). Search `AVV`, `Verschwiegenheitsvereinbarung`, `Berufsgeheimnis`, `TOMs`. |
| Teams | Mahyar's 1:1 chat with Habib (2–4 Nov: reminder, "5 points open", end-state question). Eviplex weekly meeting chat (plan memo, project "Professional secrecy (§203)"). Search `AVV OR Verschwiegenheit OR TOMs OR Berufsgeheimnis`. |
| Slack | Not searched yet. |
| SharePoint | Not searched yet. The draft `Entwurf_AVV-Anlage-Nutzungsbedingungen-Eviplex_V-05.docx` came as a mail attachment (Felix, 5 Oct; Habib, 28 Oct). |
| Notion | "AVV-Anlage-Nutzungsbedingungen-Eviplex_V-03" (https://app.notion.com/p/fomf/AVV-Anlage-Nutzungsbedingungen-Eviplex_V-03-3ad7afedf3098046b105d08f53461eed), written by Mahyar on 30 Jul. |
| Linear | Project "Professional secrecy compliance (§203 StGB)" (P-EVP-242, lead Mahyar, In Development); issue EVP-1314 "Data processing agreement (AVV) and internal confidentiality obligations" (Todo). Checked 15 Nov 2026. |
| Other | GitHub `fomf-code/meviq` PRs #1079 (open) and #1093 (merged 10 Nov). GCP project `meviq-prod` (Cloud SQL, Redis, GKE, buckets). |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
| `../cybersecurity/reports/avv-pruefung-2026-11-03.html` | The review for Habib (German): Anlage 2.2 per service, which TOMs hold, what FOMF cannot promise in the secrecy agreement, next steps. Git-ignored because it lists security gaps |
