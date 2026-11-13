"""Builds the level-1 backup briefing (GSK DE) from the 17 Oct 2026 dry-run data."""
import sys
from docx import Document
from docx.shared import Pt, RGBColor, Cm
from docx.enum.text import WD_ALIGN_PARAGRAPH

out = sys.argv[1]
NAVY = RGBColor(0x1F, 0x3A, 0x5F)
GREY = RGBColor(0x66, 0x66, 0x66)

d = Document()
for s in d.sections:
    s.left_margin = s.right_margin = Cm(2)
    s.top_margin = s.bottom_margin = Cm(1.6)
st = d.styles["Normal"]
st.font.name = "Arial"
st.font.size = Pt(10)


def h(text, size=13):
    p = d.add_paragraph()
    r = p.add_run(text)
    r.bold = True
    r.font.size = Pt(size)
    r.font.color.rgb = NAVY
    p.paragraph_format.space_before = Pt(8)
    p.paragraph_format.space_after = Pt(3)


def bullet(text, bold_lead=None):
    p = d.add_paragraph(style="List Bullet")
    if bold_lead:
        p.add_run(bold_lead).bold = True
    p.add_run(text)
    p.paragraph_format.space_after = Pt(1)


def table(rows, widths):
    t = d.add_table(rows=len(rows), cols=len(rows[0]))
    t.style = "Light Grid Accent 1"
    for i, row in enumerate(rows):
        for j, val in enumerate(row):
            c = t.cell(i, j)
            c.text = str(val)
            for p in c.paragraphs:
                for r in p.runs:
                    r.font.size = Pt(9)
                    r.bold = i == 0
            c.width = Cm(widths[j])
    d.add_paragraph().paragraph_format.space_after = Pt(0)


p = d.add_paragraph()
r = p.add_run("Sponsor-Briefing: GlaxoSmithKline (DE)")
r.bold = True
r.font.size = Pt(18)
r.font.color.rgb = NAVY
p = d.add_paragraph()
r = p.add_run("Stand 17.10.2026 · Quellen: HubSpot (Deals, Termine), Metabase (Vortrags-Performance) · "
              "Account: Alexander Bielau · Ohne Preise und Beträge")
r.font.size = Pt(8.5)
r.font.color.rgb = GREY

h("Auf einen Blick")
bullet(" 21 gesponserte Vorträge in DE in 12 Monaten, 1.821 verschiedene Ärzt:innen erreicht, "
       "im Schnitt 104 Livestream-Zuschauer pro Vortrag.", "Reichweite:")
bullet(" Impfen in Hausarzt-, Innere- und Kardiologie-WebUps läuft am besten (bis 268 Zuschauer). "
       "Hämato/Onko-Vorträge in Präsenzkursen erreichen nur 30–60.", "Muster:")
bullet(" 4 offene Angebote für 2027 (Impfstoff-Pipeline, Pneumologie, Hämatologie, HO Refresher Stuttgart) "
       "plus 1 Übersichtsangebot Hämatologie.", "Pipeline:")
bullet(" GSK plant gerade Budgets 2027 (Impfen) und will in der Hämatologie 2027 „alle Kanäle bespielen“.",
       "Timing:")

h("Status in HubSpot")
table([
    ["Bereich", "Gebucht 2026", "Offen für 2027", "Abgesagt"],
    ["Impfen", "Jungärzte Refresher 09.26, Rheuma/Nephro Refresher München 12.26, "
               "WebUp Experten-Forum Pädiatrie 10.26",
     "PS2027-110 Impfstoff-Pipeline Formate 2027 (Angebot gesendet 07.10.)", "–"],
    ["Pneumologie / HNO", "SummedUps + Multichannel+ 2026; Mirrorstream 12.26 mündlich zugesagt",
     "PS2027-066 Kooperationsmöglichkeiten 2027", "–"],
    ["Hämato / Onko", "Formate 2026, HO Gold Köln 2026",
     "PS2027-049.2 (Übersicht), PS2027-089.1, PS2027-088.1 HO Refresher Stuttgart 11.27",
     "HO Refresher Berlin 11.26 (07.10.), Science Camps 2026"],
    ["Österreich (GSK Pharma GmbH)", "WebUp im Fokus Patientenfälle 09.26, PNEUMO Wien 12.26", "–", "–"],
], [3.2, 5.2, 5.2, 3.4])

h("Performance gesponserter Vorträge (DE, Okt 2025 – Okt 2026)")
table([
    ["Vortrag", "Format", "Datum", "Zuschauer"],
    ["Impfungen als Schutzschild (Kardiologie)", "WebUp", "03.09.2026", "268"],
    ["Impfungen 2026: praxisnah (Allgemeinmedizin)", "WebUp", "29.04.2026", "172"],
    ["Impfen unter Immunsuppression (Impfen)", "WebUp", "14.10.2026", "162"],
    ["Update Impfen (Allgemeinmedizin Stuttgart)", "Refresher", "03.12.2025", "132"],
    ["Schweres Asthma (Pneumologie)", "WebUp", "07.10.2026", "130"],
    ["BCMA-Therapie ab 1. Rezidiv (MM Experten-Forum)", "WebUp", "14.09.2026", "47"],
    ["BCMA-Therapien im Rezidiv (Hämato/Onko Frankfurt)", "Refresher", "08.05.2026", "31"],
], [7.8, 2.4, 2.6, 2.2])
p = d.add_paragraph()
r = p.add_run("Publikum (1.821 Ärzt:innen): Allgemeinmedizin 30 %, Innere Medizin 18 %, Kinder- und Jugendmedizin 14 %, "
              "Kardiologie 5 %, Hämatologie/Onkologie 3 %. 36 % niedergelassen, 33 % Klinik, 7 % MVZ. "
              "Zahlen aus Metabase, nicht validiert.")
r.font.size = Pt(8.5)
r.font.color.rgb = GREY

h("Was GSK zuletzt gesagt hat")
bullet(" Neuer Influenza-Impfstoffkandidat (Phase II), evtl. Kombi mit Covid. Zielgruppen Hausärzt:innen, "
       "Apotheker:innen, Pneumologie nachrangig. 2. HJ 2027: 2–3 Formate (AM, AIM, EF Impfen). "
       "Steckt in der Budgetplanung.", "Impfen (06.10.):")
bullet(" 2027 bleiben Pneumo und HNO wichtig. Kurze Formate wie SummedUps sehr interessant, 20 Min. evtl. zu lang. "
       "Mirrorstream zum Atem-Campus-Launch im Herbst spannend. Eine Ansprechperson zweifelt, ob SummedUp + VM+ "
       "2027 der richtige Weg ist.", "Pneumologie (31.08.):")
bullet(" Fokus Blenrep, Hämatolog:innen. Will 2027 alle Kanäle bespielen und ein Angebot über alle Produkte. "
       "Kein Interesse an CME- und DACH-Formaten (Abwicklung zu kompliziert). Webinare mit nationaler Reichweite "
       "prinzipiell interessant.", "Hämato/Onko (24.07. und 18.06.):")
bullet(" Onko-GI interessiert an HO, WebUp EF HO, Gastro und WebUp im Fokus. Medical Affairs Immunologie "
       "neu kennengelernt (DGRH).", "Kongresse (09/2026):")

h("Gesprächspunkte")
bullet(" Hämato/Onko vor Ort erreicht 30–60 Ärzt:innen, Impf-WebUps 100–270. Für Blenrep 2027 ein "
       "nationales WebUp-Format (Experten-Forum oder WebUp im Fokus) neben dem Refresher vorschlagen.",
       "1. Reichweite in der Hämatologie:")
bullet(" Neuer Influenza-Kandidat trifft genau das stärkste Publikum (Allgemeinmedizin 30 %, Innere 18 %). "
       "Angebot PS2027-110 aktiv nachfassen, solange das Budget geplant wird.", "2. Impfstoff-Pipeline:")
bullet(" Zweifel an SummedUp + VM+ offen ansprechen; mit Zahlen aus der Auswertung belegen. "
       "Mirrorstream 12.26 als Brücke zum Atem-Campus nutzen.", "3. Pneumologie absichern:")
bullet(" Nachfrage beim Onko-Lunge-Team war für ca. Ende Oktober vereinbart (Termin 24.07.: „in 3 Monaten“).",
       "4. Fällig:")

h("Offene Punkte nach dem Termin")
for t in ["Hepatitis-B-Unterlagen an die Ansprechperson aus Onko-GI senden (DGVS, 18.09.)",
          "Medical Affairs Immunologie über LinkedIn kontaktieren (DGRH)",
          "Planungsgespräch 2027 mit der Impf-Ansprechperson vereinbaren (Expopharm, nicht vor Ort)"]:
    bullet(" " + t, "☐")

d.save(out)
print("saved", out)
