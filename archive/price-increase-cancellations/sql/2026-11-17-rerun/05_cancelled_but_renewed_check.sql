-- Paste 00_base.sql in front. Sanity check: of renewals with a renewal cancellation (any lead), how many still got a following
-- B2C membership row starting within 48 h of the expiry (switched back on / renewed anyway). Oct 2025 vs Oct 2026.
, nxt AS (SELECT user_id, started_at FROM `fomf-dl`.platform_raw_membershipservice.public_user_membership
          WHERE (group_membership_id IS NULL OR group_membership_id='') AND (clinic_membership_id IS NULL OR clinic_membership_id='')
            AND state NOT IN ('NOT_PAID','OFFERED_BY_ADMIN'))
SELECT EXTRACT(YEAR FROM exp_d) yr, IF(lead>60,'>D-60','D-60..D-0') when_cancelled, COUNT(*) cancelled,
  COUNTIF(EXISTS(SELECT 1 FROM nxt WHERE nxt.user_id=b.user_id AND ABS(TIMESTAMP_DIFF(nxt.started_at,b.expires_at,HOUR))<=48)) renewed_anyway
FROM b WHERE EXTRACT(MONTH FROM exp_d)=10 AND EXTRACT(YEAR FROM exp_d) IN (2025,2026) AND lead IS NOT NULL
GROUP BY 1,2 ORDER BY 1,2
