---
name: php2shell-drupal-incident
description: "Oct 2026 php2shell PHP RCE incident on legacy Drupal (fomf-v2-prod, v2 namespace); findings and follow-ups in cto-assistant/cybersecurity/reports/"
metadata:
  type: project
---

On 22 Oct 2026 the php2shell PHP RCEs (CVE-2026-109618/109619) were handled as an incident for the legacy Drupal stack (statefulset `drupal-php-v2`, namespace `v2`, fomf-v2-prod). The legacy hosts were restricted at the ingress with fomf-learning-platform PR #10371 (merged 25 Oct 2026).

The findings, log forensics and open follow-ups are in `cto-assistant/cybersecurity/reports/2026-10-22-php2shell-drupal-incident.md` (git-ignored). They never go into memory, briefs or external tools.

**How to apply:** before advising on legacy Drupal, Hasura or the Ungerboeck webhook, read that report and re-check the live ingress and whether the secrets were rotated. The Blaze GKE review targets these gaps, see [[security-assessment-vendor]].
