---
name: pharma-msa
description: Moderna and Madrigal MSAs (pharma sponsoring) — Habib needs IT security feedback and a sub-processor list; brief in platform/pharma-msa/
metadata:
  node_type: memory
  type: project
  originSessionId: 87898c3d-ee45-4dbe-81b2-eba2d4ae1216
  modified: 2026-11-19T14:43:58.955Z
---

The topic lives in `platform/pharma-msa/`. Read its brief, `docs/decisions.md` and the newest log entries before advising. This note is only a pointer.

- Client names, contract terms and the content of Moderna's security requirements stay in the repo, never on the board issue (CTO-27).
- The sub-processor list is meant to be reused for every later pharma contract, so build it as a reference, ideally kept current by Felix Dümpert in the processing register. Related: [[eviplex-avv-review]] (Eviplex subprocessors), [[security-assessment-vendor]].

**Why:** Habib negotiates the MSAs and wants them signed before end of 2026; Mahyar owes the technical and data-protection input.

**How to apply:** "catch up on the MSAs" means the routine in the root `AGENTS.md`, see [[topic-shape]].
