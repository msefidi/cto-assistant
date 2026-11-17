-- Paste 00_base.sql in front. Data date 16 Nov 2026 (last complete day; table loaded to 17 Nov ~11:00).
-- Per group: renewals, cancelled before D-60, at risk at D-60, cancelled D-60..D-0 within the observed window.
-- Observed window per renewal: lead between GREATEST(0, exp_d - 16 Nov 2026) and 60. For baseline/2025 rows the same
-- window is applied by calendar position (day-of-year relative to 16 Nov of the renewal's own year), so Nov is matched timing.
, k AS (SELECT CASE WHEN exp_d BETWEEN '2025-10-01' AND '2026-09-30' THEN 'base Oct25-Sep26'
                    WHEN exp_d BETWEEN '2026-10-01' AND '2026-10-15' THEN '2026 a 1-15 Oct'
                    WHEN exp_d BETWEEN '2026-10-16' AND '2026-10-31' THEN '2026 b 16-31 Oct'
                    WHEN exp_d BETWEEN '2026-11-01' AND '2026-11-30' THEN '2026 c Nov' END grp,
               exp_d, lead, IF(state='NEWLY_CREATED','first','later') ren
        FROM b
        UNION ALL
        SELECT CASE WHEN exp_d BETWEEN '2025-10-01' AND '2025-10-15' THEN '2025 a 1-15 Oct'
                    WHEN exp_d BETWEEN '2025-10-16' AND '2025-10-31' THEN '2025 b 16-31 Oct'
                    WHEN exp_d BETWEEN '2025-11-01' AND '2025-11-30' THEN '2025 c Nov' END,
               exp_d, lead, IF(state='NEWLY_CREATED','first','later')
        FROM b),
w AS (SELECT *, GREATEST(0, DATE_DIFF(exp_d, DATE(EXTRACT(YEAR FROM exp_d),11,16), DAY)) obs_lead,
             GREATEST(0, DATE_DIFF(DATE(2026,EXTRACT(MONTH FROM exp_d),EXTRACT(DAY FROM exp_d)), DATE(2026,11,16), DAY)) nov_lead
      FROM k WHERE grp IS NOT NULL)
SELECT grp, ren, COUNT(*) renewals,
  COUNTIF(lead>60) canc_before_d60, ROUND(100*COUNTIF(lead>60)/COUNT(*),1) pct_before_d60,
  COUNTIF(lead IS NULL OR lead<=60) at_risk_d60,
  COUNTIF(lead BETWEEN 0 AND 60) canc_d60_d0_full, ROUND(100*COUNTIF(lead BETWEEN 0 AND 60)/COUNTIF(lead IS NULL OR lead<=60),1) pct_d60_d0_full,
  ROUND(100*COUNTIF(lead BETWEEN 0 AND 60)/COUNT(*),1) pct_all_before_renewal_of_renewals,
  ROUND(100*COUNTIF(lead IS NOT NULL)/COUNT(*),1) pct_any_lead_of_renewals
FROM (SELECT * FROM w UNION ALL SELECT * REPLACE('all' AS ren) FROM w)
GROUP BY 1,2 ORDER BY 2,1
