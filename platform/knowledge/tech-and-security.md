# Platform: tech and security

Security findings never go in this file: they are in `../../cybersecurity/reports/` (git-ignored) and SharePoint.

## Stack

- Repo `fomf-code/fomf-learning-platform`: Kotlin and Node.js microservices on GKE; Next.js frontend on Vercel; CI/CD with GitHub Actions and Vercel.
- Storage: Cloud SQL; Elastic Cloud for search (BM25 and semantic), and only for search.
- Logs, monitoring, observability: Datadog (a July 2026 move to Elastic Observability was reverted; confirmed August 2026).
- GCP project `fomf-v2-prod`; analytics in `fomf-dl` (BigQuery) and Metabase, see `data.md`.
- Internal back offices: Retool, built by the Productivity team on top of the platform backend (fomf.retool.com).
- Legacy: a Drupal 8 stack (statefulset `drupal-php-v2`, namespace `v2`) behind `legacy.fomf.de/.ch/.at` and `legacy.cmed.org.uk`, a Hasura instance, and the Ungerboeck event-management webhook.

## Known incidents and decisions

- **php2shell (22 Oct 2026):** PHP RCEs on the legacy Drupal stack. The legacy hosts were restricted at the ingress (PR #10371, merged 25 Oct 2026). Findings, forensics and open follow-ups (secret rotation, webhook allowlist, decommissioning): `../../cybersecurity/reports/2026-10-22-php2shell-drupal-incident.md`. Before advising on legacy Drupal, Hasura or the Ungerboeck webhook, read it and re-check the live ingress.
- **Retool:** org-wide 2FA (OTP) enforced by Mahyar on 27 Oct 2026. The Retool connector reads audit logs (`retool_list_audit_logs`, 10 events per page; filters userId, pageName, queryName, resourceName, time in unix seconds; retention starts Jun–Jul 2026); responses are huge, so page through them in a subagent. It has the `mcp:admin` scope: use it read-only unless Mahyar says otherwise. The Oct 2026 new-login case: `../../cybersecurity/reports/2026-10-27-retool-new-login-alert.md`.
- **Security assessment:** Blaze tests the learning platform and reviews the learning-platform GKE cluster, see `../../cybersecurity/`.

## Bot traffic on fomf.de (Nov 2026)

Vercel logs are in Datadog EU (`source:vercel`; attributes `@proxy.userAgent`, `@proxy.clientIp`, `@proxy.path`, `@network.client.geoip.*`, `@requestId` = one request).

- **China (about 26k requests a day, 3 % of fomf.de):** about 93 % genuine Baidu (rDNS `*.crawl.baidu.com`), up from about 1.5k a day on 1 Nov 2026. It crawls `/mediathek/content`, which redirects to `/user/login?nonce=…`: a crawl trap. It also inflates registration-step counts. The rest: Bytespider, headless browsers on cloud hosts, scrapers, IPFS gateway probes.
- **Finland:** one Hetzner IP is SISTRIX; its 4 Nov 2026 burst (260k requests) was a one-off site audit. **SISTRIX is known and allowed: don't flag or block it** (Mahyar).
- Also seen: `medizinwoche-cme-collector/1.0` crawling `/kurse`.
- Fixes (robots.txt, Vercel firewall rules) land in the platform repo or the Vercel project and need approval.
