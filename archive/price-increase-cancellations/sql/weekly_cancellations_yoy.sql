-- Renewal cancellations (first CANCEL_MEMBERSHIP request per paid B2C membership, made before its renewal date) per ISO week, 2025 vs 2026.
-- "notice" = the membership renews within the price-notice season (1 Oct - 31 Dec of the same year) — in 2026 these renewals get the new price.
WITH um AS (
  SELECT um.id, DATE(um.expires_at,'Europe/Berlin') exp_d
  FROM `fomf-dl`.platform_raw_membershipservice.public_user_membership um
  WHERE (um.group_membership_id IS NULL OR um.group_membership_id='') AND (um.clinic_membership_id IS NULL OR um.clinic_membership_id='')
    AND um.state IN ('NEWLY_CREATED','AUTOMATICALLY_RENEWED','PAID_MANUALLY_AUTOMATICALLY_RENEWED','EARLY_RENEWED','MANUALLY_RENEWED','PAUSED')),
c AS (
  SELECT user_membership_id id, MIN(DATE(created_at,'Europe/Berlin')) c_d
  FROM `fomf-dl`.platform_raw_membershipservice.public_membership_cancellation_request
  WHERE cancellation_type='CANCEL_MEMBERSHIP' GROUP BY 1)
SELECT EXTRACT(ISOYEAR FROM c_d) y, EXTRACT(ISOWEEK FROM c_d) w, MIN(c_d) first_day, COUNT(*) n,
       COUNTIF(EXTRACT(YEAR FROM exp_d)=EXTRACT(ISOYEAR FROM c_d) AND EXTRACT(MONTH FROM exp_d)>=10) n_q4_renewals
FROM um JOIN c USING(id)
WHERE c_d <= exp_d AND EXTRACT(ISOYEAR FROM c_d) IN (2025,2026) AND c_d <= '2026-09-27'
GROUP BY 1,2 ORDER BY 2,1
