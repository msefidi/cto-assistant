-- Paste base.sql in front. Share of memberships still renewing at D-60 that cancel between D-60 and "today-aligned" lead
-- (dom = day of month; Oct-aligned window [dom,60], Nov-aligned [dom+31,60]; data date 30 Sep 2026). Baseline = renewals Oct 2025 - Sep 2026.
, k AS (SELECT IF(exp_d<'2026-10-01','base Oct25-Sep26',FORMAT_DATE('%Y-%m',exp_d)) g, EXTRACT(DAY FROM exp_d) dom, lead,
               IF(state='NEWLY_CREATED','first','later') ren
        FROM b WHERE exp_d BETWEEN '2025-10-01' AND '2026-11-30')
SELECT g, ren, COUNT(*) n, COUNTIF(lead IS NULL OR lead<=60) at_risk,
 COUNTIF(lead BETWEEN dom AND 60) oct_c, ROUND(100*COUNTIF(lead BETWEEN dom AND 60)/COUNTIF(lead IS NULL OR lead<=60),2) oct_like,
 COUNTIF(lead BETWEEN dom+31 AND 60) nov_c, ROUND(100*COUNTIF(lead BETWEEN dom+31 AND 60)/COUNTIF(lead IS NULL OR lead<=60),2) nov_like
FROM (SELECT * FROM k UNION ALL SELECT g, dom, lead, 'all' FROM k) GROUP BY 1,2 ORDER BY 2,1
