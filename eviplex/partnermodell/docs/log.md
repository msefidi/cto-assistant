# Eviplex Partnermodell: log

Newest first. One entry per event or result. Decisions go in `decisions.md`, one line each. Each entry ends with who said it and where, in brackets. Summarise the source; the original stays where it is.

## 2026-11-15: folder set up in the initiative shape

Brief rewritten into the template, decisions and log written from the memory note `eviplex-medichub-partner-contract`, the local files and a search of Outlook, Teams and Linear. Nothing newer than 12 Nov was found in Outlook or Teams. No Linear project exists; attribution sits in issues EVP-1348 and EVP-1312. Slack was not searched. (session with Mahyar)

## 2026-11-13: draft not yet with counsel

Mahyar confirmed that draft v0.1 and the cover letter have not been sent to Risch-Kerst. (Mahyar, session of 13 Nov)

## 2026-11-12: contract draft v0.1 delivered

A drafting agent produced three files in `vertrag/`: the master contract (29 pages, §§ 1–18 and Anlagen 1, 1a Medichub, 1b Webop, 2, 3), the drafting notes and a two-page cover letter to Risch-Kerst with eight questions. Placeholders carry IDs that match the notes: 44 business points (K01–K44), 16 counsel points (P01–P16), 3 simulation options (O1–O3) and 4 placeholders in the letter. While drafting it found that the trademark "Eviplex" may belong to FOMF (K12) and that individual FOMF members registering via a partner link are commissionable unless they buy a FOMF bundle (E12). Nothing was sent. (drafting session of 12 Nov, late evening; `vertrag/Entwurfsnotizen v0.1.md`)

## 2026-11-12: contract step prepared

Mahyar chose to go from concept to contract. The concept was frozen in `konzept-stand-2026-11-12.md` and a handoff prompt for the drafting agent written in `handoff-vertragsentwurf.md`. The two drafting skills were adapted into `.claude/skills/` with FOMF defaults (German law and language, Eviplex GmbH, counsel review). (Mahyar, session of 12 Nov evening)

## 2026-11-12: one-pager sent to Wafa

Mahyar sent Wafa the Word one-pager "Eviplex Partnermodell - Kurzfassung" on the Medichub thread, Habib and Sina in copy. The mail summed up the model (15–20 % / 10 %, introduction 5–10 %, Eviplex GmbH contracts and collects, partner pays its marketing, no exclusivity, Romania €14.90 with 75 questions, Webop via partner link and Stripe) and named the open points: FOMF-existing hospitals for Webop and counsel review. He asked Wafa for a short call before anyone answers Medichub and Webop. The introduction rate changed to 7.5 % later that evening and the Word file was updated. (Mahyar, mail "Re: UTM Parameters Eviplex 4 Medichub", 12 Nov 16:01)

## 2026-11-12: simulation of the model

A 24-month simulation (60 % usage, 4 % monthly churn, Stripe 1.5 % + €0.25) went into the tab "Simulation" of the concept doc; the script was not kept. Webop works on both paths: on webop.de Eviplex keeps about €12.5k on 40 paying users, a 100-user hospital about €46k. Romania is fragile: Eviplex alone bears the cost of free users, so at 2 % conversion it loses money while Medichub still earns, about €31 per paying doctor. It found three gaps, now options O1–O3: the RO price is reachable by DACH doctors, the clock restarts when a subscriber moves to a hospital seat, and Stripe Connect must split on net. (session of 12 Nov)

## 2026-11-12: review of the concept

A review (Codex thread "Review Medichub Partnership Contract") was applied as Mahyar directed; its decisions are in `decisions.md`. With the Plus quota at 150 there is no negative tier; the tightest cases at full use are clinic Pro tier 2 (€39 per user and year left) and Romania (€2.35 per doctor and month left). At net, Medichub earns €2.46 per doctor and month in year 1 at 20 % and €1.23 in year 2. Attribution and counsel review were listed as open points. (Mahyar, session of 12 Nov)

## 2026-11-12: concept doc, first Romania-only then generic

The Claude Doc started as "Eviplex Partnervertrag – Eckpunkte (Rumänien / Medichub)", a German one-pager for Wafa and Habib, and became "Eviplex Partnermodell – Eckpunkte für Partnerverträge" when Mahyar asked for a model that also covers Webop. Hospital prices per user and year from the sales list: Plus €399 standalone, €299 from 250 users or bundled with FOMF Klinik, €249 bundled from 250 or full GMS (150 questions); Pro €699 / €499 (300 questions, patient-related research). The sheet assumes €0.10 per question and 60 % usage, lists €99 a year for existing FOMF customers, and notes (2 Sep 2026) that the EB still has to decide the price. Claude's recommendation that day (referral partner, not reseller; Eviplex GmbH contracts; 20 % / 10 % on collected net revenue; partner pays its marketing; non-exclusive) largely became the model. (Mahyar, session of 12 Nov; SharePoint price list)

## 2026-11-12: attribution checked in the code

In the meviq repo, paid plans are Stripe subscriptions only, with no in-app purchase. UTM parameters are read at registration and sent to Segment only with analytics consent; they are not stored on the account. So there is no billing-grade partner attribution yet. EVP-1310 (save UTM values at sign-up) was canceled and EVP-1348 (store partner attribution on the account for commission payouts) created in Backlog the same day. (session of 12 Nov; Linear)

## 2026-11-12: Romanian price not on record

Mahyar recalled a lower Romanian price with a lower quota agreed with the partners than the €13 / 60–80 questions in the August notes. No written record was found in Notion, mail or Teams; the 25 Sep follow-up has no notes. (Mahyar, session of 12 Nov)

## 2026-11-12: Medichub chases, Habib steps back

Ionut Stroea wrote that the campaign is ready and asked again for: a reviewer and feedback date, the vector "Powered by FOMF" logo, OK to use the Eviplex symbol alone, who validates the Romanian disclaimer, written confirmation of the zero-data-retention wording, the utm_content value for print, who pays Meta Ads, and a webinar date with an Eviplex demo. Habib forwarded it to Mahyar and Wafa: he has no capacity for the Romanian requests. (Ionut Stroea and Habib Modabber, mail "WG: UTM Parameters Eviplex 4 Medichub", 12 Nov)

## 2026-11-06: general model requested; attribution in the weekly plan

Wafa wrote in Teams that FOMF needs a general contract set-up with partners, Romania and others. Mahyar answered the mail that he would think about it over the weekend. The Eviplex plan for 9–13 Nov gave Viktor "Build the attribution funnel for partner activities (Romania)" (EVP-1312). (Wafa, Teams group chat with Habib; Mahyar, mail "Re: UTM Parameters Eviplex 4 Medichub"; Mahyar, Eviplex weekly meeting chat)

## 2026-11-05: Wafa asks for a partner contract

Cristina Marin reported the full Romanian campaign ready (banners, landing page, header button, newsletters, social, webinar and event material, print ads) and sent a long list of questions on brand, product, legal, tracking, referral incentives and costs. Wafa forwarded it to Mahyar, Habib and Sina: FOMF needs a real partner contract with the Romanian company, and she asked what share of revenue per paid Eviplex subscription can be promised and how the cooperation could look. (Cristina Marin and Wafa Enayati, mail "Fw: UTM Parameters Eviplex 4 Medichub")

## 2026-10-30: UTM links for Medichub

On Ionut's request of 28 Oct, Habib sent the tracking scheme from the product team: base link with `utm_source=medichub`, `utm_medium=referral`, `utm_campaign=ro-partner-launch-2026` and a fixed list of `utm_content` values per placement. On 26 Oct Habib had shared the SharePoint folder "Eviplex" with marketing assets with Medichub. (Habib Modabber, mail "UTM Parameters Eviplex 4 Medichub"; Parham Fallah, thread "Habib Modabber hat den Ordner "Eviplex" mit Ihnen geteilt")

## 2026-10-26: Webop needs a business concept

Mahyar told Wafa, Habib, Sina and Erfan that Guido's document only summarises Stripe Connect, which FOMF has used for SGMO for two years. For a cooperation with Webop a business concept is needed first. (Mahyar, mail "Re: Stripe Connect Infos für Einbindung Eviplex auf webop.de")

## 2026-10-21: Webop introduces Eviplex to a Swiss hospital

Guido Gruhn introduced Eviplex to the Solothurner Spitäler, citing revDSG and ISO 27001; Markus Fischer replied. Wafa forwarded the exchange; Ute Schellerer was in the loop. (Wafa Enayati and Ute Schellerer, mail "Vorstellung Eviplex (klinische Wissensrecherche) der FOMF", 21–22 Oct)

## 2026-10-14: Webop proposes embedding Eviplex

After a call with Wafa, Guido Gruhn proposed embedding Eviplex on webop.de and splitting each payment between Webop and FOMF through Stripe Connect, which runs Webop's online payments. Wafa forwarded it to Mahyar, Habib, Sina and Erfan. Webop GmbH is a FOMF content partner since 2025 under its own cooperation contract on surgery videos, billed per member with access, and has strong hospital contacts. (Guido Gruhn and Wafa Enayati, mail "Stripe Connect Infos für Einbindung Eviplex auf webop.de")

## 2026-08-21: first talk with the Romanian partners

The Executive Board met Ileana (Mediamed) and Simona Melnic (Medichub). The notes give a partner commission of 15–20 % of revenue in year 1 and 5–10 % from year 2, a Romanian "light" tier idea at about €13 a month capped at 60–80 questions, and a token cost of about €0.06 per question. DACH list prices then: Plus €39.99 a month or €459.99 a year, Pro €72.99 a month or €859.99 a year. (Notion, Executive Board › Documents › Eviplex › "Eviplex Romenia")
