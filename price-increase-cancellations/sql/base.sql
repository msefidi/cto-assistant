-- B2C paid user memberships with their scheduled end (renewal date) and first renewal-cancellation request
WITH um AS (
  SELECT um.id, um.user_id, um.state, um.renewal_status, um.membership_renewal_type rtype, um.cycle,
         DATE(um.expires_at,'Europe/Berlin') exp_d, um.expires_at, m.country, m.membership_type
  FROM `fomf-dl`.platform_raw_membershipservice.public_user_membership um
  JOIN `fomf-dl`.platform_raw_membershipservice.public_membership m ON m.id=um.membership_id
  WHERE (um.group_membership_id IS NULL OR um.group_membership_id='') AND (um.clinic_membership_id IS NULL OR um.clinic_membership_id='')
    AND um.state IN ('NEWLY_CREATED','AUTOMATICALLY_RENEWED','PAID_MANUALLY_AUTOMATICALLY_RENEWED','EARLY_RENEWED','MANUALLY_RENEWED','PAUSED')
    AND DATE(um.expires_at,'Europe/Berlin') BETWEEN '2024-10-01' AND '2026-12-31'),
c AS (
  SELECT user_membership_id id, MIN(DATE(created_at,'Europe/Berlin')) c_d
  FROM `fomf-dl`.platform_raw_membershipservice.public_membership_cancellation_request
  WHERE cancellation_type='CANCEL_MEMBERSHIP' GROUP BY 1),
b AS (
  SELECT um.*, c.c_d, IF(c.c_d IS NOT NULL AND c.c_d <= um.exp_d, DATE_DIFF(um.exp_d, c.c_d, DAY), NULL) lead
  FROM um LEFT JOIN c USING(id))
