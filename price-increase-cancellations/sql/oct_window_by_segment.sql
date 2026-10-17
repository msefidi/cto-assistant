-- Paste base.sql in front. Share of memberships still renewing at D-60 that cancel at D-60..D-32 (the month after the notice email),
-- Oct 2026 renewals vs baseline renewals Oct 2025 - Sep 2026, by first/later renewal and by country x type.
, k AS (SELECT IF(exp_d<'2026-10-01','base','oct26') g, IF(state='NEWLY_CREATED','First renewal','Later renewal') ren,
               CONCAT(country,' · ',membership_type) seg, lead
        FROM b WHERE exp_d BETWEEN '2025-10-01' AND '2026-10-31' AND (lead IS NULL OR lead<=60))
SELECT 'ren' dim, ren v,
  ROUND(100*SAFE_DIVIDE(COUNTIF(g='oct26' AND lead BETWEEN 32 AND 60),COUNTIF(g='oct26')),1) oct26, COUNTIF(g='oct26') n_oct,
  ROUND(100*SAFE_DIVIDE(COUNTIF(g='base' AND lead BETWEEN 32 AND 60),COUNTIF(g='base')),1) base, COUNTIF(g='base') n_base
FROM k GROUP BY 1,2
UNION ALL
SELECT 'seg', seg,
  ROUND(100*SAFE_DIVIDE(COUNTIF(g='oct26' AND lead BETWEEN 32 AND 60),COUNTIF(g='oct26')),1), COUNTIF(g='oct26'),
  ROUND(100*SAFE_DIVIDE(COUNTIF(g='base' AND lead BETWEEN 32 AND 60),COUNTIF(g='base')),1), COUNTIF(g='base')
FROM k GROUP BY 1,2
UNION ALL
SELECT 'all','All',
  ROUND(100*SAFE_DIVIDE(COUNTIF(g='oct26' AND lead BETWEEN 32 AND 60),COUNTIF(g='oct26')),1), COUNTIF(g='oct26'),
  ROUND(100*SAFE_DIVIDE(COUNTIF(g='base' AND lead BETWEEN 32 AND 60),COUNTIF(g='base')),1), COUNTIF(g='base')
FROM k
ORDER BY 1,4 DESC
