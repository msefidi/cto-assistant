---
name: eviplex-uae-pitch
description: "Oct 2026 English Eviplex + FOMF deck for a UAE contact (Wafa & Jasmin); built from Luxembourg \"mit FOMF\" deck + CH tech fact sheet; render pipeline notes"
metadata:
  node_type: memory
  type: project
  originSessionId: 7bcb1b17-e83d-42a1-8707-19170ba20c46
  modified: 2026-10-27T22:55:45.962Z
---

27 Oct 2026: Wafa and Jasmin met a UAE contact interested in Eviplex. Mahyar asked for an English deck that introduces Eviplex and FOMF (established CME provider, ~140k doctors in DACH).

Sources (SharePoint eng › 09-Eviplex/Marketing Planung/03_Pitches/Eviplex final): the "Luxembourg deck" is "Eviplex V 1_1 (final) mit FOMF - DE.pptx" (15 slides, FOMF intro on slides 2–6); fact sheet is slides 10–12 of "Eviplex V 1_1 (final) - CH - mit Tech-Factsheet.pptx". Both decks use the same layout 7 and theme, so slides copy across cleanly.
Output: cto-assistant/archive/eviplex-uae-pitch/"Eviplex x FOMF - UAE - EN (draft v1).pptx" (18 slides: Lux 1–15, fact sheet 16–18), pure translation pass. The § 203 footnotes use the CH-approved wording (OpenAI only, no "unbroken chain"), see [[eviplex-ch-tech-factsheet]]. Swiss DSG/Art. 321 removed.

The SharePoint MCP returns text only, not the .pptx binary, so Mahyar has to download files into ~/Downloads. No LibreOffice is installed: render through PowerPoint via AppleScript, using files in ~/Library/Containers/com.microsoft.Powerpoint/Data/Documents/ (the sandbox blocks /tmp). A corrupt deck leaves PowerPoint stuck on a modal dialog that only Mahyar can dismiss, so always validate before rendering.

Draft v2 (27 Oct, replaces v1, 17 slides). Mahyar's decisions: no "offered to the Gulf" wording, so "made in Europe / built to European standards" replaces "for the European market". Pricing slide removed. No partnership or next-steps slide (Wafa and Jasmin handle that). Legal slides make no UAE compliance claims: German § 203 and GDPR are presented as the standard the product is built to. The fact sheet says other jurisdictions' data-residency rules are "assessed per project". Slide 11 now says "zero data retention at the AI model provider" instead of "no data storage with third-party services", which was false because Google Cloud stores conversations. UAE health-data law (Federal Law No. 2/2019, Art. 13) by default bars storing or processing UAE health data abroad; Ministerial Resolution 51/2021 adds exceptions with conditions. Official English badges come from developer.apple.com (sandbox DNS blocks tools.applemarketingtools.com) and play.google.com.

**Why:** the deck goes to an external UAE contact via Wafa and Jasmin, so every claim must hold up outside the EU.
**How to apply:** build on the latest draft (v5). Do not reuse § 203 framing for UAE without legal input.

Draft v3 (27 Oct): adds slide 5, "The experts behind the knowledge": 3,200+ speakers (Mahyar's figure) and 60+ scientific board members. The website boards count DE 49, AT 14, CH 5, so "tens per country" is not true for CH. Eight university-hospital chips. Build tools are in the session scratchpad (tools/translate.py, tweaks.py, expert_slide.py, build.sh), which is not persistent; only the .pptx is in the repo folder.

Draft v4 (27 Oct, 19 slides): adds slide 15, "Flexible to expand to new countries – such as the UAE", placed before the closing slide. It has two cards: hosting (EU today, deployable in other regions, in-country hosting for data-residency rules) and medical knowledge (national/regional guidelines can be added and are prioritised locally). Footnote: scope is agreed per country and partner. Mahyar explicitly offers regional and in-country hosting for the UAE, which differs from the CH deck's "EU only, no Swiss hosting" stance.

Draft v5 (28 Oct): fixes for Mahyar's viewer, which uses a different font and ignores wrap="none". Section kickers now use wide (8") wrapping boxes. Comparison table: last row is one line ("GDPR-compliant; zero data retention at the AI model provider"), with the stray <a:br/> removed, and the dangling * is gone. The expert-lecture slide no longer re-introduces FOMF. Slide 4 now says "continuing medical education and specialist training" (Mahyar didn't want "postgraduate").
