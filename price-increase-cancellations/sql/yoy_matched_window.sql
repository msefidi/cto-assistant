-- Paste base.sql in front. YoY at matched timing: renewal-date groups one year apart, cancellations from D-60 up to the lead
-- that 2026 renewals have reached on 30 Sep 2026 (lead >= days from 30 Sep to the renewal day, same day-of-year for 2025).
, k AS (SELECT EXTRACT(YEAR FROM exp_d) yr,
          CASE WHEN FORMAT_DATE('%m-%d',exp_d) BETWEEN '10-01' AND '10-15' THEN 'a 1-15 Oct'
               WHEN FORMAT_DATE('%m-%d',exp_d) BETWEEN '10-16' AND '10-31' THEN 'b 16-31 Oct'
               WHEN FORMAT_DATE('%m',exp_d)='11' THEN 'c Nov' END grp,
          DATE_DIFF(DATE(EXTRACT(YEAR FROM exp_d),EXTRACT(MONTH FROM exp_d),EXTRACT(DAY FROM exp_d)), DATE(EXTRACT(YEAR FROM exp_d),9,30), DAY) obs_lead,
          lead
        FROM b WHERE EXTRACT(YEAR FROM exp_d) IN (2025,2026))
SELECT grp, yr, COUNT(*) renewals, COUNTIF(lead>60) cancelled_before_d60,
       COUNTIF(lead IS NULL OR lead<=60) at_risk_d60, COUNTIF(lead BETWEEN obs_lead AND 60) cancelled_d60_to_now,
       ROUND(100*COUNTIF(lead BETWEEN obs_lead AND 60)/COUNTIF(lead IS NULL OR lead<=60),1) pct_d60_to_now,
       COUNTIF(lead BETWEEN 0 AND obs_lead-1) y2025_rest_until_renewal
FROM k WHERE grp IS NOT NULL GROUP BY 1,2 ORDER BY 1,2
