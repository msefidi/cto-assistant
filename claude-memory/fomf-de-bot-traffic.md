---
name: fomf-de-bot-traffic
description: "Nov 2026 analysis of bot traffic on www.fomf.de (Vercel logs in Datadog) — CN = genuine Baiduspider, FI = one Hetzner \"Optimizer\" IP"
metadata:
  node_type: memory
  type: project
  originSessionId: c0ce2470-1d95-401f-8bdc-f6ff6795941c
  modified: 2026-11-05T14:49:58.078Z
---

Analysis 5 Nov 2026 of `source:vercel` logs in Datadog EU (attributes: `@proxy.userAgent`, `@proxy.clientIp`, `@proxy.path`, `@network.client.geoip.*`, `@requestId` = one request).

- **China (~26k req/day, ~3% of fomf.de):** ~93% genuine Baidu (rDNS `*.crawl.baidu.com`; Baiduspider, Baiduspider-render, plus Chrome/99 headless from 116.179.33.x). Jumped from ~1.5k/day to 15–24k/day on 1 Nov 2026. Crawls /mediathek/content (307 → /user/login?nonce=… = crawl trap), /slideview/*. Rest: Bytespider (verified ByteDance), headless browsers on Huawei/Tencent Cloud, Chrome/48 residential-proxy scraper, /ipfs/<CID> gateway probes.
- **Finland:** single IP 135.181.79.61 (Hetzner) = SISTRIX (same IP sends `SISTRIX Optimizer; Uptime` pings to `/` a few times/day). One-off burst **4 Nov 2026 14:00–20:00 UTC**: 260k requests, 39k distinct URLs, UA `Mozilla/5.0 (compatible; Optimizer)` — a headless SISTRIX Optimizer site audit (likely configured by whoever owns SEO). Each rendered page fires ~13 nav `_next/data` prefetches (≈105k of the 260k). Covered slideview (~15k URLs), mediathek, /user/login+registration variants, partnerforum, kursbuecher. Not ongoing. **Mahyar confirmed SISTRIX is OK (known/allowed) — don't flag or block it.**
- Also seen: `medizinwoche-cme-collector/1.0` (Hetzner) crawling /kurse.

**Why:** relevant to Vercel cost, analytics noise (see [[registration-funnel]] Baidu noise) and cybersecurity hardening.
**How to apply:** reuse the queries/attributes above; fixes (robots.txt, Vercel Firewall rules) land in fomf-learning-platform / Vercel project, need approval.
