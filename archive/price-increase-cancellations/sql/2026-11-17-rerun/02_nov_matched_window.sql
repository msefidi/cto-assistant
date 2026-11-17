-- Paste 00_base.sql in front. November 2026 renewals are only partly observed on 16 Nov 2026.
-- For a renewal on day dom of the month, cancellations from D-60 to D-max(0, dom-16) are observed.
-- Same window (by dom) applied to the baseline (renewals Oct 2025 - Sep 2026) and to Nov 2025 renewals.
, k AS (SELECT CASE WHEN exp_d BETWEEN '2025-10-01' AND '2026-09-30' THEN 'base Oct25-Sep26 (dom-matched)'
                    WHEN exp_d BETWEEN '2026-11-01' AND '2026-11-30' THEN '2026 Nov'
                    END grp, EXTRACT(DAY FROM exp_d) dom, lead, exp_d FROM b
        UNION ALL
        SELECT IF(exp_d BETWEEN '2025-11-01' AND '2025-11-30','2025 Nov',NULL), EXTRACT(DAY FROM exp_d), lead, exp_d FROM b)
SELECT grp, COUNTIF(lead IS NULL OR lead<=60) at_risk_d60,
  COUNTIF(lead BETWEEN GREATEST(0,dom-16) AND 60) canc_observed_window,
  ROUND(100*COUNTIF(lead BETWEEN GREATEST(0,dom-16) AND 60)/COUNTIF(lead IS NULL OR lead<=60),2) pct_observed_window,
  COUNTIF(lead BETWEEN 0 AND 60) canc_full_window,
  ROUND(100*COUNTIF(lead BETWEEN 0 AND 60)/COUNTIF(lead IS NULL OR lead<=60),2) pct_full_window,
  COUNTIF(dom<=16 AND (lead IS NULL OR lead<=60)) at_risk_fully_observed
FROM k WHERE grp IS NOT NULL GROUP BY 1 ORDER BY 1
