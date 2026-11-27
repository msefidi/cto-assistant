# Eviplex pricing: log

Newest first. One entry per event or result. Decisions go in `decisions.md`, one line each. Each entry ends with who said it and where, in brackets. Summarise the source; the original stays where it is.

## 2026-11-27: Student package details settled

Mahyar settled the open points (decision line of 27 Nov). The in-app pricing page already shows the All Access offer as a block above the plans (`FomfBenefitOffers` in `pricing-page.tsx`); the student package is to follow that pattern. Filed as EVP-1385 (Backlog, assigned to Mahyar); it states the student quota, since the team builds it. (Mahyar, session; meviq `origin/main` 27 Nov)

## 2026-11-26: Student package decided

A free Eviplex package for students enrolled in a FOMF PJ, KPJ or WSJ programme, with 50 questions per month, is to appear on the pricing page. The meviq backend already grants tiers from outside Stripe (FOMF group entitlement provider, access grants), so a student tier can follow that path; the pricing page today shows only Free, Plus and Pro from `plan-content.ts`. (Mahyar, session; meviq `origin/main` 26 Nov)

## 2026-11-26: Topic opened

Opened from board task CTO-30 ("Follow up on the Eviplex price change", created 25 Nov, due 27 Nov); CTO-16 ("Fix the pricing of Eviplex for annual payments", from Todoist, 12 Nov) became its sub-issue. Neither issue had comments. (session with Mahyar)

## 2026-11-25: Cost check of the proposal

At 10 ct per question with the whole quota used, every tier keeps a margin of 42–59 % of the net price; the lowest break-even is Pro DE/AT yearly at 17 ct per question. Tables in the brief. No in-app purchase code in the meviq repo, so no app-store cut assumed. (session with Mahyar)

## 2026-11-25: Proposal from the talk with Wafa

Mahyar and Wafa discussed lower prices and quotas: Free from 30 to 15 questions ("not such a big deal"), Plus DE/AT €19.90 / €199.90 with 75 questions, Plus CH CHF 39.90 / 405.90 with 150, Pro DE/AT €72.90 / €742.90 and Pro CH CHF 72.90 / 742.90 with 300. Not decided. (Mahyar, spreadsheet screenshot in the session)
