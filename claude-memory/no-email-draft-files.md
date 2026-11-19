---
name: no-email-draft-files
description: "Don't save email drafts as files in the repo; give the text in chat, the mail itself is the record"
metadata:
  node_type: memory
  type: feedback
  originSessionId: d8e16c20-4527-4905-884c-b265efb9a3f2
  modified: 2026-11-18T20:17:47.356Z
---

Don't write email drafts into repo files (e.g. `email-draft-*.md` in a topic folder). Give the draft text in the chat reply. Once Mahyar puts it in Outlook or sends it, the mail is the record, and the topic log summarises it.

**Why:** Mahyar asked on 18 Nov 2026 why a Google PSA email draft file was kept. The "repo keeps what rebuilds it" rule is meant for pages, SQL, scripts and decks, not for mails, and a draft file just goes stale next to Outlook.

**How to apply:** Mail drafts go in chat only. In the log, write that a draft was given or is in Outlook drafts, not a file path. An Artifact Index row for a mail gets an empty `repo` field and a note saying where it lives. Related: [[m365-connector-read-only]], [[comms-style-short]].
