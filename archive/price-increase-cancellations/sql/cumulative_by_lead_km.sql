-- Paste base.sql in front. Cumulative share cancelled from D-60 to D-L (Kaplan-Meier over lead days, handles partly observed renewals).
-- At risk at lead L: not cancelled earlier (lead IS NULL OR lead <= L) and day exp_d - L already reached on the data date.
, g AS (SELECT CASE WHEN exp_d BETWEEN '2025-10-01' AND '2026-09-30' THEN 'base'
                    WHEN exp_d BETWEEN '2026-10-01' AND '2026-10-15' THEN 'oct_early'
                    WHEN exp_d BETWEEN '2026-10-16' AND '2026-10-31' THEN 'oct_late'
                    WHEN exp_d BETWEEN '2026-11-01' AND '2026-11-30' THEN 'nov' END grp,
               exp_d, lead
        FROM b WHERE (lead IS NULL OR lead <= 60)),
d AS (SELECT L FROM UNNEST(GENERATE_ARRAY(0,60)) L)
SELECT grp, L, COUNTIF((lead IS NULL OR lead <= L) AND DATE_SUB(exp_d, INTERVAL L DAY) <= DATE '2026-09-30') at_risk,
       COUNTIF(lead = L AND DATE_SUB(exp_d, INTERVAL L DAY) <= DATE '2026-09-30') ev
FROM g CROSS JOIN d WHERE grp IS NOT NULL GROUP BY 1,2 ORDER BY 1,2 DESC
