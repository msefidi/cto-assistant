---
name: office-files-render
description: "How to read and render .pptx/.docx here: SharePoint connector gives text only; render through PowerPoint via AppleScript in its sandbox folder; validate first"
metadata:
  type: reference
---

- The SharePoint connector returns text only, not the .pptx or .docx binary. Mahyar downloads the file into ~/Downloads when the binary is needed.
- No LibreOffice is installed. Render decks through PowerPoint via AppleScript, with the files in ~/Library/Containers/com.microsoft.Powerpoint/Data/Documents/ (the sandbox blocks /tmp).
- A corrupt deck leaves PowerPoint stuck on a dialog that only Mahyar can close, so validate the file before rendering.
- Mahyar's viewer uses a different font and ignores wrap="none": use wide text boxes that wrap.

**Why:** learned building the UAE deck (Oct 2026, `archive/eviplex-uae-pitch/`).
