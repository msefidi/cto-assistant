---
name: teams-meeting-transcripts
description: "How to read Mahyar's Teams meeting transcripts via the M365 connector (calendar event → meetingTranscriptUrl → read_resource); only meetings with transcription on"
metadata:
  node_type: memory
  type: reference
  originSessionId: a590c4fa-cd0d-4883-92e2-3bfa4c1f945e
  modified: 2026-11-20T14:25:11.046Z
---

Mahyar's Teams meetings can be read after the fact through the Microsoft 365 connector: `outlook_calendar_search` → `read_resource` on the event → pass its `meetingTranscriptUrl` verbatim to `read_resource`.

- Only works when transcription was started in the meeting. If it wasn't, there is no transcript.
- Tenant switch: Teams admin center → Meetings → Meeting settings → Transcript API access → Microsoft Graph access, plus "Include speaker attribution". Mahyar turned both on himself on 20 Nov 2026; each took a few minutes to apply, and speaker names then also appeared on transcripts made before the change (`<v Name>` tags in the VTT). Error `GraphAccessToTranscriptsDisabled` means the switch is off again.
- Claude Meetings (bot) is not readable from Claude Code: the sign-in lacks `user:projects:read`.
- Intended use: Mahyar says "process <meeting>" → log results, decisions, brief and board updates in the matching topic; action items for product teams stay in their Linear ([[linear-one-issue-rule]]).
- Do not save meeting content to memory. Sensitive meetings (EB, ÄKW, security) follow the topic's confidentiality rules.
