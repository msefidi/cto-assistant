---
name: m365-connector-read-only
description: claude.ai Microsoft 365 connector cannot draft or send mail; open a pre-filled compose window in Outlook via mailto instead
metadata:
  node_type: memory
  type: reference
  originSessionId: f0b14253-fcbe-4d68-8e4b-84b9a513c172
  modified: 2026-11-18T11:35:58.306Z
---

The claude.ai Microsoft 365 connector is read-only: its granted Graph scopes are all `*.Read` (no `Mail.ReadWrite`, `Mail.Send`), and it has no draft or send tool at all (checked 18 Nov 2026). Mahyar runs the new Outlook for Mac, which has no AppleScript support, and no Graph CLI (`az`, `mgc`) is installed.

**How to apply:** when Mahyar wants a mail "in Outlook", build a `mailto:` URL (to, cc, subject, body, URL-encoded with Python) and run `open -a "Microsoft Outlook" "<url>"`. It opens a new compose window, not a reply in the thread, and may lack his signature; say so. Draft text still follows [[comms-style-short]].
