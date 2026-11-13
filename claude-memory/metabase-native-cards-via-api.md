---
name: metabase-native-cards-via-api
description: "How to create native-SQL Metabase cards for Mahyar (MCP can't; use REST API with key in cto-assistant/.env via curl)"
metadata: 
  node_type: memory
  type: project
  originSessionId: a8e4f3ac-9324-4567-839b-50d6631cdd58
  modified: 2026-09-18T20:58:58.073Z
---

The claude.ai Metabase MCP can only save query-builder (MBQL) questions — there is no construct_native_query tool, `create_question` rejects raw SQL, and `construct_query` rejects native stages. Raw datasets (`platform_raw_*`) are NOT synced into Metabase's data model, so anything needing them must be a native question.

Working path (established 2026-09-18): Metabase REST API at https://fomf2.metabaseapp.com with header `x-api-key`, key stored in `cto-assistant/.env` as `METABASE_API_KEY` (git-ignored; never echo it). Use **curl**, not Python urllib — the local Python 3.14 has no CA bundle (CERTIFICATE_VERIFY_FAILED). Flow: `POST /api/card` (dataset_query type native, database 2 = "Bigquery (fomf-dl)", collection 201 = Executive Board) → `GET /api/dashboard/{id}` → `PUT /api/dashboard/{id}` with full `dashcards` list (new card id -1, set row/col/size).

Also: MCP `update_dashboard` add-actions ignore tabs, so cards added to tabbed dashboards are invisible; a remove-only call once flipped the dashboard to archived (reverted). Prefer the REST API for dashboard edits.

**Why:** cost an hour of blocked attempts; Mahyar wanted the charts saved in Metabase, not pasted manually.
**How to apply:** for any Metabase card on raw tables or with SQL, go straight to the REST API with the .env key. Ask Mahyar to re-add the key if `.env` is empty. Related: [[b2c-membership-income-dashboard]].
