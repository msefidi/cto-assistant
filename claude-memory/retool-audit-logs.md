---
name: retool-audit-logs
description: "Retool MCP can read org audit logs (fomf.retool.com); Oct 2026 Sabrina Diggelmann new-IP alert investigated — likely IPv6 rotation, account disabled pending confirmation"
metadata:
  node_type: memory
  type: project
  originSessionId: e8ef5784-c7b6-4131-b68c-901983b37ddd
  modified: 2026-10-27T21:01:33.602Z
---

Retool MCP (claude.ai connector) reads audit logs via `retool_list_audit_logs` (10 events/page, filters userId [numeric legacy_id], pageName, queryName, resourceName, time in unix seconds). Responses are huge — page through in a subagent and jq the overflow files. Retention starts somewhere between Jun and Jul 2026. Connector was granted mcp:admin scope on 27 Oct 2026 (can disable users, change permissions) — use read-only unless told otherwise.

27 Oct 2026: Sabrina Diggelmann (CS, Retool userId 1541262) forwarded a Retool "new login" alert (26 Oct 13:18 UTC, IP 2a01:8b82:7801:400::478). Findings: same /64 as her only earlier logins (16 + 28 Sep, ::80e / ::5e3), same app flow (Members → Booking List → Booking Detail → `create_payment` negative WIRE_TRANSFER refunds), client clock in CET → most likely IPv6 privacy-address rotation, i.e. false positive. Session did 4 refund entries (−295, −1100, −460, −390 in minor units). 27 Oct session from 2a01:8b81:… reused the session without a new login (reads only). Account: password login, no 2FA, no Google SSO. Mahyar disabled her account 27 Oct 20:29 UTC pending confirmation.

27 Oct 2026 ~21:00 UTC: Mahyar enforced org-wide 2FA (Settings → Advanced → Require Two Factor Authentication = OTP; API confirms `two_factor_auth_required: true`, type `otp`). Before that 0/123 users had 2FA. Open: shared logins (helfer@fomf.org, helfer@fomf.ch, medical-team@fomf.org), 13 admins, stale active accounts, whether Google sign-in is covered, Entra ID SSO + disable password login later.

**Why:** reference for future Retool security questions and the cybersecurity priority ([[security-assessment-vendor]]).
**How to apply:** if she is re-enabled, check whether the refunds were confirmed; push 2FA/SSO for Retool password users.
