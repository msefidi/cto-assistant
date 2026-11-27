# Eviplex AVV and FOMF↔Eviplex secrecy agreement

Eviplex GmbH needs a data processing agreement (AVV) with the doctors who book Plus or Pro, because it processes what they type into the chat on their behalf. Felix Dümpert (DPO) drafts the AVV; Habib owns the documents. Mahyar checks Anlage 2.1 (TOMs) and Anlage 2.2 (subprocessors) and whether FOMF can keep the "Interne Verschwiegenheitsvereinbarung" (§ 203 StGB) between FOMF and Eviplex, which Habib needs before FOMF employees are pledged. The work started in July 2026; Mahyar wrote his review for Habib on 3 Nov 2026.

## Status

**As of 27 Nov 2026:** AVV: the review and wording changes are with Habib (since 3–4 Nov); no reply from Habib, Felix or counsel on the AVV since. Google PSA: signed for DE and AT (Habib and Google, 24 Nov). Switzerland is not covered: Google offers a Swiss PSA only under an Enterprise Agreement (25 Nov). Google has answered where its current terms cover counsel's missing assurances (log, 25 Nov); what stays open goes into the Enterprise Agreement. Enterprise Agreement: Mahyar sent Stefanie Alex Vassileva's commit draft of Dec 2025 (reviewed 25 Nov), asked for a current offer and pushed for the Swiss PSA; he offered 1, 2 or 3 Dec at 09:00 CET for a call with Google's legal contact. Google has the ball. OpenAI covers § 203 only, not Art. 321 StGB; Mahyar asked OpenAI (26 Nov) to add Swiss cover for a higher commitment, no figure named; OpenAI has the ball. B2B contract: Mahyar answered Habib's draft (27 Nov); he owes the deletion policy by 20 Dec and the SLA inputs. Technical: PR #1079 (Vercel AI Gateway EU endpoint, TLS for Postgres and Redis) and PR #1093 (EU model pin) are merged; that both are live in production is not verified.

- **Next step:** Google confirms the call and sends a current offer. Before the call, Mahyar decides what to ask for on the commit (spend checked 25 Nov) and has counsel check Google's answers on the assurances. In parallel, Mahyar confirms #1079 and #1093 are live in production and checks the unverified TOMs; then he tells Habib the documents can go out. Owner: Mahyar.
- **Next date:** week of 30 Nov 2026, Enterprise Agreement call with Google
- **Waiting on:** Google (Stefanie) for the call date and a current offer; OpenAI (Nathalie Henry) on Art. 321 StGB cover and the commitment it would need; Habib for the certificate wording and § 9 liability (with Erfan and counsel); Felix for the Art. 26 question and the DPIA.

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
| Stefanie Wonneberger and Laura Latsch (Google) | Took over the Google PSA/CMA case on 30 Oct; Christian Putzar is Google's legal contact |
| Alexandra "Alex" Vassileva (Google) | Former account executive; wrote the commit proposal of Dec 2025 |
| Wafa | Co-founder; commented on the AVV in July; signed the OpenAI Enterprise Agreement (Sep 2026) and is cc on the Art. 321 ask |
| Nathalie Henry (OpenAI) | Account executive for the OpenAI Enterprise Agreement and ZDR |

## Open points

- PRs #1079 (merged 17 Nov) and #1093 (merged 10 Nov): live in production not verified. (owner: Mahyar)
- The Vercel AI Gateway location and OpenAI retention are not confirmed; Anlage 2.2 says "Ort wird noch bestätigt". The EU endpoint came with PR #1079 (merged 17 Nov); Anlage 2.2 can name it once it is confirmed live. (owner: Mahyar)
- TOMs not verified on 3 Nov: admin roles, least privilege, alerting, subprocessor certificates. Further technical gaps from the review are listed in the review page, not here. (owner: Mahyar)
- Certificates: Anlage 2 of the secrecy agreement names ISO 27001, BSI C5 and SOC 24/7, and Anlage 2.1 says "ausschließlich zertifizierte Unterauftragnehmer"; FOMF has none of these. Mahyar asked Habib on 4 Nov whether to strike them or set them as a dated goal. (owner: Habib)
- § 9 unlimited liability between the sister companies. (owner: Habib, with Erfan and counsel)
- Braintrust: Art. 26 (joint controllership) or quality checks on Eviplex's behalf under Art. 28. (owner: Felix, with counsel)
- DPIA status. (owner: Felix)
- Google PSA for Switzerland (Art. 321 StGB): only under an Enterprise Agreement, not under the online terms (Google, 25 Nov). The pay-as-you-go PSA for DE and AT is signed (24 Nov); which FOMF entity signed is not recorded (it must match the Google Cloud account holder). (owner: Mahyar and Habib)
- OpenAI and Art. 321 StGB (CH): the Enterprise Agreement (USD 100,000 a year, start 21 Sep 2026) has OpenAI's standard § 203 wording only; OpenAI refused Swiss and Austrian wording on 7 Sep. Asked again on 26 Nov against a higher commitment; Mahyar's undisclosed ceiling is about +20 %. Whether Austria (§ 121 StGB) should be asked too is open. (owner: Mahyar, with Wafa)
- Counsel's missing assurances: Google named the terms and controls that cover them (log, 25 Nov). Counsel to check whether that is enough; the rest becomes terms of the Enterprise Agreement. (owner: Mahyar)
- Enterprise Agreement commit: Alex's draft is from Dec 2025 (USD 260,000 for 12 months). Spend runs at about $306k a year (Aug–Oct 2026), about $258k without Elastic Cloud and Maps; the 5 % roughly equals the sustained-use discounts lost, and Vertex credits are worth a few thousand euros (log, 25 Nov). Open: a current offer; whether Marketplace (Elastic) and Maps count toward the commit; a lower commit or a better discount; whether Eviplex's own billing account would count; publicity clause; auto-renewal; billing entity (FomF GmbH vs Eviplex GmbH or the Swiss company). (owner: Mahyar)
- The review planned Anlagen 2.1 and 2.2 as tracked changes in a V-06 with legal entity names and a data-flow diagram. Whether V-06 exists is not recorded. (owner: Mahyar)
- B2B contract (Habib's draft of 24 Nov; Mahyar answered 27 Nov): Mahyar owes Habib the deletion policy (before 20 Dec) and what OpenAI and Google promise on availability, plus a degraded-mode definition for Anlage 5. Still to go through with Wafa: prices, price adjustment and licence terms. Not raised with Habib yet: the tax clause (§ 7.5) for Erfan and the tax adviser, and that Swiss hospitals are not covered under Art. 321 StGB. The product must count a shared quota per organisation; whether it can is not checked. (owner: Mahyar)
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
| Outlook | Main thread "AVV und Datenschutzerklärung Eviplex" (Jul to Nov; Habib, Felix, Mahyar). Earlier: "Datenschutz / AVV Topics" (27–28 Jul), "Datenschutzerklärung und AVV für Ziliar/Eviplex" (20 Jul), "Impressum und Nutzungsbedingungen Eviplex", "Datenfluss mit OpenAI" (5 Oct). Counsel: "EVIPLEX / OpenAI – § 203 StGB in der LLM-Lieferkette unsere Fragen", "Berufsgeheimnis -Dokumentation 1. Entwurf und to does", "Empfehlung für Bewerbung und Finales Compliances-Gutachten als Dokumentation für Berufsgeheimnis" (risch@eventlawyers.de). Google PSA: "Urgent: Gemini API Usage / Privacy Agreement" and "DRAFT version - PSA" (wonneberger@google.com). Enterprise Agreement: "Proposal Commit _ FomF" (alvassileva@google.com, Dec 2025, drafts attached). OpenAI: "URGENT AW: OpenAI API Follow Up" (Aug–Sep 2026; Enterprise Agreement, § 203 wording, CH/AT refusal) and "Swiss professional secrecy (Art. 321 StGB) – revisiting our agreement" (26 Nov) with nathalie.henry@sales.openai.com. B2B contract: "B2B-Vereinbarung Eviplex – offene Punkte, SLA und abschließende Prüfung" (Habib, 24 Nov; contract and Anlagen 1–5 attached). Counsel review of terms of use V1.2, AVV V-07 and § 203 documents: "EVIPLEX – Prüfung Nutzungsbedingungen, AVV, § 203-Vereinbarungen sowie Verarbeitungskette FOMF/Eviplex" (Habib to Risch-Kerst, 16 and 19 Nov). Search `AVV`, `Verschwiegenheitsvereinbarung`, `Berufsgeheimnis`, `TOMs`. |
| Teams | Mahyar's 1:1 chat with Habib (2–4 Nov: reminder, "5 points open", end-state question). Eviplex weekly meeting chat (plan memo, project "Professional secrecy (§203)"). Search `AVV OR Verschwiegenheit OR TOMs OR Berufsgeheimnis`. |
| Slack | Handover of PR #1079 to Shervin, 17 Nov: https://fomf.slack.com/archives/C08RW4F6QJ1/p1794926193091819. Otherwise not searched yet. |
| SharePoint | Not searched yet. The draft `Entwurf_AVV-Anlage-Nutzungsbedingungen-Eviplex_V-05.docx` came as a mail attachment (Felix, 5 Oct; Habib, 28 Oct). |
| Notion | "AVV-Anlage-Nutzungsbedingungen-Eviplex_V-03" (https://app.notion.com/p/fomf/AVV-Anlage-Nutzungsbedingungen-Eviplex_V-03-3ad7afedf3098046b105d08f53461eed), written by Mahyar on 30 Jul. |
| Linear | Board issue CTO-1 (private team cto-assistant). Project "Professional secrecy compliance (§203 StGB)" (P-EVP-242, lead Mahyar, In Development); issues EVP-1314 "Data processing agreement (AVV) and internal confidentiality obligations" (the AVV part) and EVP-1315 "Google Cloud: close the §203 gap or move to an alternative provider" (the Google PSA part), both In Progress and assigned to Mahyar; they show the legal track on the §203 roadmap, so update them when this topic's status changes. Checked 20 Nov 2026. |
| Other | GitHub `fomf-code/meviq` PRs #1079 (merged 17 Nov) and #1093 (merged 10 Nov). GCP project `meviq-prod` (Cloud SQL, Redis, GKE, buckets). |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
| `../../cybersecurity/reports/avv-pruefung-2026-11-03.html` | The review for Habib (German): Anlage 2.2 per service, which TOMs hold, what FOMF cannot promise in the secrecy agreement, next steps. Git-ignored because it lists security gaps |
