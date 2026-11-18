# IT security management: where we stand (18 Nov 2026)

Baseline written by Mahyar and Andreas Langer in their weekly 1:1 on 18 Nov 2026, cleaned up afterwards. It is a first pass and not complete; the point was to start. On **21 Dec 2026** they meet in person to turn it into the **2027 roadmap**, adjusted with Blaze's input from Phase 1 (M365 review). The IT security management work gets its own Linear board (Andreas's team); Mahyar's board only tracks his follow-up on the Mac surveys.

Lines marked *(to confirm)* are Claude's reading of a short note; check them with Andreas.

Internal only: this file describes gaps. Keep it in this repo; do not paste it into Linear or other external tools.

## 1. Device management

**Goal for now:** bring every employee laptop into device management first, then define hardening requirements per platform.

| Area | Where we stand | Next |
|---|---|---|
| Windows laptops | Basic hardening defined | Turn it into a hardening profile |
| macOS laptops | Not onboarded. Mahyar runs a survey first: Andreas's MS Forms for engineers ("Engineering Hardware Survey – Zusammenarbeit") and for unit leads (Slack DM with Andreas, thread of 8 Oct 2026) | Send / follow up the surveys (Mahyar), then onboard |
| Linux laptops | Not onboarded | Onboard |
| Hardening profiles | None yet beyond the Windows basics | Define one profile per platform |
| Onboarding / offboarding | Not connected to device management | Link device enrolment and removal to the joiner/leaver process (see 2) |
| Asset management | Not started *(to confirm)* | Define an inventory of devices and owners |
| Mobile devices (MDM) | Not started | Scope it |
| Update rings | Three rings defined: (1) pilot users test the update first; (2) everyone else gets it a few days later; (3) device groups that may delay updates so running courses are not disrupted, e.g. course laptops *(to confirm)* | Keep |
| Device restrictions | Running in audit mode only: logged, not enforced | Decide when to enforce |
| Device validity | A device counts as legitimate if it has been used (signed in) at least once in the last 30 days *(to confirm)* | Define what happens to devices outside that window |

## 2. Entra ID and access management

| Area | Where we stand / what we want |
|---|---|
| MFA | Enforce MFA for everyone with passkeys, a one-time code to the mobile phone during registration, and OTP via Microsoft Authenticator. Whether enforcement is complete is not recorded *(to confirm)* |
| Admin roles | Four levels: Global Admins, IT Admins, channel admins, employees |
| Teams | Open; nothing noted yet |
| Joiners and leavers | A structured onboarding/offboarding process: who leaves when, and IT learns it in time |
| Enterprise applications | Manage Entra enterprise applications (which apps are connected and who may use them) |

## 3. SharePoint

- **Today:** no structure. Everyone has access to everything.
- Everyone except P&E, GF and EB works on the main site.
- **Goal:** define the site structure and the access rules per site.
- Course laptops use shared drives; they need a place in that structure.

## 4. Exchange Online

- Harden mail: rules that detect and stop phishing, spam and similar mail.

## 5. Commitments to Eli Lilly

The "quick wins" FOMF promised Eli Lilly in its information-security requirements. They must be covered in the 2027 roadmap. Source: Linear project "Eli Lilly Cybersecurity" (lead Andreas, initiative Cybersecurity), its requirements table as of 15 Jul 2026, read 18 Nov 2026; Lilly's requirements document is linked there (SharePoint, Habib's OneDrive).

| Requirement | What we promised | Target | Status (18 Nov) |
|---|---|---|---|
| Audit log management | 12 months of logs for M365 and HubSpot; first step: weekly export to SharePoint, later BigQuery | 15 Jul 2026 | Done |
| Media destruction | SOP for media destruction | 15 Jul 2026 | Done |
| Secure deletion | SOP for hardware and IT equipment disposal | 15 Jul 2026 | Done |
| Change management | A documented change process for every system that processes customer data (B2B, B2C) | 1 Sep 2026 | **Open, overdue** |
| Data inventory | A list, kept current and available on request, of the systems and processes where Lilly information is processed or stored | 1 Sep 2026 | **Open, overdue** |
| Security training | Basic IT/cyber security training once a year | 31 Dec 2026 | Research in progress (Andreas) |

Whether Lilly was told about the two overdue items is not recorded.

## Not covered yet

Raised in neither the notes nor the 1:1, so open for 21 Dec: what Blaze's Phase 1 (M365) reports; backup and recovery of M365 data; logging and alerting (who watches sign-in and admin events); the ISMS / ISO 27001 track from the Blaze topic.
