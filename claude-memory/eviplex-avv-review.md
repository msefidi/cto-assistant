---
name: eviplex-avv-review
description: "Nov 2026 review of Eviplex user AVV (Anlage 2.1 TOMs / 2.2 subprocessors, V-05) and FOMF↔Eviplex Berufsgeheimnis draft for Habib; verified gaps in code + GCP"
metadata:
  node_type: memory
  type: project
  originSessionId: 18077c01-474f-4f4f-8a2a-cf972e655fe6
  modified: 2026-11-04T06:39:33.950Z
---

On 3 Nov 2026 Mahyar asked for help answering Habib's mail "AW: AVV und Datenschutzerklärung Eviplex" (28 Oct; cc Felix Dümpert, DPO). Habib wants Anlage 2.1/2.2 of the user AVV (V-05) checked, plus the red TOMs and feasibility of the FOMF↔Eviplex "Interne Verschwiegenheitsvereinbarung" (§ 203) before employees are pledged. Page in grenade style: cto-assistant/eviplex-avv/avv-pruefung-2026-11-03.html (local only, not published — contains security gaps).

Verified 3 Nov (meviq main e8bf9ef + read-only gcloud on meviq-prod):
- All chat LLM calls still go through the **Vercel AI Gateway** (BYOK, only:['openai']), with **no EU region** for OpenAI. The residency check only logs; it does not fail closed. Voice dictation calls api.openai.com directly. This contradicts the 7 Oct "fixed" note in [[eviplex-ch-tech-factsheet]].
- Missing from Anlage 2.2: Vercel, Datadog (logs with LLM-rewritten queries), **Retool** (US IP ranges in the Cloud SQL authorized networks). Azure is not used. Vertex is used only as the Elastic reranker; the location of that and of the Jina embeddings is not in the repo.
- GCP: Cloud SQL has a public IP and requireSsl=false; Redis has no transit encryption; an 11.5 GB dump from Nov 2025 sits in gs://meviq-prod-db-exports; a stopped clone prod-dev-test-cloned exists (Sep 2026). Everything uses Google-managed keys. The GKE control plane is public. Branch ruleset: 0 approvals required.
- Correct: europe-west3, Secret Manager, timingSafeEqual, 7 backups + point-in-time recovery, Braintrust EU data plane (names masked only; dictation traces and admin dataset rows are unmasked).
- The Google PSA/CMA is still open; Google handed it to new contacts (Stefanie, Laura) on 30 Oct.

Update 3 Nov (same session):
- Done, with Mahyar's approval: removed the Retool authorized networks; deleted the dump (soft delete until 10 Nov) and the clone. Mahyar deleted the Retool "Meviq DB" resource. Retool is no longer used (own admin at admin.meviq.com).
- Mahyar's scoping: Elastic, the FOMF GraphQL API and Datadog get only LLM-written search terms (2–8 words, no names), which are not personal data, so they are not subprocessors. FOMF stays in Anlage 2.2 as "Betreiber/Hosting".
- All pods connect directly to the private IP 10.247.96.3 with a password and no TLS. No pod uses a proxy. Forcing the proxy or ENCRYPTED_ONLY would take prod down. Decision: no proxy enforcement; do TLS (CA check) first.
- Previews and PRs share the instance, but each has its own database for users and messages; only documents and Elastic are shared. Showcase only runs with the PR label. That is enough logical separation, so don't flag it again.

Update 4 Nov: OpenAI EU pin = meviq PR #1079 (open, off by default; needs AI_GATEWAY_OPENAI_INFERENCE_REGION=eu in pr, then prod overlays). Dictation is not covered. Habib replied: the documents should describe the **end state**. He'll hand them out only once everything is implemented, and he wants confirmation that what's written will be built. Reply framing: done / we build it (text stays) / we don't build it (change text) / still to check (Vercel gateway location, OpenAI retention, unverified TOMs: admin roles, least privilege, alerting, subprocessor certs).

**Why:** Eviplex GmbH holds the liability; the TOMs are promises to doctors under § 203.
**How to apply:** re-verify before reusing any of these TOM claims. Fixes belong in the meviq repo and GCP and need approval. See [[security-assessment-vendor]].
