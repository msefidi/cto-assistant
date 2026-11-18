# Security assessment: log

Newest first. One entry per event or result. Decisions go in `decisions.md`, one line each. Each entry ends with who said it and where, in brackets. Summarise the source; the original stays where it is. Findings and pentest results never go here; they go in `../reports/` (git-ignored) and SharePoint.

## 2026-11-18: Eli Lilly quick wins folded into the roadmap

Mahyar cancelled CTO-9 ("Review quick wins with Andreas"): the IT security management work with Andreas replaces it. Its idea was to check which quick wins FOMF promised Eli Lilly and cover them. The Linear project "Eli Lilly Cybersecurity" (P-ENG-190, lead Andreas) lists six: audit log management, media destruction and secure deletion are done (15 Jul); change management and the data inventory (due 1 Sep) are open; security training (due 31 Dec) is in research. Added as section 5 of `../it-security-management-2026-11-18.md`. An earlier version of the brief called P-ENG-190 "a different matter"; it is part of this work. (Mahyar, session of 18 Nov; Linear project P-ENG-190, read 18 Nov)

## 2026-11-18: IT security management started with Andreas

In their weekly 1:1, Mahyar and Andreas wrote down where FOMF stands on IT security management, in four areas: device management (Windows has basic hardening; macOS and Linux not onboarded; no hardening profiles; MDM not started; three update rings defined; device restrictions in audit mode only), Entra ID and access (MFA with passkeys and Authenticator, admin roles, joiner/leaver process, enterprise applications), SharePoint (no structure or per-site access yet) and Exchange (phishing and spam rules). The notes are incomplete; the point was to start. Mahyar runs a survey of Mac users (Andreas's MS Forms for engineers and unit leads, Slack DM thread of 8 Oct) before Macs are onboarded. Baseline in `../it-security-management-2026-11-18.md`; board sub-issue CTO-24. (Mahyar and Andreas, 1:1 on 18 Nov; notes from Mahyar, cleaned up in session)

## 2026-11-16: team onboarded in Slack

Mahyar created the private channel #p-cybersecurity-assessment and posted the onboarding message there for Andreas, Shervin, Simone, George and Rahim. Andreas and Shervin are asked to block the proposed weeks for access and configuration work; Simone, George and Rahim are kept informed. (Mahyar, Slack #p-cybersecurity-assessment, C0CHXPGCWHH; text in `slack-draft-team-onboarding-2026-11-16.md`)

## 2026-11-16: Slack onboarding for the team drafted

Claude drafted a Slack message for Andreas, Shervin, Simone, George and Rahim: what Blaze tests, the proposed weekly timeline (not yet confirmed by Blaze), Andreas and Shervin to block the weeks for access and configuration work, Simone, George and Rahim kept informed (test accounts and data before the January pentests, fixes as product work from February), findings kept confidential. Not yet sent. (session with Mahyar; `slack-draft-team-onboarding-2026-11-16.md`)

## 2026-11-16: weekly timeline sent to Blaze

Mahyar sent Carol and Mariana Teixeira the weekly timeline below, in his own wording, and asked whether it works for Blaze. (Mahyar, mail "Re: Kick-off call | Blaze x FomF - Penetration test"; text in `email-draft-blaze-dates-2026-11-16.md`)

## 2026-11-16: new phase dates drafted

Blaze's dates of 12 Nov do not work for us. Mahyar decided to move every phase and keep the order. He is away from 14 Dec, so only Phase 1 and its debrief run in December and GCP opens January. The draft gives Blaze one week per part and lets it fit the dates: M365 week of 7 Dec with the debrief by 11 Dec 2026; GCP 6–8 Jan, kick-off in the same week; OSINT week of 11 Jan, after GCP and before the pentests; GKE week of 18 Jan; Eviplex pentest from 25 Jan; learning-platform pentest from 1 Feb 2027, one week after Eviplex. Mahyar wrote the final wording of the mail. The reply to Blaze is in `email-draft-blaze-dates-2026-11-16.md` and not yet sent. No new mail from Blaze since 12 Nov. (session with Mahyar; Outlook thread "Re: Kick-off call | Blaze x FomF - Penetration test")

## 2026-11-12: Andreas on the dates

Mahyar asked Andreas about Blaze's dates, the first one most of all. Andreas: IT is in event high season until 28 Nov, so mid-December would be ideal, and he asked whether Google could go first. Mahyar preferred to keep the phase order and asked for the earliest Phase 1 start; Andreas said 7 Dec, as an optimistic assumption. On 13 Nov Andreas said his vacation starts on 27 Dec. (Mahyar and Andreas, Slack DM, thread of 12 Nov)

## 2026-11-15: folder set up

Brief, decisions and log written from the memory note `security-assessment-vendor`, the files in this folder and a search of Outlook and Teams. The search found Blaze's proposed phase dates of 12 Nov and no reply from Mahyar yet. It also found that the DPA was signed with the contract on 9 Nov. Slack, SharePoint and Notion were not searched. No Linear project exists. (session with Mahyar)

## 2026-11-12: Blaze proposes the phase dates

Carol passed on dates from Blaze's PM team: M365 23–26 Nov 2026; GCP 2–4 Dec; OSINT 28–29 Dec; GKE review 31 Dec 2026 to 6 Jan 2027; Eviplex pentest 4–14 Jan 2027; learning-platform pentest 7–15 Jan 2027. Mariana Teixeira (Blaze PM) will set up a kick-off call about a week before each phase: introductions, a demo of the application, access and test requirements. Blaze asks us to confirm or name problem dates. The same day Mahyar got access to the Blaze Client Portal, where requests such as a new test or a retest are raised. (Carol Galatoli, mail "Re: Kick-off call | Blaze x FomF - Penetration test"; Blaze Client Portal, mail "Your access to Blaze Client Portal")

## 2026-11-10: the EB asks how often

Sina asked in the EB chat how often such a check should run and whether something could check us continuously. Mahyar answered that once a year should be enough, that later checks could use more automated tools without consultants, which is cheaper, and that the first one should be done with a firm like Blaze. (Sina and Mahyar, Teams chat "Executive Board")

## 2026-11-09: contract and DPA signed; EB informed

Mahyar's review of contract #2026.11.013 found the old 21 Oct prices and terms; he asked Carol to reissue it. Blaze sent v4 (#2026.11.014) the same day with every requested change. Carol confirmed by email that the SOW's months (Nov, Dec, Jan) are not binding: dates are agreed with Blaze's PM team after signing, with no contract change. DocuSign reported both v4 and the DPA as completed by all parties at 14:02. Mahyar posted the EB memo (`eb-memo-blaze-2026-11-09.md`) in the EB chat, and Carol handed the project to Blaze's PM team. (Mahyar and Carol Galatoli, mail thread "Ihre Anfrage für einen Pentest bei Blaze Information Security"; DocuSign mail "Completed: Complete with Docusign: DPA FomF.docx.pdf, FomF x Blaze Security Assessment v4.pdf"; Teams chat "Executive Board"; mail "Kick-off call | Blaze x FomF - Penetration test")

## 2026-11-09: PCG and Exaspace told

Mahyar told Alex Stati (PCG) that FOMF had chosen another vendor; Alex replied kindly the same day. Mahyar also told Jan Weis (Exaspace Security) that the ISMS workshop would go with Blaze. Jan said to come back if long-term support is needed. (Mahyar, mail threads "Kurze Frage zu unserem Projekt" and "InfoSec Consulting")

## 2026-11-06: revised offer; NDA signed

Blaze had answered our eight questions on 29 Oct with an updated proposal and a link to its Art. 28 DPA, to be signed before testing. The revised offer brings Eviplex from 3 to 9 days and the day rate from €1,300 to €1,100: 29 days, €31,900 net (€37,961 gross). Retest is one round per phase within 90 days, with overruns on Blaze; there is a free 1 h debrief after each phase; the MSA version at signing applies. Blaze kept its endpoint figures (120 learning platform, 40 Eviplex), which do not match our inventory. It sent redacted sample reports and named Kaia Health, STADA and TeamViewer as references. Habib had signed the NDA by this date. (Carol Galatoli, mail thread "Ihre Anfrage für einen Pentest bei Blaze Information Security", 29 Oct to 6 Nov; `vendor-comparison-2026-10.md`, "Update 6 Nov 2026")

## 2026-11-03: first DocuSign envelope

Habib received a DocuSign envelope from Blaze (proposal #2026.10.055) and sent it to Mahyar to check that it contained everything we had asked for. (Habib, mail "Blaze Contract")

## 2026-10-28: NDA amendment

Habib sent Blaze an "Amendment No. 1 to the Mutual Non-Disclosure Agreement" with our changes. Carol answered on the NDA thread the same day. The v4 contract later names the NDA including Amendment No. 1. (Habib and Carol Galatoli, mails "NDA Blaze" and "NDA | Blaze <> FOMF")

## 2026-10-27: Blaze chosen internally; NDA reviewed

Mahyar compared PCG and Blaze, reviewed Blaze's NDA, counted the API endpoints in both repos and did a short research on the ISO 27001 path. The learning platform has about 400 GraphQL operations plus about 100 REST handlers, against the 135 endpoints in Blaze's offer; Eviplex has about 56 routes plus 5 Next.js routes, against 40. A pentest alone does not make FOMF ISO-ready; that needs a separate ISMS track. Mahyar sent Blaze the questions and the NDA comments and told Habib an NDA would come to him for signature. (Mahyar, session of 27 Oct, `vendor-comparison-2026-10.md` and `blaze-nda-review-2026-10-27.md`; Teams 1:1 chat with Habib)

## 2026-10-26: Mahyar tells the EB about Blaze's offer

Mahyar wrote in the EB chat that Blaze's offer is roughly at PCG's level, €25,000 to €30,000, for pentests of the platform, Eviplex and M365. (Mahyar, Teams chat "Executive Board")

## 2026-10-21: Blaze offer

Blaze sent offer #2026.10.030, valid until 21 Nov 2026: core €22,499 net for 17 days at €1,300, options OSINT €2,600 and GKE review €5,200 per cluster. The plan was M365 in Nov 2026, GCP in Dec 2026 and the pentests in Jan 2027. (Blaze, offer #2026.10.030; `vendor-comparison-2026-10.md`)

## 2026-10-15: pentests planned for Nov and Dec

Mahyar wrote in the EB chat that pentests of M365 and Google were planned for possibly November and December. (Mahyar, Teams chat "Executive Board")

## 2026-10-12: Exaspace offers consulting

Jan Weis (Exaspace Security) wrote that he had checked internally that there was no conflict of interest and offered to talk about general IT-security consulting. Jan Weis is also the Blaze contact in copy on the Blaze thread. (Jan Weis, mail "InfoSec Consulting")

## 2026-10-08: Blaze sends its NDA

Carol sent Blaze's mutual NDA and asked for FOMF's company details. She confirmed that Blaze's testers are an in-house team in Europe and that a DPA would follow. Julio Fort, co-founder, signs for Blaze. (Carol Galatoli, mail thread "Ihre Anfrage für einen Pentest bei Blaze Information Security"; `blaze-nda-review-2026-10-27.md`)

## 2026-08-03: PCG offer

Alex Stati sent PCG's offer SODE26002713, dated 30 Jul 2026 and valid until 29 Aug 2026: €12,480 net baseline plus a GCP deep-dive option at €8,320, with no M365 review and no manual pentest of the products. It expired unsigned. Alex followed up on 28 Sep and reported PCG's capacities on 9 Oct. (Alex Stati, mail threads "Fomf <> PCG Security Check - Google" and "Kurze Frage zu unserem Projekt"; `vendor-comparison-2026-10.md`)

## 2026-07-17: first contact with PCG

Mahyar contacted PCG about a security check of the Google Cloud setup, after the Mandiant assessment had been dropped. (Mahyar, mail "Fomf <> PCG Security Check - Google")
