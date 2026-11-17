# Topics overview

Builds the **CTO Topics** page on claude.ai: the open topics in `cto-assistant/TOPICS.md` (Active and Recurring), with each active topic's status, next step, recent log entries, decisions, open points and rules from its brief. Topics under "Done or reference" are left out. Workspace tooling, not a topic; started 17 Nov 2026. Owner: Mahyar.

- **Page:** https://claude.ai/artifact/8W7smjQh7rx3hjS8HCNhni (private)
- **Source of truth:** `TOPICS.md` and the topic folders. The page is a read-only view; never edit content in it.

## Rebuild and republish

1. `python3 cto-assistant/topics-overview/build.py` writes `topics-overview.html` (git-ignored) from `topics-overview.src.html`.
2. Publish `cto-assistant/topics-overview/topics-overview.html` with the Artifact tool, passing the page URL above as `url`.

Do this after a session that changes a Status or a line in `TOPICS.md`, or when Mahyar asks. The page shows its build date and turns it red after three days.

## What the page computes

- **Waits on you:** the brief's Next step says it is to be confirmed with (or not yet confirmed by) Mahyar, or Waiting on starts with "Mahyar", or the `TOPICS.md` next step starts with "To confirm with Mahyar".
- **Freshness:** days since the brief's "As of" date: up to 3 fresh, up to 7 aging, older is stale.
- **Activity:** log entries plus decisions per week over the last 12 weeks.
- **Last change** for other topics: the newest git commit touching the folder.

## Files

| File | What |
|---|---|
| `build.py` | Parses `TOPICS.md` and the briefs, writes the page |
| `topics-overview.src.html` | The page; `__TOPICS_DATA__` is replaced with the data |
| `topics-overview.html` | Built output, git-ignored, the file that is published |
