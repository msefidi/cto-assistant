# TMN press coverage and Eviplex traffic

The Medical Network (TMN) is FOMF's press agency, working mostly for Eviplex. Mahyar wants to know whether TMN's publications move Eviplex traffic and, if they do, to show it in a chart. Eviplex is the test case because fomf.de traffic is too large for a press effect to show. Topic opened 19 Nov 2026.

## Status

**As of 19 Nov 2026:** Not started. TMN's clipping list holds 35 publications from 26 Jun to 12 Nov 2026 (date, medium, title, link, reach, advertising equivalent value). The traffic source is not chosen yet.

- **Next step:** Mahyar and Claude choose the traffic source, pull daily Eviplex traffic and sign-ups from June 2026, and compare them with the publication dates.
- **Next date:** none
- **Waiting on:** nobody

## Goal

A clear answer, per publication or per wave: did Eviplex traffic or sign-ups move? If yes, a chart of daily traffic with the publication dates marked that Mahyar can show to the EB or to TMN. If no, say so.

## People

| Who | Role here |
|---|---|
| Mahyar | Asked the question; Eviplex PM |
| Markus Igel (TMN) | Owns the clipping list |
| Arne Bendixen (TMN) | Mahyar's contact at TMN on Eviplex |

## Open points

- Traffic source: Mixpanel (Eviplex product analytics; the claude.ai Mixpanel connector needs authorisation), website analytics of the Eviplex marketing site, or sign-ups and first questions in the meviq database (`meviq-prod`). (owner: Mahyar)
- Many clippings are print or newsletter and have no link; online pieces with a link may show up as referrers. Check whether referrer data exists. (owner: Claude, during the analysis)
- Overlapping causes: the Eviplex launch (29 Sep–1 Oct 2026), the FOMF Medical Circle (30 Sep 2026), app store and campaign activity. Mark them on the chart. (owner: Claude)

## Rules

- Traffic and sign-up figures stay in the repo and the analysis page; no user-level data leaves FOMF systems.
- A finding comes first in a small table with one caveat (see the analysis-pages style).

## Source map

| Where | What to search or open |
|---|---|
| Outlook | Sender domain `themedicalnetwork.de` (Arne Bendixen, Markus Igel); search `Medical Network`, `Clipping` |
| Teams | Search `TMN`, `Medical Network`, `Presse` |
| Slack | none |
| SharePoint | none yet |
| Notion | Meviq workspace, 03 - Marketing (press and campaign plans), not checked yet |
| Linear | Board issue CTO-28 (private team cto-assistant); no product project |
| Other | TMN clipping list (Google Sheet, owner Markus Igel, read via the Google Drive connector): https://docs.google.com/spreadsheets/d/19_rajBWQmNg44-lFQh1bLkblt98M9UJRlnmrKSJ889s/edit?gid=0#gid=0; Mixpanel; GCP `meviq-prod` |

## Files

| File | What |
|---|---|
| `docs/decisions.md` | Every decision, one line each, newest first |
| `docs/log.md` | Dated record of events and results, newest first |
