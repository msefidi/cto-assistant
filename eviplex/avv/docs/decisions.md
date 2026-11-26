# Eviplex AVV: decisions

One line per decision, newest first. Each line ends with who decided and where. A line is never edited; when a decision changes, add a new line that says which one it replaces.

- 2026-11-26: Offer OpenAI a higher annual commitment in exchange for Art. 321 StGB cover, without naming a figure; Mahyar's own ceiling is about +20 % (USD 120,000), not disclosed. (Mahyar, session; mail to Nathalie Henry 26 Nov)
- 2026-11-17: Shervin takes over PR #1079. Its scope: Vercel AI Gateway EU endpoint (regional hosting) and TLS for Postgres and Redis; the EU model pin is done (PR #1093). (Mahyar, Slack https://fomf.slack.com/archives/C08RW4F6QJ1/p1794926193091819)
- 2026-11-11: Sign Google's fixed pay-as-you-go PSA now (good for DE and AT), then negotiate an Enterprise Agreement for a PSA that can cover Switzerland. (Mahyar and Habib, call with Google; recorded in memory note `eviplex-ch-tech-factsheet`)
- 2026-11-10: Dictation calls OpenAI's EU endpoint (`eu.api.openai.com`) directly, because the Vercel gateway has no EU region for transcription; with no URL set, dictation returns 503 and sends no audio. (jole141, meviq PR #1093)
- 2026-11-10: The OpenAI EU inference pin is set in the `pr` and `prod` overlays. Replaces the off-by-default approach of PR #1079, which now holds only the TLS work. (jole141, meviq PR #1093)
- 2026-11-04: FOMF's position on the secrecy agreement: § 8 breach notice within 24 hours, not 12. (Mahyar, mail "AVV und Datenschutzerklärung Eviplex")
- 2026-11-04: FOMF's position on the secrecy agreement: quality checks on Eviplex's behalf are allowed, with masked names (§ 2, § 6). (Mahyar, mail "AVV und Datenschutzerklärung Eviplex")
- 2026-11-04: FOMF's position on the secrecy agreement: "no storage" applies only to the AI providers; FOMF stores as operator on Eviplex's instructions (§ 5, § 6). (Mahyar, mail "AVV und Datenschutzerklärung Eviplex")
- 2026-11-04: Anlage 2.2 lists FOMF GmbH (operation and hosting), Google Cloud (EU, Frankfurt), OpenAI (EU, answers and dictation), Vercel AI Gateway (location to be confirmed, no lasting storage) and Braintrust (EU, names masked). Azure, Google Vertex AI, Elasticsearch and the FOMF GraphQL API are struck. Anlage 3 of the secrecy agreement gets the same list. (Mahyar, mail "AVV und Datenschutzerklärung Eviplex")
- 2026-11-04: Anlage 2.1 Verfügbarkeit reads "Vor Überlastung schützen Nutzungskontingente pro Nutzer." instead of promising rate limits. (Mahyar, mail "AVV und Datenschutzerklärung Eviplex")
- 2026-11-04: Anlage 2.1 Zugangskontrolle reads: databases and internal services are not publicly exposed; access only from the private network or authenticated through personal accounts; only the application is public. Replaces "Produktivsysteme sind nicht öffentlich erreichbar". (Mahyar, mail "AVV und Datenschutzerklärung Eviplex")
- 2026-11-04: The documents describe the end state and FOMF builds it; Habib hands them out only once everything is live, and Mahyar tells him when. (Habib asked, Mahyar confirmed; Teams 1:1 chat 3 Nov and mail "AVV und Datenschutzerklärung Eviplex")
- 2026-11-03: Preview and PR environments share the database instance but each has its own database for users and messages; that is enough separation, not to be flagged again. (Mahyar, session of 3 Nov)
- 2026-11-03: Database encryption in transit comes through TLS with a CA check (PR #1079), without forcing a change that would take prod down. (Mahyar, session of 3 Nov)
- 2026-11-03: Elastic, the FOMF GraphQL API and Datadog get only LLM-written search terms (2–8 words, no names), which are not personal data, so they are not subprocessors. FOMF stays in Anlage 2.2 as operator and host. (Mahyar, session of 3 Nov)
- 2026-11-03: Retool is no longer used for Eviplex (own admin at admin.meviq.com): its authorized networks on Cloud SQL and the "Meviq DB" resource are removed. (Mahyar, session of 3 Nov)
- 2026-11-03: Delete an old database export and a stopped database clone found in the review. (Mahyar, session of 3 Nov)
- 2026-11-03: Advise Habib not to sign or publish the AVV and the secrecy agreement until the gaps are closed. (Mahyar, review page `cybersecurity/reports/avv-pruefung-2026-11-03.html`)
- 2026-10-10: The user AVV is for doctors who book Plus or Pro; Anlage 2.2 lists only services that receive chat content that may hold personal (patient) data. (Habib, mail "WG: AVV und Datenschutzerklärung Eviplex")
