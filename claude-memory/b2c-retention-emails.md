---
name: b2c-retention-emails
description: "B2C retention project (started 30 Sep 2026) — two monthly member emails (courses/webinars, videos/Eviplex) per role + one-time discount win-back email after renewal cancellation; Figma node ids"
metadata:
  node_type: memory
  type: project
  originSessionId: 2c3b64f9-6938-4c4d-b16b-11de48959566
  modified: 2026-09-30T12:23:26.207Z
---

**Handover summary: `pm/projects/b2c-retention-emails.md` (read first).** Project index: `pm/projects/README.md`.

Goal: reduce B2C member drop-out with monthly emails. Briefed by Mahyar 2026-09-30. Designs in Figma file `MElRt1D5fbLF6KkbrmslAS` (Playground-FOMF):

- Email A, CME courses (live + OnDemand): Fachärzte `2698-345669`, Assistenzärzte `2698-390058`
- Email B, Vorträge + Eviplex: Fachärzte `2698-344740`, Assistenzärzte `2698-391746`
- Win-back after renewal cancelled (one-time discount): `2698-345177`

All monthly emails share a "Lernverlauf" header (courses attended, minutes, CME x/50). Some variants add a "12 CME bezahlt, aber noch nicht genutzt / Verwenden" block. Role rule (Mahyar, 30 Sep): CME matters for Fachärzte, not for Assistenzärzte, so the frames WITH the CME balance block are the specialist versions: A Fachärzte = 2698:345669, A Assistenzärzte = 2698:390058, B Fachärzte = 2698:344740, B Assistenzärzte = 2698:391746. The original link labels for Email A were swapped.

Figma frame names say something else: courses = "A-Day 3 post-cancellation — Email 1: Membership recap", videos = "A-Day 7 post-cancellation — Email 4/6", win-back = "A-Day 14 post-cancellation — Email 2: Loyalty renewal offer". Flagged to Mahyar 30 Sep (monthly vs post-cancellation sequence?). Text review done 30 Sep: specialist and assistant versions are identical apart from the credit block; "Ihr Beitrag" reads as membership fee; "12 CME bezahlt" mixes up credits and CME.

**Confirmed by Mahyar 30 Sep 2026:** they are monthly emails (Figma frame names are wrong). The "/50" is the member's CME balance included in the membership (38 used + 12 left). Eviplex for FOMF members (all-access): 3 months free, then 299 € (period assumed per year, 469 € standard from email B; not yet confirmed).

Email A = CME email (live courses/webinars + on-demand CME courses, "you can still earn your CME"); Email B = non-CME video library + Eviplex. Both live and on-demand CME courses draw from the CME balance (confirmed 30 Sep), so the balance block belongs in Email A.

Site wording (fomf.de/on-demand, read 30 Sep): brand spelling "OnDemand"; formats "Refresher OnDemand" (mehrtägige CME-Kurse) and "Highlights OnDemand" (kompakte CME-Vorträge); CME per completed Lernmodul with Multiple-Choice-Test; "über 30 Fachgebiete"; "mehr als 6000 Vorträge" is the total, not per specialty; membership is sold as "FOMF All Access Paket".

**Email A copy applied in Figma 30 Sep 2026** (both frames, in place, renamed "Monthly A · CME-Kurse · Fachärzte/Assistenzärzte"). Assumptions to confirm: Pädiatrie 8 CME (was 24), Gynäkologie card relabelled "Refresher OnDemand" (was "Studien- und Kongressupdate"), sample start date 12.03.2026. Not done: CME asterisk footnote, truncated titles, past course dates.

**Naming (Linear PLA-1944, live 16 Sep 2026):** "FOMF Mitgliedschaft" → "FOMF All Access Fortbildungspakete", "Mitgliedschaft" → "All Access Pakete" (short: "All Access"); CH-FR "Pass Formation Tout-Accès"; "Business Mitgliedschaft" (group) unchanged. Email A updated to "Ihr All Access Paket" 30 Sep; no "Mitglied" left in Email A. Email B and win-back still use Mitglied/Mitgliedschaft.

**Email B copy applied in Figma 30 Sep 2026** (renamed "Monthly B · Vorträge + Eviplex · Fachärzte/Assistenzärzte"; CME balance block 2698:344895 was hidden by mistake, restored and reworded the same day). Mahyar rejected "Lernzeit" (not fitting for a medical CME platform): use "Fortbildungszeit" and "Ihr Fortbildungsjahr bisher" in both emails. Open in B: Eviplex block has no CTA, 299 € period unconfirmed, placeholder video cards, Eviplex claims unverified.

**1 Oct 2026:** Assistenzärzte frames de-CME'd (A: subject 'Ihre nächsten Kurse und Webinare bei FOMF', row 3 'Videos angesehen', OnDemand headline 'Fortbildung flexibel on demand'; B: row 3 'Kurse und Webinare besucht'); CME numbers kept only on course cards as product facts. Email A frames renamed 'Monthly A · Kurse (live + OnDemand) · <Rolle>'. Win-back copy applied (frame 'Win-back · Verlängerungsangebot nach Kündigung'): unified on 75 € off 570 → 495 €, valid until 31.10.2026 (sample), Eviplex 3 Monate kostenlos then 299 € statt 469 €, sender FOMF. Still one win-back for both roles and it leads with '50 CME-Punkte' (specialist framing). Unconfirmed: 75 € vs 20 €, 570 € renewal price after Oct increase, 299 € period, validity rule.

**Why it matters:** from [[b2c-value-journey-dashboard]], 85% of renewals are automatic and year-1 renewal is flat across engagement (inactive 79%), so the lever is cancellation, not engagement. "Cancelled" = renewal switched off (CANCEL_MEMBERSHIP), member still active until expiry; see [[price-increase-cancellations]] for the table and the rising >60-day-out cancellations.
**How to apply:** measure with a holdout on cancellation rate; watch that value reminders do not trigger cancellations among inactive members.

**1 Oct 2026, frames and mobile:** Naming pattern "<Email> · <Thema> · <Rolle> · <Gerät>" (e.g. "Monthly A · Kurse (live + OnDemand) · Fachärzte · Mobile", "Win-back · Verlängerungsangebot · Alle Rollen · Desktop"). Mobile frames sit left of each desktop: A Fach 2698:346196, A Assist 2698:390585, B Fach 2698:344445, B Assist 2698:391451, Win-back 2698:345469. Mobile A/B texts synced to desktop; hid mobile-only "☹️ End of Your Membership" timeline row; replaced a real colleague's name in the iOS mock "To:" with Max Mustermann. To fit mobile, OnDemand card labels shortened on desktop too: "Highlights"/"Refresher", "4 × 45 Min. | 8 CME". Unclear: extra old copy of Email A Fachärzte (desktop 2707:393459, mobile 2707:393986, x 4490–4890) and loose frames at x 6577–9279; win-back mobile text not synced.
