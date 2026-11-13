# Signals

Mahyar's log of **signals**: posts, articles, talks, conversations and his own thoughts that change how product and tech work in the age of AI. Started 12 Nov 2026. Owner: Mahyar.

The log serves two uses:

1. **Reflection** on his own work as CTO, Eviplex PM and business owner.
2. **Growth** of the people he leads: his six direct reports, their teams, and the Product & Engineering department as a whole.

Each signal is read through three **lenses**:

- `me`: how Mahyar works, decides and spends his time
- `leads`: what one or more direct reports (Vahid, George, Simone, Viktor, Rahim, Andreas) could take from it
- `department`: what it means for roles, rituals, tooling or skills across Product & Engineering (and IT where relevant)

## Files

| Path | What |
|---|---|
| `inbox.md` | Quick capture: one line per signal, processed later |
| `entries/YYYY-MM-DD-<slug>.md` | One file per processed signal, dated by capture |
| `themes.md` | Running synthesis per theme: current stance, open questions, moves. Single source of truth for "what do I think about X now" |
| `reflections/YYYY-MM.md` | Monthly reflection |

## Capture

When Mahyar shares a link, a pasted post or a thought:

1. If he says "inbox", add one line to `inbox.md`: date, link or short description, his comment if any.
2. Otherwise write an entry from the template below. Read the source when it is public (use the web-fetch agent; LinkedIn posts load without login); a pasted text is the source as given. Keep his own words for his take; a bare link gets open questions in My take for him to answer.
3. Add the entry under its theme(s) in `themes.md` (link + one line). Add a new theme only when no existing one fits.

An entry is done when every template field is filled or marked `—`, and the "Who could use this" line names people or teams, not "everyone".

### Entry template

```markdown
# <Title in Mahyar's words>

- **Source:** <author, outlet, link, date published>
- **Type:** post | article | talk | podcast | paper | conversation | own thought
- **Captured:** YYYY-MM-DD
- **Lenses:** me / leads / department
- **Themes:** <from themes.md>
- **Status:** captured | reflected | acted | shared

## Gist
<2–4 lines: the core claim>

## My take
<Mahyar's view: agree, disagree, what's missing. Leave a question here if he gave none.>

## For FOMF
<What it means for us: Platform, Eviplex, Productivity, IT, or the way we run product.>

## Who could use this
<Named people or teams, and why. E.g. "Simone: Retool-to-agent shift for Productivity team">

## Possible move
<One concrete step: an experiment, a 1:1 topic, a ritual change, a share in Slack.>
```

## Monthly reflection

When Mahyar asks for a reflection (or at the start of a month), write `reflections/YYYY-MM.md` from the entries and inbox of that month:

- **What kept coming up:** the 2–3 themes with the most signal, with links to entries
- **Me:** what I changed in my own work; what I keep reading about but haven't acted on
- **Leads:** per direct report, one growth nudge or 1:1 topic, only where a signal supports it
- **Department:** at most one thing to share or try with the whole department
- **Open questions:** carried to next month

Then update `themes.md` stances and set entry statuses (`reflected`, `acted`, `shared`).

## Rules

- **English**, since the audience is Product & Engineering. Quote sources in their original language.
- **Sourced facts only** in Gist and For FOMF; Mahyar's opinions go in My take, Claude's suggestions in Possible move.
- Notes about people are growth notes for 1:1s, not performance assessments. Keep them short and kind.
- FOMF-internal details (financials, security findings, unreleased EB strategy) stay in this folder. Shared drafts for Slack or Notion strip them.
