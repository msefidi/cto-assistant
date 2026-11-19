# Eviplex AVV and FOMF↔Eviplex secrecy agreement

Eviplex GmbH needs a data processing agreement (AVV) with the doctors who book Plus or Pro, because it processes what they type into the chat on their behalf. Felix Dümpert (DPO) drafts the AVV; Habib owns the documents. Mahyar checks Anlage 2.1 (TOMs) and Anlage 2.2 (subprocessors) and whether FOMF can keep the "Interne Verschwiegenheitsvereinbarung" (§ 203 StGB) between FOMF and Eviplex, which Habib needs before FOMF employees are pledged. The work started in July 2026; Mahyar wrote his review for Habib on 3 Nov 2026.

## Status

**As of 18 Nov 2026:** Prof. Risch-Kerst answered on the Google PSA on 18 Nov: sign it for DE and AT, but it lacks technical and organisational assurances, which should become contract terms in the Enterprise Agreement at the latest (details in the log). Mahyar sent the reply to Google (Stefanie Wonneberger) on 18 Nov, 16:38 CET: sign for DE and AT, DocuSign to Habib, questions on counsel's missing assurances, EA call offered; he also thanked counsel. No DocuSign or answer from Google yet. For the Enterprise Agreement Stefanie waits for Alex Vassileva's commit proposal of Dec 2025, which Mahyar promised "tonight or tomorrow". PR #1079 (Vercel AI Gateway EU endpoint, TLS for Postgres and Redis) was merged on 17 Nov and PR #1093 (EU model pin) on 10 Nov; that both are live in production is not verified. Mahyar sent the review and the wording changes to Habib on 3 and 4 Nov; no reply from Habib, Felix or counsel on the AVV after 4 Nov was found.

- **Next step:** Mahyar forwards Alex's commit proposal ("Proposal Commit _ FomF", 4 Dec 2025) to Stefanie; Google sends the PSA to Habib by DocuSign and answers the assurance questions. The missing assurances go into the Enterprise Agreement talks. The topic stays open until the PSA is signed (Mahyar, 18 Nov). In parallel, Mahyar confirms #1079 and #1093 are live in production and checks the unverified TOMs; then he tells Habib the documents can go out. Owner: Mahyar.
- **Next date:** 19 Nov 2026, commit proposal forwarded to Google
- **Waiting on:** Habib for the certificate wording and § 9 liability (with Erfan and counsel); Felix for the Art. 26 question and the DPIA.

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
| Parham | Eviplex engineer; named with Mahyar for the technical fixes; cc on the PR #1079 handover |
| Shervin | Eviplex engineer. Owns PR #1079 since 17 Nov: Vercel AI Gateway EU endpoint and TLS for Postgres and Redis (Mahyar in Slack) |
| Josip | Changes the dictation system (Mahyar in Teams, 3 Nov). PR #1093 is by GitHub user jole141, probably Josip (not confirmed) |
| Max | Owns the "Professional secrecy (§203)" project in the Eviplex weekly memo |
| Stefanie Wonneberger and Laura (Google) | Took over the Google PSA/CMA case on 30 Oct |
| Wafa | Co-founder; commented on the AVV in July |

## Open points

- PRs #1079 (merged 17 Nov) and #1093 (merged 10 Nov): live in production not verified. (owner: Mahyar)
- The Vercel AI Gateway location and OpenAI retention are not confirmed; Anlage 2.2 says "Ort wird noch bestätigt". The EU endpoint came with PR #1079 (merged 17 Nov); Anlage 2.2 can name it once it is confirmed live. (owner: Mahyar)
- TOMs not verified on 3 Nov: admin roles, least privilege, alerting, subprocessor certificates. Further technical gaps from the review are listed in the review page, not here. (owner: Mahyar)
- Certificates: Anlage 2 of the secrecy agreement names ISO 27001, BSI C5 and SOC 24/7, and Anlage 2.1 says "ausschließlich zertifizierte Unterauftragnehmer"; FOMF has none of these. Mahyar asked Habib on 4 Nov whether to strike them or set them as a dated goal. (owner: Habib)
- § 9 unlimited liability between the sister companies. (owner: Habib, with Erfan and counsel)
- Braintrust: Art. 26 (joint controllership) or quality checks on Eviplex's behalf under Art. 28. (owner: Felix, with counsel)
- DPIA status. (owner: Felix)
- Google PSA: the pay-as-you-go version is final and ready for DocuSign (11 Nov). Counsel says sign it for DE and AT (18 Nov); Habib signs (Mahyar's mail to Google, 18 Nov). Which FOMF entity signs is not recorded (it must match the Google Cloud account holder). It does not cover Switzerland. Until it is signed, Google is a gap in the § 203 chain. (owner: Mahyar and Habib)
- Counsel's missing assurances (human and automated access, training use, retention and deletion, third-country access and government requests, audit rights): ask Google where its Cloud terms cover them; the rest becomes terms of the Enterprise Agreement. (owner: Mahyar)
- The review planned Anlagen 2.1 and 2.2 as tracked changes in a V-06 with legal entity names and a data-flow diagram. Whether V-06 exists is not recorded. (owner: Mahyar)
- Habib announced on 28 Oct a revised terms of use that separates Free and paid; not seen yet. (owner: Habib)
- The review page in this folder lists security gaps and is tracked in git. the root `AGENTS.md` puts security findings in `cybersecurity/reports/`, which git ignores. Whether to move it is for Mahyar to decide. (owner: Mahyar)

## Rules

- Write to Habib and Felix in German.
- The review page is local only; do not publish it. It contains security gaps (see "Data sensitivity" in the root `AGENTS.md`).
- The documents describe the end state. Habib hands them out only when everything in them is live, and Mahyar tells him when that is.
- Re-verify a TOM claim in code and GCP before reusing it. Fixes land in the meviq repo and `meviq-prod` and need Mahyar's approval.
- Anlage 2.2 lists only services that receive chat content that may hold personal (patient) data (Habib, 10 Oct).

## Source map

| Where | What to search or open |
|---|---|
| Outlook | Main thread "AVV und Datenschutzerklärung Eviplex" (Jul to Nov; Habib, Felix, Mahyar). Earlier: "Datenschutz / AVV Topics" (27–28 Jul), "Datenschutzerklärung und AVV für Ziliar/Eviplex" (20 Jul), "Impressum und Nutzungsbedingungen Eviplex", "Datenfluss mit OpenAI" (5 Oct). Counsel: "EVIPLEX / OpenAI – § 203 StGB in der LLM-Lieferkette unsere Fragen", "Berufsgeheimnis -Dokumentation 1. Entwurf und to does", "Empfehlung für Bewerbung und Finales Compliances-Gutachten als Dokumentation für Berufsgeheimnis" (risch@eventlawyers.de). Google PSA: "Urgent: Gemini API Usage / Privacy Agreement" and "DRAFT version - PSA" (wonneberger@google.com). Search `AVV`, `Verschwiegenheitsvereinbarung`, `Berufsgeheimnis`, `TOMs`. |
| Teams | Mahyar's 1:1 chat with Habib (2–4 Nov: reminder, "5 points open", end-state question). Eviplex weekly meeting chat (plan memo, project "Professional secrecy (§203)"). Search `AVV OR Verschwiegenheit OR TOMs OR Berufsgeheimnis`. |
| Slack | Handover of PR #1079 to Shervin, 17 Nov: https://fomf.slack.com/archives/C08RW4F6QJ1/p1794926193091819. Otherwise not searched yet. |
| SharePoint | Not searched yet. The draft `Entwurf_AVV-Anlage-Nutzungsbedingungen-Eviplex_V-05.docx` came as a mail attachment (Felix, 5 Oct; Habib, 28 Oct). |
| Notion | "AVV-Anlage-Nutzungsbedingungen-Eviplex_V-03" (https://app.notion.com/p/fomf/AVV-Anlage-Nutzungsbedingungen-Eviplex_V-03-3ad7afedf3098046b105d08f53461eed), written by Mahyar on 30 Jul. |
| Linear | Board issue CTO-1 (private team cto-assistant). Project "Professional secrecy compliance (§203 StGB)" (P-EVP-242, lead Mahyar, In Development); issue EVP-1314 "Data processing agreement (AVV) and internal confidentiality obligations" (Todo). Checked 15 Nov 2026. |
| Other | GitHub `fomf-code/meviq` PRs #1079 (merged 17 Nov) and #1093 (merged 10 Nov). GCP project `meviq-prod` (Cloud SQL, Redis, GKE, buckets). |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
| `../../cybersecurity/reports/avv-pruefung-2026-11-03.html` | The review for Habib (German): Anlage 2.2 per service, which TOMs hold, what FOMF cannot promise in the secrecy agreement, next steps. Git-ignored because it lists security gaps |
