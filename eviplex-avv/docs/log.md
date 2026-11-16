# Eviplex AVV: log

Newest first. One entry per event or result. Decisions go in `decisions.md`, one line each. Each entry ends with who said it and where, in brackets. Summarise the source; the original stays where it is.

## 2026-11-15: folder set up

Brief, decisions and log written from the review page, the memory note `eviplex-avv-review` and a search of Outlook, Teams, Linear and the meviq PRs. No reply from Habib, Felix or counsel on the AVV after 4 Nov was found. Slack and SharePoint were not searched. (session with Mahyar)

## 2026-11-13: § 203 project in the weekly memo

The Eviplex plan memo for the week of 16 Nov lists "Professional secrecy (§203)" with Max as owner: the Gemini pipeline started, patient birthdates are masked in traces, and Habib and Mahyar clarified the Swiss wording. (Mahyar, `eviplex-weekly/2026-11-16.md` and Eviplex weekly meeting chat)

## 2026-11-11: call with Google on the PSA

Mahyar and Habib met Google's legal contact. Google has a fixed pay-as-you-go PSA template, good for DE and AT but not for Switzerland, and a negotiable version for Enterprise Agreement customers. The PSA is still unsigned. (Mahyar, mail thread "Urgent: Gemini API Usage / Privacy Agreement"; memory note `eviplex-ch-tech-factsheet`)

## 2026-11-10: OpenAI EU pin merged

PR #1093 took the EU pin out of #1079 and merged it: `openai/*` calls through the Vercel gateway now ask for the EU zone, and dictation goes to OpenAI's EU endpoint. The gateway rejected an EU pin for transcription with HTTP 400. PR #1079 stays open for the Postgres and Redis TLS. Deployment to prod is not verified. (jole141, meviq PR #1093)

## 2026-11-04: wording changes sent to Habib

Mahyar answered on the main thread, cc Felix: some items are done, the rest is being built, and he will tell Habib when all is live. He sent the new wording for Anlage 2.1 and 2.2 and FOMF's position on § 2, 5, 6 and 8 of the secrecy agreement, and asked Habib how to handle the certificates. He left § 9 liability to Habib, Erfan and counsel. On the same day PR #1079 was still off by default and did not cover dictation. (Mahyar, mail "AVV und Datenschutzerklärung Eviplex"; memory note `eviplex-avv-review`)

## 2026-11-03: review written and first fixes made

Mahyar checked Anlagen 2.1 and 2.2 against meviq main (e8bf9ef) and read-only gcloud on `meviq-prod`. Findings: 3 services missing from Anlage 2.2 (Vercel, Datadog, Retool), 7 TOM claims untrue, among them OpenAI not pinned to the EU and no rate limits (the full list is in the review page), and 5 clauses of the secrecy agreement FOMF cannot keep (no storage, no quality checks, certificates, 12-hour notice, unlimited liability). What holds: Frankfurt hosting, Secret Manager, constant-time key checks, 7 days of backups plus point-in-time recovery, Braintrust in the EU with names masked. Some gaps were fixed the same day with Mahyar's approval; PR #1079 was opened. In Teams Mahyar told Habib 5 points were still open, with Shervin and Josip on some of them, and Habib asked him to confirm the documents describe the end state. (Mahyar, review page `cybersecurity/reports/avv-pruefung-2026-11-03.html`, session of 3 Nov, Teams 1:1 chat with Habib)

## 2026-11-02: Habib's reminder

Habib reminded Mahyar in Teams to confirm or correct the TOMs and subprocessors from his mail of 28 Oct. (Habib, Teams 1:1 chat)

## 2026-10-30: Google hands over the PSA case

Google passed the PSA/CMA case to new contacts, Stefanie Wonneberger and Laura. The review lists the Google § 203 addendum as a step before employees are pledged. (Google, mail thread "Urgent: Gemini API Usage / Privacy Agreement"; review page)

## 2026-10-28: AVV and secrecy agreement sent for review

Habib resent the current AVV draft and asked Mahyar to check and update Anlage 2.1 (TOMs) and 2.2 (subprocessors). He also sent the FOMF↔Eviplex secrecy agreement, which holds more TOMs in red and points FOMF may not be able to keep; employees are to be pledged on its basis. He announced a revised terms of use that separates Free and paid. (Habib, mail "AW: AVV und Datenschutzerklärung Eviplex", cc Felix; Teams 1:1 chat)

## 2026-10-26: attachment missing

Mahyar replied that Habib's mail of 10 Oct came without an attachment. (Mahyar, mail "Re: AVV und Datenschutzerklärung Eviplex")

## 2026-10-16: AVV on the consultation list

Wafa's notes of a consultation list "AVV / interne Verschwiegenheit" with Habib and Parham as owners. (Wafa, mail "Consultation today")

## 2026-10-10: Habib asks Mahyar to check the Anlagen

Habib forwarded Felix's V-05 and asked Mahyar to check whether the TOMs and the subprocessors are correct. (Habib, mail "WG: AVV und Datenschutzerklärung Eviplex")

## 2026-10-05: AVV draft V-05

Felix checked his last draft again. Clause 3.3 changed: users may now enter data that is not pseudonymised. Anlagen 2.1 and 2.2 must come from engineering. File: `Entwurf_AVV-Anlage-Nutzungsbedingungen-Eviplex_V-05.docx`. (Felix Dümpert, mail "AW: AVV und Datenschutzerklärung Eviplex")

## 2026-09-10: counsel's Berufsgeheimnis documentation

Prof. Dr. Mandy Risch-Kerst sent Habib a first draft of the documentation that relieves the management of liability under the professional secrecy rules, with to-dos; the final legal opinion followed on 16 Sep. (Risch-Kerst, mails "Berufsgeheimnis -Dokumentation 1. Entwurf und to does" and "Empfehlung für Bewerbung und Finales Compliances-Gutachten als Dokumentation für Berufsgeheimnis")

## 2026-07-30: Mahyar fills in the Anlagen (V-03)

Mahyar wrote the Anlagen sections on the Notion page "AVV-Anlage-Nutzungsbedingungen-Eviplex_V-03". (Mahyar, mail "Re: AVV und Datenschutzerklärung Eviplex")

## 2026-07-29: Felix rewrites the AVV

Felix rebuilt the AVV from scratch, because the earlier AI-written draft had misread the setup: the doctor is controller for what they type into Eviplex, and Eviplex processes it on their behalf. Open: Art. 28 or Art. 26, since Braintrust monitoring may be an own purpose; placeholders in Anlage 2.1; in Anlage 2.2 the SCCs for US transfers, the Jina and Vertex reranking region, Braintrust's status and the exact legal entities. He warned that FOMF must really be able to meet Art. 28 duties and is liable for its subprocessors. Habib asked Mahyar or Parham to fill in the Anlagen the next day. (Felix Dümpert and Habib, mail "WG: AVV und Datenschutzerklärung Eviplex")

## 2026-07-27: first AVV questions

Habib sent the open questions on privacy and the AVV; Mahyar answered on 28 Jul and Habib asked which deletion method to name in the AVV. (Habib and Mahyar, mail thread "Datenschutz / AVV Topics")

## 2026-07-20: first comments on the AVV

Felix commented on the terms of use and Anlage 1, the AVV between Eviplex and the user. (Felix Dümpert, mail "AW: Datenschutzerklärung und AVV für Ziliar/Eviplex")
