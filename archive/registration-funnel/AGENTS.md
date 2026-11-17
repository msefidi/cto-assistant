# Registration funnel

Drop-off in the web registration form (fomf.de / .at / .ch), built 7 Oct 2026 for the window 7 Jul – 6 Oct 2026.

- **Page:** `registration-funnel.html` (published artifact https://claude.ai/artifact/Uk1RMDh5kfkTfEPQBsRqm3). It is generated from `funnel.template.html` by replacing `__DATA__` with the query result (rows where `bot = false`, as `[month, has_step4, site, type, device, login_1d, stage, n]`).
- **Query:** `sql/funnel.sql`. Run it through the Metabase API (database 2 = BigQuery `fomf-dl`) when `bq` auth has expired.
- **Flow (from `RegistrationFormContainer.tsx`):** landing (email, rejects existing addresses) → step 1 personal info → `Signup Started` (account created, login redirect) → step 2 medical-info → step 3 occupation-type-based → step 4 marketing-source (optional, live since 27 Jul 2026) → `Signup Completed`. `Registration Step` fires when a screen is shown.
- **Crawlers:** `Baiduspider-render` loads the page thousands of times (~7.7k IDs in the window). Remove crawler UAs and IP-days with 3+ landing IDs that never progressed.
- **Coverage gap:** Segment sees ~1.8k form account creations vs ~4.1k new self-registered accounts in `platform_raw_userservice.public_user_`. The cause has not been checked (consent opt-outs? other entry points?).
