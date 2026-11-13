---
name: team-service-agents
description: "Oct 2026 thinking on when a Claude helper becomes a team service (Level 4), Managed Agents vs Cowork vs Claude Tag vs Copilot; Slack triage + sponsor-briefing designs"
metadata:
  node_type: memory
  type: project
  originSessionId: 49e4ed1c-4c3f-49a4-8eed-d781f977841c
  modified: 2026-10-18T21:27:10.649Z
---

Discussed 15–18 Oct 2026 (not decided, no build started).

**Framework:** the skill is the asset. Level 2 = skill · Level 3 = skill + trigger (Cowork schedule, personal, runs as the user) · Level 4 team service = skill + trigger + service identity + interface + governance and an owner. A dedicated agent beats "Claude + skill" only when it needs a non-human trigger, an identity narrower than the user's, pinned repeatability, or system-to-system output.

**Surfaces:**
- Claude Tag: shared @Claude in Slack, public beta from 23 Jun 2026, Team/Enterprise. Slack-only, Teams unconfirmed.
- Managed Agents: no end-user UI. A scheduled deployment needs no relay, but chat needs our own Slack or Teams relay. A deployment run takes no per-run input.
- Copilot Agent Builder: Level 2 only (reactive, runs with the user's permissions, no external actions). Copilot Studio is needed for more. Its strength is distribution inside Teams/Copilot.

**FOMF split:** P&E works in Slack, so test Claude Tag for the triage agent before building one. Non-tech works in Microsoft/Teams, so Level 4 there means our own Teams bot relay plus a Managed Agent. Ask the Anthropic account team about Claude Tag for Teams.

**Sponsor-briefing Managed Agent sketch:**
- scheduled deployment, Mon 06:00
- HubSpot private app, read-only
- Metabase key in a read-only group
- Entra app with Sites.Selected (Pharma site) + Mail.ReadWrite limited to the sales group via RBAC for Applications, no Mail.Send
- drafts per rep
- owner: Productivity team (Simone)

Repo files would go in fomf-code, not this workspace.

**Why:** Mahyar is deciding how far departments self-serve vs IT/Eng. View so far: departments own the skill/prototype, IT/Eng owns identity, interface and governance.

**How to apply:** reuse this framing for hackathon Level 4 and for any "make it a team service" request. Open questions: does FOMF have an Anthropic API org, M365 Copilot licenses, and is Teams the right channel for sales? The hackathon material is in `cto-assistant/ai-hackathon-2026/`.
