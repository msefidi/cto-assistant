# Datenquellen

## HubSpot

**Firma:** Suche nach Name in COMPANY. Sponsoren haben pro Land eine eigene Firma (z. B. GlaxoSmithKline GmbH & Co. KG = DE, GlaxoSmithKline Pharma GmbH = AT, GlaxoSmithKline AG = CH).

**Deals:** DEAL, verknüpft mit der Firma, `createdate` in den letzten 12 Monaten. Felder: `dealname`, `dealstage`, `pipeline`, `closedate`, `hubspot_owner_id`, `closed_lost_reason`. Nie `amount` abfragen.

Pipelines und Stages (Sponsoring):

| Pipeline | ID | Übersichtsangebot | Angebotserstellung | Angebot gesendet | Mündliche Zusage | Gewonnen | Absage |
|---|---|---|---|---|---|---|---|
| Sales Deutschland | 1097285874 | 5866077412 | 1525033187 | 1525033189 | 1525033190 | 1525033192 | 1525033193 |
| Sales Schweiz | 1097285877 | 5866073284 | 1525034171 | 1525034173 | 1525034174 | 1525034176 | 1525034177 |
| Sales Österreich | 1097285878 | 5866079467 | 1525034179 | 1525034181 | 1525034182 | 1525034184 | 1525034185 |

Deal-Namen folgen dem Muster `<Firma> - PS<Jahr>-<Nr> <Sponsor> (<Therapiegebiet>) <Format> <Ort/Monat>`. "Option" im Namen = noch nicht fixiert; eine Option ohne Datum und ohne `closedate` zählt als offen.

**Veraltete Deals, nicht als offenes Angebot zählen:**
- offene Stage, aber Veranstaltung (Ort/Monat im Namen) oder `closedate` liegt in der Vergangenheit
- Deal heißt nur wie ein Datum (z. B. "10.01.2025") oder doppelt einen gewonnenen Deal gleichen Namens
- `closed_lost_reason` "Doppelter Eintrag"
- Stage "Gewonnen", aber `closed_lost_reason` oder `closed_lost_reason_note` gefüllt: als unklar behandeln, nicht als gebucht zählen

**Termine:** MEETING, verknüpft mit der Firma, `hs_meeting_start_time` letzte 12 Monate. Felder: `hs_meeting_title`, `hs_meeting_start_time`, `hs_meeting_body`, `hubspot_owner_id`. Die Notizen stehen in `hs_meeting_body` (HTML). Notizen-Objekte (NOTE) sind fast leer, nicht nötig.

**Kommende Termine aller Sponsoren:** MEETING mit `hs_meeting_start_time` zwischen nächstem Montag und Freitag, ohne Firmenfilter. Der Titel nennt meist den Sponsor ("Austausch mit Eli Lilly (Neuro)").

## Metabase (Datenbank "Bigquery (fomf-dl)", ID 2)

Sponsor-Name in Metabase = HubSpot-Firmenname (z. B. `GlaxoSmithKline GmbH & Co. KG`). Sponsoring-Zuordnung immer über `dim_sponsorship`.

Nicht nutzen:
- `dim_sponsored_contents` und `dim_sponsored_schedules`: veraltet (letzter Stand Dezember 2025), daraus folgt fälschlich "keine Vorträge 2026".
- `livestream_viewers` aus `fct_schedule_participation_summary`: zählt FOMF-Mitarbeitende und aus Berichten ausgeschlossene Nutzer mit (GSK Kardiologie-WebUp 03.09.2026: 268 statt 219).
- `dim_users.field_of_activity_name_de_de` als Fachrichtung: das ist der Tätigkeitsbereich (niedergelassen, Klinik).
- `on_site_participants`: immer 0. Vor-Ort-Zahlen gibt es nur pro Veranstaltung, nicht pro Vortrag: nicht berichten.

Zuschauer = eindeutige Personen im Livestream ohne FOMF-Mitarbeitende (`is_fomf_user`) und ohne `exclude_from_participant_reports`. So zählt auch FOMF in Teilnehmerberichten. Zeitraum immer die letzten 12 Monate bis heute, keine Jahresvergleiche.

**1. Vorträge und Zuschauer (vergangen) plus kommende gesponserte Vorträge**

```sql
WITH s AS (
  SELECT DISTINCT schedule_id, type AS paket
  FROM `fomf-dl.analysis.dim_sponsorship`
  WHERE sponsor_name = '<SPONSOR>'
), p AS (
  SELECT s.schedule_id, s.paket, p.content_short_title AS reihe, p.content_type AS format,
    DATE(p.schedule_start_date_time) AS datum, p.schedule_title AS vortrag,
    p.schedule_start_date_time >= CURRENT_TIMESTAMP() AS kommend
  FROM s
  JOIN `fomf-dl.analysis.fct_schedule_participation_summary` p ON p.schedule_id = s.schedule_id
  WHERE p.schedule_start_date_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 365 DAY)
    AND IFNULL(p.content_is_deleted, FALSE) = FALSE
), z AS (
  SELECT e.schedule_id, COUNT(DISTINCT e.user_id) AS zuschauer
  FROM `fomf-dl.analysis.fct_live_schedule_watch_events` e
  JOIN `fomf-dl.analysis.dim_users` u ON u.user_id = e.user_id
  WHERE e.schedule_id IN (SELECT schedule_id FROM p)
    AND IFNULL(e.is_fomf_user, FALSE) = FALSE
    AND IFNULL(u.exclude_from_participant_reports, FALSE) = FALSE
  GROUP BY 1
)
SELECT p.kommend, p.datum, p.reihe, p.format, p.paket, p.vortrag, z.zuschauer
FROM p LEFT JOIN z USING (schedule_id)
ORDER BY p.kommend, p.datum DESC
```

`format`: WEBINAR = WebUp (online), ONDEMAND_COURSE = Refresher (Präsenzkurs mit Livestream), LIVE_COURSE = Präsenzkurs. Enthält `reihe` "Experten-Forum", ist das Format Experten-Forum. Leere `zuschauer` bei einem vergangenen Vortrag heißt: keine Livestream-Daten, nicht "niemand". Kommende Vorträge (`kommend` = true) als eigene Zeile im Briefing nennen.

**2. Publikum nach Fachrichtung (eindeutige Ärzt:innen, gleiche Ausschlüsse)**

```sql
WITH s AS (
  SELECT DISTINCT schedule_id FROM `fomf-dl.analysis.dim_sponsorship`
  WHERE sponsor_name = '<SPONSOR>'
), w AS (
  SELECT DISTINCT e.user_id
  FROM `fomf-dl.analysis.fct_live_schedule_watch_events` e
  JOIN s ON s.schedule_id = e.schedule_id
  JOIN `fomf-dl.analysis.fct_schedule_participation_summary` p ON p.schedule_id = e.schedule_id
  JOIN `fomf-dl.analysis.dim_users` u ON u.user_id = e.user_id
  WHERE p.schedule_start_date_time >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 365 DAY)
    AND p.schedule_start_date_time < CURRENT_TIMESTAMP()
    AND IFNULL(e.is_fomf_user, FALSE) = FALSE
    AND IFNULL(u.exclude_from_participant_reports, FALSE) = FALSE
), t AS (SELECT COUNT(*) AS n FROM w)
SELECT TRIM(f) AS fachrichtung, COUNT(DISTINCT w.user_id) AS aerzte,
  ROUND(100 * COUNT(DISTINCT w.user_id) / ANY_VALUE(t.n), 1) AS anteil, ANY_VALUE(t.n) AS gesamt
FROM w
JOIN `fomf-dl.analysis.dim_users` u ON u.user_id = w.user_id
CROSS JOIN t
CROSS JOIN UNNEST(SPLIT(IFNULL(u.specialty_v2_name_de_de, '(keine Angabe)'), ',')) AS f
GROUP BY 1 ORDER BY 2 DESC LIMIT 8
```

`specialty_v2_name_de_de` kann mehrere Fachrichtungen mit Komma enthalten (rund 7 % der Nutzer), daher das `SPLIT`.

**Zielanteil je Therapiegebiet:** Abfrage 2 je Gebiet wiederholen, in `w` mit zusätzlichem Filter auf die Reihe, z. B. `AND (p.content_short_title LIKE '%Hämato%' OR p.content_short_title LIKE '%Onko%')`. Zielanteil = Anteil der passenden Fachrichtung (z. B. "Innere Medizin und Hämatologie und Onkologie"). Eine Person kann in mehreren Fachrichtungen zählen: im Briefing "Mehrfachnennung möglich" dazuschreiben. `gesamt` = eindeutige Zuschauer insgesamt.
