---
name: php2shell-drupal-incident
description: "Oct 2026 php2shell (CVE-2026-109618/109619) incident — legacy Drupal (8.9.4, PHP 7.3.19) on fomf-v2-prod v2 namespace; PR #10371 ingress mitigation, open follow-ups"
metadata:
  node_type: memory
  type: project
  originSessionId: e35294b5-5dfc-4be6-93ec-67413d7f5c49
  modified: 2026-10-22T11:40:20.951Z
---

On 22 Oct 2026 the php2shell PHP RCEs (CVE-2026-109618/109619, disclosed 21 Oct) were handled as an incident for the legacy Drupal stack.

- Drupal: statefulset `drupal-php-v2` in `v2` on fomf-v2-prod (wodby nginx sidecar + fomf-drupal image). Drupal 8.9.4, PHP 7.3.19: no upstream fix for 7.3. Exposed via `legacy.fomf.de/.ch/.at` and `legacy.cmed.org.uk`. `fomf.org`/`www.fomf.org` also point at drupal-frontend-service, but `permanent-redirect` answers before proxying.
- fomf-learning-platform PR #10371 (by Shervin): its first commit removed the legacy hosts from `prod-ingress.yaml`, which was already live on 22 Oct (legacy.* returned 404). Later commits add a restricted `drupal-legacy-restricted` ingress: GET/HEAD/OPTIONS only, a POST exception for `/v2/ungerboeck/main`, and path/PHP denies.
- Review findings: the POST exception keeps the RCE reachable. `/core/authorize.php/x` and `/update.phpX` bypass the PHP deny. `session.upload_progress` is on. memory_limit -1 is set via php_value, not php_admin_value. Live API keys are hardcoded in fomf-drupal `k8s/base` and settings.php. v2 has no NetworkPolicies.
- Large-body `POST /` bursts hit all legacy hosts on 18 Oct 21:48, 21 Oct 22:04 and 22 Oct 01:33 UTC, all answered 200. Quick pod triage found no signs of compromise, but that is not conclusive. Real IPs are only in Datadog.

- Log forensics, 22 Oct:
  - Datadog main index drops `service:controller status:info` (all 2xx/3xx ingress) and `source:fomf-drupal` entirely. There are no log archives. The GCP `_Default` log sink is disabled.
  - Only rotated ingress logs on the nodes were usable, covering 21 Oct about 10:17 UTC onward. The 18 Oct burst can't be attributed.
  - In the visible window, no ≥1 MB request reached Drupal. 144.172.118.88 (aiohttp) sprayed `POST /` after disclosure: 8 hits on Drupal with 9 and 25 KB bodies, normal responses, no follow-up. 34.18.239.146 was a generic .env/.git scanner.
  - The Ungerboeck webhook comes only from 52.49.104.123 and 52.49.103.177, with a max body of 29 KB.
  - The ingress log format has no `$host` field.

- Egress and runtime check, 22 Oct:
  - Datadog CNM is off. VPC flow logs are enabled on sb-k8s-prod-01 but discarded: the `_Default` sink is disabled and the Datadog sink doesn't route them. NAT logs are errors-only.
  - Datadog Workload Protection (CWS) is on and covers the Drupal pods. Since 10 Oct, no process was spawned by php-fpm and there were no shell execs 16 Oct–22 Oct 07:00. No exfil, mining or SSH rules fired from Drupal pods. Pod tx volume showed no anomaly.
  - The drush/mysqldump execs on 22 Oct came from Shervin via kubectl exec (GCP audit log). He is building a `drupal-test` namespace with a `7.4-patched-test` image.
  - The cronjob runs `composer install` from the internet every 20 min, which triggers CWS "Malicious package installation" signals (false positive, but a supply-chain risk).

- DB reach, 22 Oct:
  - Drupal MySQL `sql-drupal-prod-europe-west3-05` (10.0.63.16) is directly queryable from PHP: creds in env, no NetworkPolicy, no query logging.
  - Hasura prod (`hasura.prod.fomf.org`, v1.3.3, console on) connects to `sql-prod-europe-west3-02` as `postgres`. The leaked admin secret means `run_sql` from the internet.
  - Pod Workload Identity has no GSA binding, so no GCP API access.
- Key-usage check, 22 Oct:
  - Firebase admin keys in Drupal are `fomf-livestream` (roles/editor, key from 2018) and `fomf-event-site` (tokenCreator, so it can impersonate the appspot SA, which is owner).
  - Key auth-event metrics show no spikes at the attack times. There were no key, IAM or function changes in 10 days and no admin activity by the SAs in 30 days.
  - Hasura Query Insights on -02 (7 days): only app or Hasura-generated SQL, no dblink, COPY or role changes. "UTILITY COMMAND" is opaque.
  - Policy Analyzer is not enabled. Custom-token minting is not observable.

**Why:** an open security incident with follow-ups (secret rotation, webhook IP allowlist, Drupal decommission/upgrade). It belongs to the cybersecurity priority.
**How to apply:** before advising on legacy Drupal or the Ungerboeck webhook, re-check the live ingress state and whether the secrets were rotated. Security findings must not go to external tools.
