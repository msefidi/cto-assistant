#!/usr/bin/env python3
"""Build the Topics overview page from TOPICS.md and the topic folders.

Reads `TOPICS.md`, each folder's `AGENTS.md`, `docs/log.md` and
`docs/decisions.md`, and the last git change per folder. Writes the data into
`topics-overview.src.html` and saves the result as `topics-overview.html`,
the file that is published.

Run from anywhere: python3 topics-overview/build.py (from the repo root)
"""

import datetime as dt
import json
import pathlib
import re
import subprocess

HERE = pathlib.Path(__file__).resolve().parent
ROOT = HERE.parent  # repo root
SRC = HERE / "topics-overview.src.html"
OUT = HERE / "topics-overview.html"

# Finished topics live in TOPICS-DONE.md and are left out: the page shows open topics only.
KIND_BY_SECTION = {
    "Active": "active",
    "Recurring": "recurring",
}

LOG_ENTRIES = 6
DECISIONS = 6
ACTIVITY_WEEKS = 12


def cells(line):
    return [c.strip() for c in line.strip().strip("|").split("|")]


def strip_ticks(s):
    return s.strip().strip("`").rstrip("/")


def parse_topics_md():
    topics, gaps = [], {}
    section = None
    for line in (ROOT / "TOPICS.md").read_text().splitlines():
        if line.startswith("## "):
            section = line[3:].strip()
            continue
        if not line.startswith("| `"):
            continue
        c = cells(line)
        folder = strip_ticks(c[0])
        if section == "Not yet in shape":
            gaps[folder] = c[1] if len(c) > 1 else ""
            continue
        kind = KIND_BY_SECTION.get(section)
        if not kind:
            continue
        # slug: folder without "/" (page anchors allow only letters, digits and hyphens)
        t = {"folder": folder, "slug": folder.replace("/", "-"), "kind": kind, "what": c[1] if len(c) > 1 else ""}
        if kind == "active":
            t["line_status"] = c[2] if len(c) > 2 else ""
            t["line_next"] = c[3] if len(c) > 3 else ""
        elif len(c) > 2:
            t["entry"] = c[2]
        topics.append(t)
    for t in topics:
        t["gap"] = gaps.get(t["folder"], "")
    return topics


def split_sections(text):
    """Return (title, intro, {heading: body}) for a markdown brief."""
    title, intro_lines, sections, current = "", [], {}, None
    for line in text.splitlines():
        if line.startswith("# ") and not title:
            title = line[2:].strip()
            continue
        if line.startswith("## "):
            current = line[3:].strip()
            sections[current] = []
            continue
        if current is None:
            intro_lines.append(line)
        else:
            sections[current].append(line)
    return title, "\n".join(intro_lines).strip(), {k: "\n".join(v).strip() for k, v in sections.items()}


def bullets(body):
    """Top-level '- ' items; continuation lines are joined to their item."""
    items = []
    for line in body.splitlines():
        if line.startswith("- "):
            items.append(line[2:].strip())
        elif items and line.startswith("  ") and line.strip():
            items[-1] += " " + line.strip()
    return items


def table_rows(body):
    rows = []
    for line in body.splitlines():
        if line.startswith("|") and not re.match(r"^\|\s*-", line):
            rows.append(cells(line))
    return rows[1:]  # drop header


def parse_status(body):
    out = {"as_of": "", "summary": "", "next_step": "", "next_date": "", "waiting_on": ""}
    m = re.search(r"\*\*As of ([^:*]+):\*\*\s*(.+)", body)
    if m:
        out["as_of"] = m.group(1).strip()
        out["summary"] = m.group(2).strip()
    for item in bullets(body):
        m = re.match(r"\*\*(Next step|Next date|Waiting on):\*\*\s*(.*)", item)
        if m:
            out[m.group(1).lower().replace(" ", "_")] = m.group(2).strip()
    return out


def to_iso(as_of):
    for fmt in ("%d %b %Y", "%d %B %Y"):
        try:
            return dt.datetime.strptime(as_of, fmt).date().isoformat()
        except ValueError:
            pass
    return ""


def parse_log(path):
    if not path.exists():
        return []
    entries, cur = [], None
    for line in path.read_text().splitlines():
        m = re.match(r"^## (\d{4}-\d{2}-\d{2}):?\s*(.*)", line)
        if m:
            cur = {"date": m.group(1), "title": m.group(2).strip(), "body": []}
            entries.append(cur)
        elif cur is not None:
            cur["body"].append(line)
    for e in entries:
        e["body"] = "\n".join(e["body"]).strip()
    return entries


def parse_decisions(path):
    if not path.exists():
        return []
    out = []
    for item in bullets(path.read_text()):
        m = re.match(r"(\d{4}-\d{2}-\d{2}):\s*(.*)", item)
        if m:
            out.append({"date": m.group(1), "text": m.group(2)})
    return out


def git_last_change(folder):
    try:
        r = subprocess.run(
            ["git", "log", "-1", "--format=%cs", "--", folder],
            cwd=ROOT, capture_output=True, text=True, check=True,
        )
        return r.stdout.strip()
    except subprocess.CalledProcessError:
        return ""


def first_paragraph(text):
    for para in re.split(r"\n\s*\n", text):
        para = para.strip()
        if para and not para.startswith(("#", "|", "-", ">")):
            return para
    return ""


def activity(dates, today):
    """Log entries per week for the last ACTIVITY_WEEKS weeks, oldest first."""
    weeks = [0] * ACTIVITY_WEEKS
    for d in dates:
        try:
            days = (today - dt.date.fromisoformat(d)).days
        except ValueError:
            continue
        w = days // 7
        if 0 <= w < ACTIVITY_WEEKS:
            weeks[ACTIVITY_WEEKS - 1 - w] += 1
    return weeks


def build():
    today = dt.date.today()
    topics = parse_topics_md()
    for t in topics:
        folder = ROOT / t["folder"]
        t["last_change"] = git_last_change(t["folder"])
        brief = folder / "AGENTS.md"
        t["has_brief"] = brief.exists()
        t["title"] = t["what"]
        if not brief.exists():
            continue
        title, intro, sec = split_sections(brief.read_text())
        if not title.startswith("<"):  # skip the template's placeholder
            t["title"] = title
            t["intro"] = first_paragraph(intro) or first_paragraph(sec.get("What this is", ""))
        if t["kind"] != "active":
            continue  # only active topics carry status, log and decisions
        status = parse_status(sec.get("Status", ""))
        status["as_of_iso"] = to_iso(status["as_of"])
        t["status"] = status
        t["goal"] = sec.get("Goal", "")
        t["people"] = [r[:2] for r in table_rows(sec.get("People", "")) if len(r) >= 2]
        t["open_points"] = bullets(sec.get("Open points", ""))
        t["rules"] = bullets(sec.get("Rules", ""))
        log = parse_log(folder / "docs" / "log.md")
        decisions = parse_decisions(folder / "docs" / "decisions.md")
        t["log_count"] = len(log)
        t["decision_count"] = len(decisions)
        t["log"] = log[:LOG_ENTRIES]
        t["decisions"] = decisions[:DECISIONS]
        t["last_log"] = log[0]["date"] if log else ""
        t["activity"] = activity([e["date"] for e in log] + [d["date"] for d in decisions], today)
    data = {"built": today.isoformat(), "weeks": ACTIVITY_WEEKS, "topics": topics}
    payload = json.dumps(data, ensure_ascii=False).replace("</", "<\\/")
    html = SRC.read_text().replace("__TOPICS_DATA__", payload)
    OUT.write_text(html)
    n = {k: sum(1 for t in topics if t["kind"] == k) for k in KIND_BY_SECTION.values()}
    print(f"Wrote {OUT} ({len(topics)} topics: {n})")


if __name__ == "__main__":
    build()
