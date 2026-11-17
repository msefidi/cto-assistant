---
name: platform-product
description: "Everything that stays true about the learning platform (offer, products, B2C definitions and findings, data, stack, incidents) lives in the product folder cto-assistant/platform/ (AGENTS.md + knowledge/), next to its topics; read AGENTS.md first"
metadata:
  type: reference
---

For any learning-platform question, read `cto-assistant/platform/AGENTS.md` first, then the file in `knowledge/` that fits: `offer.md` (what FOMF sells, naming, markets), `b2c-members.md` (agreed definitions and what we know about renewal, churn, acquisition), `data.md` (BigQuery, Metabase), `tech-and-security.md` (stack, legacy Drupal, Retool, bot traffic), `products/` (SYFAT, On-Demand Accredited).

**Why:** on 17 Nov 2026 Mahyar moved product knowledge out of memory into product folders, so memory stays small. The Eviplex counterpart is [[eviplex-product]].

**How to apply:** when you learn a lasting platform fact or a new analysis result, change the product folder (one line per finding in `b2c-members.md`), not memory. Status and next steps go in the topics inside the folder (`syfat/`, `on-demand-accredited/`, `aekw/`).
