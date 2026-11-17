---
name: eviplex-uae-pitch
description: "Closed: English Eviplex + FOMF deck for the UAE contact (Oct 2026, final draft v5 in archive); claim and hosting decisions; PowerPoint render lessons"
metadata:
  type: project
---

**Closed (27–28 Oct 2026):** English deck introducing Eviplex and FOMF for a UAE contact of Wafa and Jasmin. Final file: `cto-assistant/archive/eviplex-uae-pitch/Eviplex x FOMF - UAE - EN (draft v5).pptx`, built from the Luxembourg "mit FOMF" deck and the CH fact sheet (SharePoint eng › 09-Eviplex/Marketing Planung/03_Pitches/Eviplex final).

Decisions by Mahyar to reuse for other non-EU pitches:
- No compliance claims for the target country: German § 203 and GDPR are the standard the product is built to; other data-residency rules are "assessed per project". UAE law (Federal Law No. 2/2019, Art. 13) by default bars storing or processing UAE health data abroad; Ministerial Resolution 51/2021 adds exceptions.
- Unlike the CH deck, regional and in-country hosting is offered ("Flexible to expand to new countries").
- "Zero data retention at the AI model provider", never "no data storage with third-party services" (Google Cloud stores conversations). "Made in Europe / built to European standards". No pricing, partnership or next-steps slides.
- FOMF figures used: ~140k doctors in DACH, 3,200+ speakers (Mahyar's figure), 60+ scientific board members.

Render lessons: the SharePoint connector returns text only, so Mahyar downloads .pptx files to ~/Downloads. No LibreOffice: render through PowerPoint via AppleScript with files in ~/Library/Containers/com.microsoft.Powerpoint/Data/Documents/ (the sandbox blocks /tmp). A corrupt deck leaves PowerPoint stuck on a dialog only Mahyar can close, so validate before rendering. His viewer ignores wrap="none"; use wide wrapping text boxes.

Related: [[eviplex-ch-tech-factsheet]].
