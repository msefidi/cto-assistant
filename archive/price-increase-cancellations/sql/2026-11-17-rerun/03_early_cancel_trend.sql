-- Paste 00_base.sql in front. Cancellations made more than 60 days before renewal, as a share of renewals, per renewal month.
-- Fully observed for renewals up to 15 Jan 2027 (D-60 reached by 16 Nov 2026). Future months still contain rows that will
-- later drop out of the state filter (NOT_PAID/REVOKED), so their denominator is slightly high.
SELECT FORMAT_DATE('%Y-%m', exp_d) ren_month, COUNT(*) renewals, COUNTIF(lead>60) canc_before_d60,
       ROUND(100*COUNTIF(lead>60)/COUNT(*),1) pct_before_d60,
       ROUND(100*COUNTIF(lead>60 AND state='NEWLY_CREATED')/NULLIF(COUNTIF(state='NEWLY_CREATED'),0),1) pct_first,
       ROUND(100*COUNTIF(lead>60 AND state<>'NEWLY_CREATED')/NULLIF(COUNTIF(state<>'NEWLY_CREATED'),0),1) pct_later
FROM b WHERE exp_d BETWEEN '2025-07-01' AND '2027-01-15'
GROUP BY 1 ORDER BY 1
