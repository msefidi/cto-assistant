# Email drafts, 27 Oct 2026

## To Blaze (Jan, cc Carol Galatoli): still assessing + clarifications

**Betreff:** AW: Angebot Security Assessment FomF (#2026.10.030)

Hi Jan,

danke für das Angebot. Wir sind noch in der Bewertung und vergleichen gerade verschiedene Optionen. Euer Angebot ist dabei in der engeren Auswahl.

Für den Vergleich gehen wir aktuell von folgendem Umfang aus:

- Kernumfang laut Angebot (Phase 1 M365, Phase 2 Google Cloud, Phase 3 Pentests Lernplattform und Eviplex, Workshop, Retest)
- Option: External attack surface & OSINT Assessment
- Option: Kubernetes (GKE) Configuration Review für **einen** Cluster, den der Lernplattform

Nach Eurem Angebot wären das 30.299 EUR netto. Damit wir die Entscheidung abschließen können, würde ich gern ein paar Punkte klären:

1. **Anzahl der Endpunkte:** Wir haben die Zahlen noch einmal genauer erhoben. Die Lernplattform ist größer als die 135 Endpunkte im Angebot:
   - Die API ist eine GraphQL-Federation (Apollo) mit 11 Subgraphs. Insgesamt sind das rund 400 Operationen (ca. 170 Queries, ca. 240 Mutations). Davon sind ca. 160 für anonyme oder angemeldete Nutzer erreichbar, ca. 250 sind Admin- bzw. System-Operationen mit Rollenprüfung.
   - Dazu kommen rund 100 REST-Endpunkte (u. a. Webhooks, Stripe und Integrationen) und ca. 15 API-Routen im Next.js-Frontend.
   - Die Plattform besteht aus rund 23 Microservices.
   
   Eviplex liegt mit rund 55 REST-Endpunkten etwas über den angenommenen 40. Davon sind ca. 15 für Nutzer (Chat, Billing) und ca. 37 Admin-Endpunkte.
   
   Bitte prüft, wie sich das auf Aufwand und Preis auswirkt, vor allem bei der Lernplattform. Für uns wäre wichtig, dass die Admin- und System-Operationen zumindest darauf getestet werden, dass normale Nutzer sie nicht aufrufen können.
2. **Eviplex:** Für Web, API, Mobile App (iOS/Android) und den AI-Assistenten sind insgesamt 3 Tage angesetzt. Reicht das aus Eurer Sicht für eine belastbare Abdeckung, vor allem beim AI-Teil? Falls nicht, schickt mir bitte einen Vorschlag mit zusätzlichen Tagen.
3. **Retest:** 4 Stunden für alle Phasen zusammen erscheinen mir knapp. Könnt Ihr den Umfang erhöhen oder mir einen Preis für zusätzliche Retest-Stunden nennen?
4. **Abschlussbesprechung:** Statt eines einstündigen Workshops am Ende hätten wir lieber ein kurzes Debrief nach jeder Phase oder ein längeres Abschluss-Meeting. Bitte gebt mir dafür einen Preis an. Optional interessiert mich auch ein Angebot für einen halbtägigen Workshop zu unserem organisatorischen IT-Sicherheitsmanagement (ISMS).
5. **Datenschutz:** Da Ihr gegen Produktion testet und lesenden Zugriff auf GCP inkl. Data Lake bekommt, brauchen wir zusätzlich zum NDA einen Auftragsverarbeitungsvertrag nach Art. 28 DSGVO. Habt Ihr dafür eine Vorlage, oder sollen wir unsere schicken?
6. **Vertragsgrundlage:** Das Angebot verweist auf Eure MSA „as updated from time to time“. Wir bräuchten die zum Zeitpunkt der Unterschrift gültige Fassung als festen Vertragsbestandteil.
7. **Zeitplan:** Wäre ein Start von Phase 1 noch im November möglich, falls wir uns bis Mitte November entscheiden?
8. **Referenzen:** Könnt Ihr uns einen geschwärzten Beispielbericht schicken und ein bis zwei Referenzkunden nennen, idealerweise aus SaaS oder Healthcare?

Wenn Ihr mir ein aktualisiertes Angebot mit diesem Umfang und Euren Antworten schickt, kann ich die Bewertung abschließen und melde mich zeitnah.

Viele Grüße
Mahyar

---

## To PCG (Alex): decline

**Betreff:** AW: Angebot Security Assessment (SODE26002713)

Hallo Alex,

vielen Dank für das Angebot und die Zeit, die Ihr in die Ausarbeitung gesteckt habt.

Wir haben uns inzwischen für einen anderen Anbieter entschieden. Ausschlaggebend war der Umfang: Wir brauchen neben der Google Cloud auch ein Review unserer Microsoft-365-Umgebung sowie manuelle Penetrationstests beider Produkte, einschließlich der Mobile App und des AI-Assistenten.

Ich melde mich gern wieder, wenn wir in einem der nächsten Schritte Unterstützung brauchen.

Beste Grüße
Mahyar
