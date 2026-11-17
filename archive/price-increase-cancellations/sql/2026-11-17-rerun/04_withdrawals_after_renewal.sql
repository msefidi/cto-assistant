-- Withdrawals (REVOKE_MEMBERSHIP) within 14 days of a renewal, Oct 2025 vs Oct 2026 renewal dates (all windows complete by 14 Nov 2026).
-- A renewal row = paid B2C user membership whose start lies within 48 h of the expiry of an earlier B2C membership of the same user
-- (identifies AUTOMATICALLY_RENEWED / PAID_MANUALLY_AUTOMATICALLY_RENEWED / EARLY_RENEWED rows; REVOKED rows lose their original
-- state, so this predecessor match is the only way to keep withdrawn renewals in the count). NOT_PAID and OFFERED_BY_ADMIN excluded.
WITH um AS (
  SELECT * FROM `fomf-dl`.platform_raw_membershipservice.public_user_membership
  WHERE (group_membership_id IS NULL OR group_membership_id='') AND (clinic_membership_id IS NULL OR clinic_membership_id='')),
ren AS (
  SELECT u.id, u.state, DATE(u.started_at,'Europe/Berlin') s_d, u.started_at
  FROM um u
  WHERE u.state NOT IN ('NOT_PAID','OFFERED_BY_ADMIN')
    AND EXTRACT(MONTH FROM DATE(u.started_at,'Europe/Berlin'))=10 AND EXTRACT(YEAR FROM DATE(u.started_at,'Europe/Berlin')) IN (2025,2026)
    AND EXISTS (SELECT 1 FROM um p WHERE p.user_id=u.user_id AND p.id<>u.id AND ABS(TIMESTAMP_DIFF(p.expires_at,u.started_at,HOUR))<=48)),
r AS (
  SELECT user_membership_id id, MIN(created_at) r_at
  FROM `fomf-dl`.platform_raw_membershipservice.public_membership_cancellation_request
  WHERE cancellation_type='REVOKE_MEMBERSHIP' GROUP BY 1)
SELECT EXTRACT(YEAR FROM s_d) yr, IF(EXTRACT(DAY FROM s_d)<=15,'a 1-15','b 16-31') half, COUNT(*) renewals,
  COUNTIF(state<>'REVOKED') still_active_rows, COUNTIF(state='REVOKED') state_revoked,
  COUNTIF(DATE_DIFF(DATE(r.r_at,'Europe/Berlin'), s_d, DAY) BETWEEN 0 AND 14) withdrawn_14d,
  ROUND(100*COUNTIF(DATE_DIFF(DATE(r.r_at,'Europe/Berlin'), s_d, DAY) BETWEEN 0 AND 14)/COUNT(*),2) pct_withdrawn_14d,
  COUNTIF(r.r_at IS NOT NULL) withdrawn_any_time
FROM ren LEFT JOIN r USING(id)
GROUP BY ROLLUP(1,2) ORDER BY 1,2
