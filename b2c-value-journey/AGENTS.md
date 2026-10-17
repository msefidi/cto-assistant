# B2C Value Journey

Sub-project of the CTO assistant workspace. Read the parent `AGENTS.md` / `CLAUDE.md` first (company context, language rules, data-sensitivity rules, preapproved read-only access). This file is the entry point; details live in `docs/`.

## What this is

Mahyar (CTO) is preparing slides for the **Executive Board strategy meeting, week of 21 Sep 2026**, on platform revenue and potential. The artefact is one **interactive dashboard** (a live Claude artifact) about monthly cohorts of new B2C members of the learning platform, Aug 2024 – Aug 2026, built **step by step**: he adds one topic at a time and removes anything that does not earn its place.

- **Live artifact:** https://claude.ai/artifact/7pArL6gezoZBfekf436j6a — private, title "B2C Value Journey". Republish `dashboard.html` from this path to keep the URL; from a new conversation pass the URL as `url`. Never create a second copy.
- **Current page (v26, 21 Sep 2026):** two views behind an Overview / Cohort switch in the header. **Overview** = new members per cohort → acquisition shares over time (six small multiples, seven-class intent: Refresher / Webinar / On-demand accredited / SYFAT / On-demand / Mixed / Unknown) → revenue (one section, v26: stacked bars of membership fees per cohort by the intent class that brought the member in, Year-1 fees / All payments to date switch; plus the ranking of career stage × specialty / country / intent groups by value paid in years 1 + 2 and year-1 renewal) → behaviour over time (small multiples, 30 d / 90 d / 12 m switch) → product reach over time (five small multiples, same switch) → year-1 renewal and active today by cohort → where the membership is strongest (specialty × career stage heatmap, metric switch share / active months / year-1 renewal, all cohorts or last 12, optional Germany · Switzerland · Austria split) → who uses the membership most (ranking of the same profile groups by active months of 12; the Group-by switch is shared with the value ranking in the Revenue section; v25/v26). (Trends card removed in v18; parked in `archive/`, returns as board Q&A.) **Cohort** = one of the 25 cohorts Aug 2024 – Aug 2026 (the 12 cohorts from Sep 2025 on have no renewal data yet; they are there for acquisition and activation): sticky bar with cohort selector (‹ › buttons, arrow keys; the country / type / first-time filter chips were removed in v24) → tiles (members, age, renewal data available) → status today → renewal checkpoints → acquisition / likely intent → revenue and the product that brought it in (tiles paid to date · year 1 · year 2 · year 3+, table intent class × membership year, hint with ticket cash and credit value) → first 30 days / 90 days / 12 months matrix (Inactive / Low-Episodic / Live-only / Digital-only / Hybrid, Mahyar's definition; one window at a time behind a 30 d / 90 d / 12 m switch since v22) → product reach matrix (non-exclusive, five product families, same window switch) → active month by month (line chart M1–M12, cohort vs all cohorts, Any / Live / Video switch) → renewal by 12-month behaviour (table, year-1 rate + share automatic) → where each acquisition class ends up (12-month behaviour bar + year-1 renewal per intent class) → definitions. Exact contents in `docs/dashboard.md`.
- **Companion Metabase dashboard:** "B2C Membership Income" (1816). Its member-count and revenue definitions are agreed with Mahyar; do not contradict them (`../b2c-income-dashboard/sql/`). The page's revenue section (v23) uses the same basis; see `docs/definitions.md`, Money.

## Read these before changing anything

| Document | What it answers |
|---|---|
| `docs/definitions.md` | Cohort, planned expiry, active/renewed, likely intent, money. Agreed with Mahyar; change only with him. Also the parked channel-label rules. |
| `docs/data-pipeline.md` | How to query (bq, or `tools/mbq.sh` via Metabase when gcloud auth is expired), how to regenerate and embed the data, tables, gotchas, file inventory. |
| `docs/dashboard.md` | Page structure, script layout, the embedded row contract, how to add a section, design rules, how to preview and publish. |
| `docs/log.md` | Decision log with dates, every result so far, open threads. Read it to know what he already saw and what he removed. |

## Start-of-session checklist

1. `cat docs/log.md | head -60` for the latest state; confirm the live artifact is v26 (`Artifact` read of the URL if unsure).
2. Data date on the page is **21 Sep 2026** (`AS_OF` and `AS_OF_LABEL` in the script; every visible date reads from them). Re-extract with `tools/fetch_members.sh` only when a fresh date is wanted or the SQL changed (about 12 minutes since v23), then `python3 tools/embed.py` and republish.
3. Check `../.env` has `METABASE_API_KEY` if `gcloud auth` is expired (`tools/mbq.sh "SELECT 1"` is the smoke test).

## How to work with Mahyar on this

- He asks in short instructions ("simplify", "take this part out", "add a section for X"). Do exactly that, nothing extra; one topic per step. When he pastes a mock of the shape he wants (labels + percentages), match it literally.
- Lead every reply with the finding and the numbers in a small table. Then one caveat. He uses these directly in slides.
- Ask before changing an agreed definition, adding a data source outside `fomf-dl`, or publishing beyond the existing artifact URL. Do not ask before reversible page edits.
- Per-member data carries no identifiers; financial and member-level figures stay in `fomf-dl`, this folder and the private artifact.
- When a number looks surprising, check it against the membership-service semantics first (renewals create their own order rows; expiry fields are unreliable) and state the check.

## Folder

```
AGENTS.md / CLAUDE.md      this entry point (CLAUDE.md points here)
dashboard.html             the artifact (self-contained, data embedded)
docs/                      definitions · data-pipeline · dashboard · log
sql/                       extracts (current: cohort_member_rows_all_months.sql; checks: cohort_status_all_months.sql, check_behaviour_windows.sql, check_on_demand_watch_depth.sql)
data/                      raw and compact extracts, no identifiers
tools/                     mbq.sh (SQL via Metabase) · fetch_members.sh (re-extract + compact) · embed.py (embed into the page)
archive/                   dashboard_v3_acquisition.html (parked channel-label page) · trends_bullets_v17.js (parked trends card)
```
