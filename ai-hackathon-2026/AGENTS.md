# AI Hackathon 2026

Mahyar runs the AI Hackathon on **Tue 20.10.2026** at the FOMF DACH Teamtreffen (Krainerhütte, Baden bei Wien, 19.–22.10.). Goal: a fun day that pushes every department to use AI in its daily work. About 70 colleagues in 12 department teams each build an AI helper for a real recurring task. Finalists demo at the **Hackathon Honoring, Wed 21.10, 14:30–14:45**.

- **Shared plan (source of truth):** Claude Doc "AI Hackathon 2026" — https://claude.ai/code/artifact/e0c1566b-9ab9-496c-bf1b-859fb497010c. Read it via the Claude Docs connector before working on a task; write plan changes back there, not only here.
- **Program:** `source/programm-teamevent-2026.pdf` (agenda p. 7 for Tuesday, attendee list p. 2–3).
- **Teams:** `data/teams.csv` (team, person, role). Buddy candidates: `data/buddies.csv`.
- **Decision log:** `docs/log.md` — append one line per decision, newest first.

## Decisions so far (17 Oct 2026)

- **Department teams + AI buddies.** 12 teams by unit. Only a few tech colleagues are hands-on, so buddies float across 2–3 teams; daily Claude users in each department act as in-team champions.
- **Build starts in the morning.** 10:00–11:00 kick-off + training, then 11:15 pick & scope, Sprint 1 to 12:15, Sprint 2 13:30–14:45, wrap-up and submission until 15:15. 2h45 of build time.
- **Task:** "Pick one real, recurring task from your team's week that costs time or nerves. Build an AI helper that does it and show it working live." Canvas = which task · which output · which level.
- **Ladder (how it runs):** 1 Ask (one-off) → 2 Tool (Skill / Project / artifact, reusable) → 3 Agent (Cowork + connectors, runs on its own). Outputs are any work product: Word, PowerPoint, Excel, Outlook drafts, Metabase dashboard, artifact mini-app.
- **Demo:** one 30-min storyline, "Sponsor-Briefing", climbs all three levels on one sponsoring-sales task (HubSpot deals + meetings, Metabase lecture performance → Word briefing → skill → Cowork every Monday). Moved from the B2B "Klinik-Briefing" because B2B barely uses HubSpot; data check in the shared doc. Level 2 must be visibly more than a saved prompt: FOMF knowledge built in, FOMF template, side by side with level 1, a sales colleague runs it live.
- **Jury:** Executive Board (to confirm).
- **Guardrails:** drafts only (no sending, no HubSpot writes), Metabase demo numbers are not validated, no patient or payment data.

## Environment

Non-tech colleagues use **Claude Enterprise** (compliance); tech uses a Claude Teams/Max org. Enabled in Enterprise: M365, HubSpot and Metabase connectors, Skills, Cowork (needs the desktop app). Known limit: the Metabase connector cannot save native SQL questions (see the Metabase REST API memory).

## Workstreams (one session each)

| # | Workstream | Output | Language |
|---|---|---|---|
| 1 | Demo dry run: pick the clinic, run all three levels with HubSpot + Metabase, save backup outputs | `demo/` | German prompts |
| 2 | IT readiness mail to Andreas: seats, desktop app, connector logins, Metabase access, Wi-Fi | `comms/` | German |
| 3 | Starter kits, one page per level (first prompt, example, pitfalls) | `materials/` | German |
| 4 | Team canvas template | `materials/` | German |
| 5 | Kick-off slides (why AI, guardrails, brief, judging) | `materials/` | German |
| 6 | Buddy + champion mapping per team | `data/teams.csv`, doc | — |
| 7 | Jury briefing for the EB + submission format + finalist selection | `comms/` | German |

Open questions live at the end of the shared doc.

## Conventions

- Everything participants see is **German** (company-wide audience). Working notes for Mahyar can be English.
- Demos on a projector: no patient data, and mask prices / B2B contract terms unless cleared.
- Create subfolders (`demo/`, `comms/`, `materials/`) when a workstream first needs them.
