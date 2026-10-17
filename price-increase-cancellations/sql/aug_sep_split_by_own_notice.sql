-- Paste base.sql in front. Oct-Dec renewals, cancellations made 3 Aug - 27 Sep (2025: 3 Aug - 26 Sep), split by whether the member
-- had already received their own notice (sent daily to renewals exactly 60 days out → lead <= 60).
SELECT EXTRACT(YEAR FROM exp_d) yr, FORMAT_DATE('%m',exp_d) ren_month, COUNTIF(lead<=60) after_own_notice, COUNTIF(lead>60) before_own_notice, COUNT(*) total
FROM b WHERE c_d BETWEEN DATE(EXTRACT(YEAR FROM exp_d),8,3) AND DATE(EXTRACT(YEAR FROM exp_d),9,27) - IF(EXTRACT(YEAR FROM exp_d)=2025,1,0)
  AND lead>=0 AND EXTRACT(MONTH FROM exp_d)>=10 AND EXTRACT(YEAR FROM exp_d) IN (2025,2026)
GROUP BY 1,2 ORDER BY 2,1
