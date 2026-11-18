# On-Demand Accredited: commercial ownership

Since September 2026 Mahyar owns the commercials of the On-Demand Accredited product (CME-point-bearing on-demand courses, called "CME OnDemand" or "OnDemand akkreditierte Kurse" internally) for the Executive Board: pricing, packaging, positioning, go-to-market and marketing. This is not part of his CTO role; he acts as the product's commercial owner. The goal is to double its B2C revenue by Sep 2027. The folder was set up on 22 Sep 2026. Sister topic with the same mandate and shape: `../syfat/`.

## Status

**As of 15 Nov 2026:** The revenue baseline (workstream 1) is not done; nothing was logged here between 22 Sep and this catch-up. The brief of 22 Sep said the product had no owner, marketing or docs. Since 23 Oct a Notion project page names Isgard Eyberg as project lead and Tina Hoffmann as marketing, with a roadmap and a marketing overview; Isgard shared it in the medical team meeting chat on 5 Nov.

- **Next step:** to confirm with Mahyar. Proposed, not confirmed by Mahyar: produce the last-12-months baseline and agree with Isgard how her project page and this mandate fit together.
- **Next date:** none recorded.
- **Waiting on:** nobody recorded.

## Goal

Double On-Demand Accredited revenue in the 12 months from Sep 2026, so by Sep 2027. Revenue = membership fees attributed to accredited-led members plus stand-alone on-demand course sales, B2C only (B2B is out of scope). The Sep 2027 target is 2× the last-12-months baseline on that definition; the baseline is the first deliverable. The mandate probably includes the content roadmap (new courses, specialties); the medical team produces and owns the content. On 13 Oct the EB also made Mahyar responsible for the marketing of the OnDemand accredited courses from the business-owner side, with the marketing team supporting mainly in newsletter and print.

## People

| Who | Role here |
|---|---|
| Mahyar | Commercial owner: decides on budget and priorities, owns marketing from the business-owner side (EB, 13 Oct) |
| Isgard Eyberg (eyberg@fomf.org) | Project lead (Projektleitung) on the Notion page "OnDemand akkreditierte Kurse", created 23 Oct |
| Tina Hoffmann (hoffmann@fomf.org) | Head of marketing; marketing on the Notion page |
| Daniela König (koenig@fomf.org) | SEO; works with the agency Claneo. Asked on 5 Oct for an SEO analysis of the CME OnDemand pages |
| Marie Fiebig | Checks SYFAT and On-Demand content regularly with Isgard and reports issues (Mahyar, 3 Nov) |
| Habib | CGO. Sent the EB's marketing priorities on 13 Oct |
| Wafa | Co-founder; runs the medical team meeting where SYFAT and On-Demand are discussed |
| Erfan | CFO. The baseline is to be aligned with his accounting view |
| Medical team | Owns and produces the content |

## Open points

- The last-12-months baseline number does not exist yet, and whether Erfan's accounting view matches is open. (owner: Mahyar)
- Which table records stand-alone on-demand course purchases is unknown. The daily "Anmeldestand" booking report shows OnDemand rows at 0, which fits enrolments not creating booking rows. (owner: Mahyar)
- How Isgard's project lead role relates to Mahyar's commercial ownership is not recorded. (owner: Mahyar)
- Full catalogue beyond the 8 DE/AT courses: the Notion page lists 2 CH courses and planned ones; `dim_contents` with brand `ONDEMAND_ACCREDITED` will show the rest. (owner: Mahyar)
- Who in the medical team is the on-demand content contact (possibly Isgard, not confirmed). (owner: Mahyar)
- Whether the EB confirmed the €50k marketing budget and who approves individual spends. (owner: Mahyar)
- The marketing-performance dashboard Mahyar said he was building (EB update, 26 Oct) is not in this folder or the Artifact Index. (owner: Mahyar)
- Membership price: fomf.de showed "from €670" on 22 Sep; the Notion page lists All Access Online 50 at €670 a year or CHF 990. The SYFAT pages showed "from €580" on the same day. Which price applies to which buyer is not settled. (owner: Mahyar)

## Rules

- Read the workspace guide `../../AGENTS.md` first (company context, language rules, data-sensitivity rules, preapproved read-only access).
- Keep this mandate separate from Platform and Eviplex engineering work in comms and docs.
- Keep analyses comparable with `../syfat/` and reuse SQL across the two folders where it makes sense.
- Lead every reply with the finding and the numbers in a small table, then one caveat. Mahyar uses these directly in EB slides.
- Short instructions ("simplify", "take this out", "add X"): do exactly that, nothing extra.
- Language: English for internal working docs, SQL and analysis in this folder. German for anything customer-facing (landing pages, newsletters, ads), for Executive Board communications and for marketing, sales and medical colleagues. Ask when the audience is unclear.
- Ask before changing an agreed definition, adding a data source outside `fomf-dl`, publishing anything customer-facing, writing to HubSpot, Notion, Linear or Slack, or pasting financials or member-level data into an external tool.
- Pricing decisions, contract terms and revenue figures are financials: never paste them into external tools without explicit approval. The €50k marketing budget is an internal figure.
- Per-member extracts carry no identifiers; financial and member-level figures stay in `fomf-dl`, this folder and private artifacts.
- Price tests only with Mahyar's sign-off.

## Source map

| Where | What to search or open |
|---|---|
| Outlook | Search `"OnDemand akkreditiert"`, `"CME OnDemand"`, `"On-Demand"`. Threads: "Prioritäten in der Vermarktung" (Habib, 13 Oct; Tina's reply, 14 Oct), "Finale Freigabe neue Fachgebiete-Seite" (Daniela König, SEO), "Vorbereitung für Teamevent / Infos zum Programm" (Vanessa Schützl, 7 Oct). Senders: eyberg@, hoffmann@, koenig@. `akkreditiert` alone mostly finds event accreditation and staff badge messages. |
| Teams | Search `"On-Demand" OR OnDemand OR "CME OnDemand"`. The medical team's weekly meeting chat (Wafa's meeting; Isgard posts there); Mahyar's 1:1 chat with Isgard; Mahyar's weekly update to the group chat with Habib, Wafa and Erfan (26 Oct). |
| Slack | Not searched yet. |
| SharePoint | Not searched yet. |
| Notion | Isgard's project page "OnDemand akkreditierte Kurse" (https://app.notion.com/p/fomf/OnDemand-akkreditierte-Kurse-4027afedf3098099b06cc3a0fb9b8c72), with the "Roadmap OnDemand akkreditierte Kurse" database, "Statistik Zielgruppe OnDemand Kurse", "Marketing - OnDemand akkreditierte Kurse" (two databases, one a marketing roadmap) and "OnDemand – akkreditierte Kurse & wichtige Informationen". |
| Linear | Board issue CTO-5 (private team cto-assistant). none |
| Other | BigQuery `fomf-dl` and Metabase https://fomf2.metabaseapp.com (dashboard "B2C Membership Income", 1816). fomf.de product page `/on-demand` and catalogue `/kurse`. HubSpot: not searched yet. |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
| `sql/`, `data/`, `comms/` | Empty so far (placeholders only) |

Conventions: `sql/` holds extracts and checks with fully qualified `fomf-dl` tables. `data/` holds extracts without identifiers, each stating its extraction date. `comms/` holds drafts: EB updates (DE), marketing briefs (DE), team notes (EN). A `docs/definitions.md` (revenue definition, baseline, segments) is to be added once agreed.

## The product

What On-Demand Accredited is, catalogue, prices, packaging, data model, audience: `../knowledge/products/on-demand-accredited.md`. B2C numbers and definitions: `../knowledge/b2c-members.md`. Where the data lives: `../knowledge/data.md`.

## Isgard's Notion project page (read 15 Nov 2026)

Page "OnDemand akkreditierte Kurse", dated 23 Oct 2026, last edited 12 Nov 2026, German. What it adds beyond fomf.de:

- **Status:** DE and AT 8 courses online: Refresher AM, IM, Allgemeine Innere Medizin, Psychiatrie and Pädiatrie; Studien- und Kongressupdate Gynäkologie; Highlights Pädiatrie and Psychiatrie. CH 2 courses online: Pädiatrie in German and French. Highlights AM and IM are being renewed; Studien- und Kongressupdate Kardiologie planned; CH Allgemeine Innere Medizin submitted for accreditation, IM and Médecine Interne Générale planned; a Refresher Gynäkologie is to be built.
- **Done:** switch to All Access Online and new pricing 09/2026; marketing started (Google Ads, social, newsletter, direct mail); a cross-department workshop held 10/2026.
- **Next:** extend the 2027 offering and update content; a new product name to set it apart from recordings and livestreams; marketing and SEO; link live and on-demand courses; explainer video and Eviplex integration; an app with offline use and notifications; sponsoring (symposia, sponsored short videos); retention.
- **Target group:** primary = specialists in the offered fields, doctors in private practice and GPs, doctors with regular CME needs. Secondary = hospital doctors with little time, returners, doctors refreshing knowledge, clinics and practices that offer flexible training to staff.
- **Marketing so far (2026):** Google Search Ads in DE, AT and CH since Jul 2026; social posts and pushes; newsletters in DE and AT in February and one on the AIM Refresher in July; print ad in CME-Magazin Deutschland (Apr 2026); direct mail in Aug 2026 to GPs and internists in private practice in Niedersachsen, Hamburg, Sachsen, Schleswig-Holstein and Bremen.
- **Marketing planned 2026/2027:** new product name, Google Ads keyword and conversion work, more social content, an explainer video, landing page and SEO, regular newsletters, a second direct mail and ads in specialist media, cross-selling with live courses and All Access, presence at FOMF live courses and events, Eviplex link, retention, better tracking, and using the planned budget more fully.
- **Pricing (as of Oct 2026):** All Access Online 50 €670 a year (DE/AT), CHF 990 (CH). Single prices for the Refreshers and the Gyn update as on fomf.de (higher tier); Highlights are included in All Access only; CH is sold only through All Access.

## Workstreams (the commercial funnel, in order)

1. **Baseline:** last-12-months B2C revenue on the agreed definition: (a) first-year and renewal fees of accredited-led members (reuse the intent logic from `../../archive/b2c-value-journey/sql/`), (b) stand-alone on-demand course orders (find the order table; check `platform_raw_membershipservice.*`, `analysis.fct_course_bookings` and the content-order tables). Then the Sep 2027 target = 2× that. Confirm the number with Mahyar; align with Erfan on the accounting view.
2. **Pricing and packaging:** the single course priced just under the membership; options: reposition the single course (e.g. a clear CME-per-euro story), an on-demand-only membership tier, bundles per specialty, CME-deadline offers.
3. **Content roadmap:** which specialties next (Refresher live courses that exist without an on-demand edition; specialty populations in `dim_users`), yearly edition cadence, Highlights vs. full Refresher mix. With the medical team, which owns production; Isgard's Notion roadmap is the starting point.
4. **Audience and positioning:** doctors who need CME points but do not attend live courses; specialty, career stage and country cuts; CME-deadline seasonality (year-end point pressure; Austrian and Swiss rules).
5. **Channels and marketing:** owned first (fomf.de, newsletter, in-platform cross-sell from Refresher recordings and the Mediathek to accredited courses), then paid and partnerships, referral. About €50k budget; plan spend by quarter and expected buyers per channel. Mahyar decides; Tina is the marketing contact on Isgard's page.
6. **Measurement:** a small recurring Metabase dashboard: revenue by source (membership-attributed vs. stand-alone), new buyers, course starts, completion and certificates; monthly review against the doubling path.
