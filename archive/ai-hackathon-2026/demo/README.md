# Demo: Sponsor-Briefing

Workstream 1. The storyline, minute-by-minute script, final prompts and findings live in the shared doc, tab "Demo run sheet". This folder holds the files the demo runs on.

| Path | What |
|---|---|
| `backup/level1-sponsor-briefing-gsk.docx` | Level 1 output for GSK DE from the 17 Oct dry run. Open it if the live run is slow or fails. |
| `backup/make_briefing.py` | Rebuilt the 17 Oct version of that file (`python-docx`). Numbers are hard-coded from the dry run; the current file was regenerated on 20 Oct. |
| `backup/level2-sponsor-briefing-gsk.docx` | Level 2 output (skill run), backup for the live demo. |
| `skill/build_template.py` | Builds `assets/fomf-vorlage.docx`, the FOMF Word template the skill uses. |
| `skill/sponsor-briefing/` | Level 2 skill: `SKILL.md`, `references/datenquellen.md` (HubSpot stage IDs, Metabase SQL), `references/format-katalog.md` (formats from the 2026 brochure, no prices). Zip the folder to upload it to Claude. |

Never made: level 3 backup output, screen recording. The hackathon took place on 20 Oct 2026.

## Dry-run data (17 Oct 2026, GSK DE)

- HubSpot company `GlaxoSmithKline GmbH & Co. KG` (id 10052266951), owner Alexander Bielau. 38 deals created in 12 months; 16 meetings with notes in `hs_meeting_body`.
- Metabase: 21 sponsored lectures in DE, 2,184 livestream views, 1,821 unique doctors. Best: Kardiologie WebUp 03.09.2026 (268). Hämato/Onko on site: 31–59.
- Upcoming sponsor meetings in HubSpot for 20–23 Oct: Lilly Neuro (Paola), Otsuka (Marc), Roche (Paola), Lilly Gastro (Esra), untitled (Alexander).
- Your Outlook calendar 26–30 Oct: no sponsor meetings.
