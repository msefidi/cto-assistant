# Eviplex AVV: log

Newest first. One entry per event or result. Decisions go in `decisions.md`, one line each. Each entry ends with who said it and where, in brackets. Summarise the source; the original stays where it is.

## 2026-11-27: Habib told about the tax clause and the Swiss gap

Mahyar told Habib what the reply left out: the tax clause (§ 7.5) needs Erfan and the tax adviser, and Swiss hospitals are not covered under Art. 321 StGB. (Mahyar, session)

## 2026-11-27: Mahyar answered Habib on the B2B contract

Mahyar replied to all (Habib, Wafa; cc Jasmin Naimi, Ute Schellerer): deletion policy by 20 Dec; § 8.4 cannot be promised as written (Google backups up to 180 days, DIN 66399 is for physical media) and should point to the policy; § 4.5 conflicts with full deletion and hangs on Habib's question to Mandy about FOMF's role. SLA: the LLM providers define no degraded mode; Mahyar sends their availability promises and proposes Eviplex's own definition, with provider outages excluded from the 99.5 % and response times within support hours only. Prices and licences: he goes through them with Wafa; Anlage 3 to say per-user pricing with one shared quota for the organisation. Not in the mail: the tax clause (§ 7.5) and the missing Swiss cover (Art. 321 StGB). (Mahyar, reply "Re: B2B-Vereinbarung Eviplex – offene Punkte, SLA und abschließende Prüfung", 27 Nov 08:49 CET)

## 2026-11-27: Habib's B2B contract draft asks Mahyar for a deletion concept and SLA inputs

Habib sent his draft B2B contract for Eviplex (main contract "4.2 B2B Vertrag Kunden Finaler Entwurf", Anlage 1 AVV-V-07 modular, Anlage 2 Berufsgeheimnis V2, Anlagen 3–5) to Wafa and Mahyar, cc Jasmin Naimi and Ute Schellerer, not yet checked by counsel or tax advisers. He asks Mahyar for (1) one deletion concept for all B2B customers, with deadlines and methods, and (2) the LLM providers' availability and "degraded mode" terms for Anlage 5 (SLA); (3) Wafa and Mahyar should go through prices, tax and licence terms before a customer sees the draft. Mahyar's review found that § 8.4 (delete everything, backups included, within 14 days, by DIN 66399 and NIST SP 800-88, with a certificate) cannot be met on Google Cloud, and that § 4.5 (Eviplex may store inputs for quality) conflicts with it. In Anlage 5, it is unclear whether the 1-hour response time for Critical applies only within support hours (Mon–Fri 9–17). (Habib, mail "B2B-Vereinbarung Eviplex – offene Punkte, SLA und abschließende Prüfung", 24 Nov 23:07 CET; session with Mahyar)

## 2026-11-26: OpenAI asked to cover Art. 321 StGB (CH) for a higher commitment

Mahyar asked Nathalie Henry (cc Wafa) to reopen Swiss professional secrecy: future Swiss customers ask for it and the current contract covers § 203 StGB only. FOMF is ready to increase its annual commitment (no figure named) and offered counsel's wording based on OpenAI's § 203 clause; he asked what commitment would make it possible and offered a call with OpenAI legal. Background: the Enterprise Agreement (USD 100,000 a year, 2.5 % discount, start 21 Sep 2026) carries OpenAI's standard § 203 wording; on 7 Sep OpenAI legal refused Swiss and Austrian wording ("no precedent", no capacity for a per-customer review). (Mahyar, mail "Swiss professional secrecy (Art. 321 StGB) – revisiting our agreement", 26 Nov 08:32 CET; earlier thread "URGENT AW: OpenAI API Follow Up", Aug–Sep)

## 2026-11-25: Commit proposal sent to Google; Enterprise Agreement call requested

Mahyar forwarded Alex's commit proposal with the drafts to Stefanie Wonneberger: asked for a current offer based on today's usage, said Switzerland is the open gap (Swiss hospitals are asking) and that FOMF wants to start the Enterprise Agreement now with the Swiss PSA and counsel's points in it; offered Tue 1, Wed 2 or Thu 3 Dec at 09:00 CET with Christian Putzar. (Mahyar, mail "FW: Proposal Commit _ FomF", 25 Nov 11:45 CET)

## 2026-11-25: Google: no Swiss PSA under the online terms; answers on counsel's points

Google offers no Swiss PSA to customers on the online terms (ToS) only; Switzerland needs the Enterprise Agreement. For counsel's missing points, Google names where the current terms cover them and which controls FOMF can switch on (Google's claims):
- **Human access:** CDPA Appendix 2; controls Access Transparency, Access Approval, Key Access Justifications with Cloud EKM.
- **Training:** contractual by default (CDPA instructions; Service Specific Terms § 18).
- **Retention and deletion:** CDPA § 6, deletion within 180 days at most; soft delete up to 30 days, then purged from backups within about 6 months; FOMF sets retention and TTL, Cloud Logging bucket retention.
- **Location and non-EU access:** Service Specific Terms, CDPA transfers clause (incl. Swiss FADP); controls Org Policy resource locations, Assured Workloads (EU), CMEK/EKM.
- **Government requests:** redirect to customer, challenge overbroad ones; holding keys outside Google (EKM) as the control.
- **Audit:** CDPA § 7.5, reports in Compliance Reports Manager.
(Stefanie Wonneberger, cc Laura Latsch, Habib; mail "Re: DRAFT version - PSA", 25 Nov 10:46 CET)

## 2026-11-25: Alex's commit proposal reviewed (draft of Dec 2025)

The drafts (quote Q-353818, Google Cloud EMEA Ltd ↔ FomF GmbH, Hofheim) say more than the summary mail: Vertex credits are 50 % of Vertex GenAI spend per month for 6 months, capped at USD 250,000, valid 12 months and not counted toward the commit; the 5 % applies to the "Cloud Enterprise 2025" SKU group; sustained-use discounts no longer apply; any shortfall on the USD 260,000 is billed at the end; the commit renews for 12 months unless cancelled 15 days before the end (addendum) or 30 days (order form); Google may name FOMF as a customer and ask for case studies, press and reference calls. The order form has the old address (Elisabethenstraße 1). Checked against the billing export (account 010C6F, all FOMF projects): net spend Nov 2025 to Oct 2026 about €305k (about $354k); Aug to Oct 2026 about €22k a month (about $306k a year). Without Elastic Cloud (Marketplace, about €3k a month) and Maps (about €0.6k a month), whose counting toward the commit is unclear, it is about $258k a year, level with the commit. Sustained-use discounts were €14.9k in those 12 months, about as much as the 5 % would save (about €12–14k), so the price gain is close to zero. Vertex AI is small (€0.3–1.7k a month, mostly Gemini on the learning platform), so the 50 % credit is worth a few thousand euros. meviq-prod is about €41k a year; if Eviplex moves to its own billing account, that spend no longer counts. (Claude, session with Mahyar; attachments of mail "Proposal Commit _ FomF", 4 Dec 2025; BigQuery `fomf-v2-prod.billing_export_standard`)

## 2026-11-24: Google PSA signed for DE and AT

Google sent the DocuSign to Habib on 24 Nov; Habib signed at 12:10 CET and Google countersigned the same day. Google also asked for a call next week (09:00–15:00) with Christian Putzar from its legal team. (Stefanie Wonneberger and Habib, mail "Re: DRAFT version - PSA", 24 Nov)

## 2026-11-20: EVP-1314 and EVP-1315 brought in line with this topic

The two §203-project issues had sat in Todo since 30 Oct. Both moved to In Progress, each with a status comment that names no terms or counsel advice: EVP-1314 (AVV with Habib; Mahyar checks the measures are live) and EVP-1315 (Google PSA to Habib for signature; open points into the Enterprise Agreement talks). They stay in the Eviplex team so the team sees the legal track; this brief's source map names them. (Mahyar in session, 20 Nov)

## 2026-11-18: Reply sent to Google; counsel thanked

At 16:38 CET Mahyar sent the reply to Stefanie Wonneberger (cc Laura Latsch, Habib): FOMF signs the PSA for DE and AT, DocuSign to Habib (modabber@fomf.org); asked where Google's current Cloud terms cover counsel's missing points (human access, no training or product improvement, retention and deletion incl. backups and logs, non-EU access and government requests, audit rights) and which controls FOMF can switch on itself; these points and Swiss professional secrecy go into the Enterprise Agreement, call offered; the earlier EA info follows "tonight or tomorrow". At 16:39 CET he thanked Prof. Risch-Kerst (cc Habib): FOMF signs now for DE and AT, the missing assurances go into the EA talks, and FOMF will come back to her on the EA terms. No DocuSign and no answer from Google by 21:30 CET; Alex's commit proposal not yet forwarded. (Mahyar, mails "Re: DRAFT version - PSA" to Wonneberger and to Risch-Kerst, 18 Nov)

## 2026-11-18: Reply to Google in Outlook drafts; Enterprise Agreement needs Alex's old offer

Mahyar put the reply to Stefanie Wonneberger into an Outlook draft: sign the PSA for DE and AT, DocuSign to Habib (modabber@fomf.org, also on cc), questions on counsel's missing assurances, EA call. Not sent at 16:28 CET. For the Enterprise Agreement, Stefanie is waiting for the earlier offer from Alexandra Vassileva (Mahyar). That offer is the mail "Proposal Commit _ FomF" of 4 Dec 2025: 12-month commit of USD 260,000, 5 % discount on GCP, 50 % of Vertex AI spend returned as GCP credits for the first 6 months, a new billing account in EUR, and the billed entity can later move to the Swiss company through a billing case; drafts `EA_12_2_2025.pdf` and `GCP Order Form_12_2_2025.pdf` attached. Alex chased on 11 Dec 2025; no commit was signed. On 27 Nov 2025 she had offered to set up the commit directly for the new legal entity. (Mahyar in session; Outlook draft "Re: DRAFT version - PSA"; Vassileva, mails "Proposal Commit _ FomF", "Re: Proposal Commit _ FomF", "Initial follow up from our meeting 27.11")

## 2026-11-18: Counsel says sign the Google PSA for DE and AT; technical assurances still missing

Prof. Risch-Kerst (cc Habib) replied on the PSA. Verdict: usable as a legal baseline and to be signed for Germany and Austria. It fits § 203 better than OpenAI's terms because Google explicitly commits to keeping "Professional Secrets" (defined by § 203 StGB), refers to §§ 203 and 204, and must pledge its staff, subcontractors and subprocessors in text form, who pledge further people in turn (§ 203 Abs. 3 and 4). What it lacks for the compliance concept: (1) "Acquiring Knowledge" covers human access only, not automated processing, indexing, telemetry or security scanning; there is no commitment against human access outside a documented exception process, admin access to clear text, or storing content through classification, and none on customer key control or access logging; (2) nothing on retention, backups, caches, support tickets, logs, DR copies, deletion at contract end or proof of deletion; (3) no explicit ban on training, fine-tuning, benchmarking or product improvement; (4) nothing on processing location, which Google companies have access, access from third countries, government requests or notifying the customer; (5) no audit, evidence or incident-support rights. She would not rely on it without technical and organisational assurances and asks FOMF to make them contract terms in the Enterprise Agreement at the latest, or now in the main contract. Her summary: Google has the stronger legal wrapper, OpenAI the stronger technical focus on data minimisation; the two should be combined. Stefanie Wonneberger had followed up on 17 Nov asking whether counsel has questions or whether we can sign. (Risch-Kerst, mail "AW: DRAFT version - PSA", 18 Nov 15:27 CET; Wonneberger, mail "Re: DRAFT version - PSA", 17 Nov 10:42 CET)

## 2026-11-18: Board issue reopened; topic stays open for the Google PSA

Mahyar had set CTO-1 to Done at 11:26 UTC ("Shervin merged the PR - so this should be fine now."). He then said the topic stays open because the Google PSA is still to be clarified. CTO-1 is back in Delegated/Waiting (Risch-Kerst), due 20 Nov. (Mahyar, CTO-1 comment and session)

## 2026-11-18: PR #1079 merged

PR #1079 "feat(avv): verified TLS for Postgres/Redis + EU AI Gateway endpoint" was merged into meviq main on 17 Nov at 19:49 UTC (20:49 CET). Together with #1093 (EU inference region for OpenAI calls and voice transcription, merged 10 Nov), the code now routes model calls through EU endpoints. Production deployment of both is not verified. (GitHub fomf-code/meviq; Mahyar in session)

## 2026-11-17: PR #1079 handed to Shervin; nothing on Mahyar's side

Mahyar asked Shervin in Slack to take over PR #1079 and ideally finish it the same day, with three goals: (1) pin EU-enabled models, already done by Josip (cherry-picked and merged); (2) use the Vercel AI Gateway's EU endpoint (regional hosting); (3) enable TLS on Postgres and Redis. Parham is on cc. Shervin took it over on GitHub at 15:52 CET: rebased on main (the OpenAI EU part is gone, merged in #1093) and gave the CMS (MikroORM) the same verified TLS as Drizzle. Mahyar also said the Google PSA is waiting for Prof. Risch-Kerst's review and that nothing is on his side for now. (Mahyar, Slack https://fomf.slack.com/archives/C08RW4F6QJ1/p1794926193091819, 17 Nov 15:36 CET; Shervin, meviq PR #1079 comment; session with Mahyar)

## 2026-11-17: Google § 203 history before 30 Oct, moved here from memory

Until now only the memory note `eviplex-ch-tech-factsheet` held this. Google NDA n91499 is between Google Ireland and FomF GmbH, Baden (AT), which Mahyar named as the correct FOMF contracting entity. On 5 Aug 2026 FOMF sent a proposed § 203 clause; it covered inference only (its para 5 forbids persistent storage), so it did not cover Cloud SQL, GKE or Storage. On 9 Oct Google (Alex Vassileva) declined custom § 203 language and offered a CDPA review, Assured Workloads (EU Data Boundary, personnel controls, Access Approval and Transparency), Confidential Computing, and a Cloud Master Agreement with the Professional Secrecy Addendum (PSA) for DACH healthcare, subject to eligibility. FOMF had only the NDA, no CMA. Open questions then: eligibility of a SaaS processor serving doctors, CH and AT coverage, CMA and PSA as a bundle. (Mahyar, mail thread "Urgent: Gemini API Usage / Privacy Agreement" with Alex Vassileva and Rojan Gharadaghy; memory note of 9 Oct)

## 2026-11-16: PSA question sent to counsel

Mahyar asked Prof. Risch-Kerst (cc Habib) whether FOMF should sign Google's fixed pay-as-you-go PSA now, to cover DE and AT, and sign a custom PSA after an Enterprise Agreement. He asked for her view by the end of the week (20 Nov). The first forward had no PSA attached; Mahyar sent the PDF "GCP and Workspace Professional Secrecy Addendum (DE)_11_11_2026.pdf" three minutes later. (Mahyar, mails "FW: DRAFT version - PSA", 16 Nov 07:56 and 07:59 CET)

## 2026-11-16: Google PSA is ready to sign, waiting on FOMF

On 11 Nov, after the call, Stefanie Wonneberger sent the draft PSA (German) and then said Google already has the final version ready for signature, which can be signed any time. She asked who should receive the DocuSign envelope and whether FOMF's counsel has questions. Mahyar said he would pass it to counsel and come back to her. No later mail from Mahyar to Google or to counsel was found up to 16 Nov. Christian Putzar and Laura Latsch (Google) are on cc. (Stefanie Wonneberger and Mahyar, mail thread "DRAFT version - PSA")

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
