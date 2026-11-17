---
name: retool-audit-logs
description: "Retool MCP can read the org audit logs (fomf.retool.com); org-wide 2FA enforced 27 Oct 2026; the Oct new-login case is in cybersecurity/reports/"
metadata:
  type: reference
---

The Retool connector (claude.ai) reads audit logs with `retool_list_audit_logs`: 10 events per page; filters userId (numeric legacy_id), pageName, queryName, resourceName and time in unix seconds. Responses are huge, so page through them in a subagent and use jq on the overflow files. Retention starts between Jun and Jul 2026. The connector has the `mcp:admin` scope since 27 Oct 2026 (it can disable users and change permissions): use it read-only unless Mahyar says otherwise.

Mahyar enforced org-wide 2FA (OTP) in Retool on 27 Oct 2026. The new-login alert investigated that day, and the open Retool hardening points, are in `cto-assistant/cybersecurity/reports/2026-10-27-retool-new-login-alert.md` (git-ignored).

**How to apply:** for Retool security questions, read that report first; it belongs to the cybersecurity priority, see [[security-assessment-vendor]].
