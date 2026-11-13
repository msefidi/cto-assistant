---
name: registration-funnel
description: "Web registration drop-off funnel from Segment (Oct 2026) — step events, Baidu crawler noise, results, coverage gap"
metadata:
  node_type: memory
  type: project
  originSessionId: 9f24d2c4-758f-4596-89b7-c45397e760fb
  modified: 2026-10-07T13:12:14.643Z
---

Built 7 Oct 2026 in `cto-assistant/registration-funnel/` (artifact https://claude.ai/artifact/Uk1RMDh5kfkTfEPQBsRqm3). Window 7 Jul – 6 Oct 2026, people = Segment anonymous_id.

Result (crawlers removed): 3,470 visitors → 1,948 entered email (56%) → 1,828 accounts → 1,635 finished (47%; 84% of those past the email screen). Of the 1,522 who left on the email screen, 546 logged in within 24 h (existing users). Inside the form the largest losses are step 3 (professional details, ~7%) and step 1 (~6%).

**Why:** Mahyar asked how many people drop out of the 3/4-step registration.
**How to apply:** `Baiduspider-render` inflates `registration_step` landing ~3×, so always filter crawler UAs and IP bursts. Segment covers only ~45% of new accounts seen in the user service (cause not checked). When `bq` auth is expired, query through Metabase, see [[metabase-native-cards-via-api]].
