---
name: sponsor-briefing
description: "Erstellt ein einseitiges Sponsor-Briefing als Word-Dokument für einen Termin mit einem Pharma-Sponsor. Nutzt HubSpot (Deals, Termine mit Gesprächsnotizen) und Metabase (Performance gesponserter Vorträge, Publikum nach Fachrichtung) und schlägt passende FOMF-Formate für das nächste Jahr vor. Auslöser: \"Briefing für Sponsor X\", \"bereite mich auf meinen Termin mit X vor\", \"Sponsor-Briefing\"."
---

# Sponsor-Briefing

Du bereitest eine Sales-Managerin oder einen Sales-Manager von FOMF auf einen Termin mit einem Pharma-Sponsor vor. Ergebnis ist immer ein Word-Dokument in der FOMF-Struktur unten, maximal zwei Seiten, auf Deutsch.

## Ablauf

1. **Sponsor finden.** HubSpot-Firma per Namenssuche (z. B. "GSK" → "GlaxoSmithKline GmbH & Co. KG"). Gibt es mehrere Länder-Gesellschaften (DE, AT, CH), nimm die des Fragenden und erwähne die anderen in einer Zeile. Zähle nur Deals aus der Pipeline dieses Landes (z. B. Sales Deutschland) und lass Termine mit anderen Länder-Gesellschaften weg, auch wenn sie an derselben Firma hängen.
2. **Deals holen** (HubSpot, Deals der Firma, `createdate` ODER `closedate` in den letzten 12 Monaten: zwei filterGroups). Stage-IDs mit `references/datenquellen.md` übersetzen. Gruppiere nach Therapiegebiet aus dem Deal-Namen (Impfen, Pneumologie, Hämato/Onko, …).
3. **Termine holen** (HubSpot, Meetings der Firma, letzte 12 Monate, neueste zuerst). Die Gesprächsnotizen stehen im Feld `hs_meeting_body` als HTML: Text extrahieren, Teams-Einwahldaten und E-Mail-Signaturen ignorieren.
4. **Performance holen** (Metabase, Datenbank "Bigquery (fomf-dl)"): die zwei SQL-Abfragen aus `references/datenquellen.md` mit dem exakten Sponsor-Namen aus Metabase, Abfrage 2 zusätzlich je Therapiegebiet (Filter dort beschrieben).
5. **Formate vorschlagen** mit `references/format-katalog.md` und den Regeln unten.
6. **Word-Dokument schreiben** in der Struktur unten.

## Regeln für Vorschläge

- Schlage nur Formate aus dem Katalog vor, mit ihrem FOMF-Namen (Refresher, Studien- und Kongressupdate, WebUp Experten-Forum, WebUp im Fokus, Welttag-Spezial, Video Multichannel +, SummedUp, FOMF Compact, Fortbildungsforum +, Kontakt-Opt-In, Mirrorstream). Nenne, wo es passt, einen konkreten Termin 2027 aus dem Katalog..
- Begründe jeden Vorschlag mit einer Zahl aus Metabase oder einem Zitat aus einer Gesprächsnotiz.
- Werte jedes Therapiegebiet für sich aus: Zuschauer pro Vortrag und Anteil der Zielfachrichtung im Publikum (z. B. Hämatolog:innen bei Hämato/Onko). Kleine Reichweite mit hohem Zielanteil ist ein Erfolg, kein Problem. Vergleiche nie Spezialgebiete mit Hausarzt-Reichweiten.
- Schlage mindestens ein Format aus dem Katalog vor, das der Sponsor noch nicht gebucht hat (z. B. WebUp im Fokus, FOMF Compact, Kontakt-Opt-In), mit der Reichweitenzahl aus dem Katalog.
- Respektiere, was der Sponsor abgelehnt hat (steht in den Notizen, z. B. "kein Interesse an CME-Formaten"). Refresher, Studien- und Kongressupdate und Experten-Forum sind CME-Formate: Lehnt das Team CME ab, schlage WebUp im Fokus, SummedUp oder Video Multichannel + vor.
- Widersprechen sich HubSpot und Metabase (z. B. Vortrag in Metabase geplant, Deal in HubSpot abgesagt), nenne das neutral unter "Offene Punkte".
- Leite fällige Wiedervorlagen aus den Notizen ab ("in 3 Monaten nachfragen" → Datum ausrechnen).

## Struktur des Dokuments

1. **Titel:** "Sponsor-Briefing: <Sponsor> (<Land>)", darunter Stand-Datum, Quellen, Account-Owner, Hinweis "Ohne Preise und Beträge".
2. **Auf einen Blick:** 4 Bulletpoints (Reichweite, Muster, Pipeline, Timing), jeder mit einer Zahl.
3. **Status in HubSpot:** Tabelle Therapiegebiet × (gebucht, offen, abgesagt). In "offen" die Stage dazuschreiben (z. B. "Mündliche Zusage").
4. **Performance gesponserter Vorträge:** Top 5 und die 2 schwächsten Vorträge mit Format, Datum, Zuschauern; eine Zeile Publikum nach Fachrichtung. Vergangene Vorträge ohne Zuschauerdaten zählen als Vortrag, aber nicht in Durchschnitten.
5. **Was der Sponsor zuletzt gesagt hat:** je Therapiegebiet 2–3 Sätze aus den Notizen, mit Datum.
6. **Gesprächspunkte:** 3–4 nummerierte Punkte mit konkretem Formatvorschlag und Begründung.
7. **Offene Punkte:** Checkliste der Wiedervorlagen aus den Notizen.

**Vorlage:** Erzeuge das Dokument immer aus `assets/fomf-vorlage.docx` in diesem Skill-Ordner (FOMF-Logo, Kopf- und Fußzeile, Farben). Mit python-docx: `Document("<Skill-Ordner>/assets/fomf-vorlage.docx")`, dann den Inhalt anhängen. Formatvorlagen:
- Titel: `Title`; Stand, Quellen, Account-Owner: `Subtitle`
- Abschnitte: `Heading 1`; Aufzählungen: `List Bullet` bzw. `List Number`
- Datenhinweise ("nicht validiert", Zeitraum): `Hinweis`
- Tabellen: `style="FOMF Tabelle"` (Kopfzeile hellblau, feine Linien)

Keine eigenen Farben oder Schriften setzen, Kopf- und Fußzeile nicht ändern. Dateiname: `Sponsor-Briefing_<Sponsor>_<JJJJ-MM-TT>.docx`.

## Was nie ins Briefing kommt

- Preise, Beträge, Rabatte, Vertragskonditionen (auch nicht aus Deal-Namen oder Notizen übernehmen).
- E-Mail-Adressen, Telefonnummern und Einwahldaten.
- Namen von Personen beim Sponsor. Immer nur die Rolle nennen ("Medical Affairs Lead Immunologie", "Ansprechpartnerin Impfen"). Das Briefing wird auch am Beamer oder in geteilten Ordnern gezeigt.
- CRM-Pflege. Veraltete oder doppelte Deals (siehe `references/datenquellen.md`) nicht zählen, nicht einzeln aufzählen und nicht kommentieren. Höchstens eine neutrale Zeile unter "Offene Punkte": "HubSpot: <n> ältere oder doppelte Deals nicht berücksichtigt."
- Vermutungen über Gründe. Absagen sachlich mit dem Grund aus HubSpot nennen; steht keiner drin, "ohne Angabe von Gründen".
- Daten zu einzelnen Ärzt:innen. Nur Summen und Anteile.

Kennzeichne Metabase-Zahlen als "nicht validiert". Fehlt eine Quelle, schreib das in einer Zeile, statt zu raten.

## Immer gleich

- Zeitraum: die letzten 12 Monate bis heute, für Deals, Termine und Vorträge. Keine Jahresvergleiche.
- Alle sieben Abschnitte der Struktur, in dieser Reihenfolge, auch wenn Daten fehlen (dann eine Zeile, warum).
- Metabase nur über die Abfragen in `references/datenquellen.md` (Abfrage 2 auch je Therapiegebiet), keine eigenen Tabellen suchen.
