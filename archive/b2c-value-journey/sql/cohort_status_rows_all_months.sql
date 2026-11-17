-- Cohort size and membership status today for every monthly cohort Aug 2024 – Aug 2025.
-- Cohort = new B2C members (see cohort_base.sql). Status is coverage-based:
--   covered(t) = the user has a user_membership (any kind, state not REVOKED/NOT_PAID) with started_at <= t < expires_at.
--   planned expiry = started_at + catalog cycle (initial_expires_at is unreliable for returning members);
--   year-1 renewed = covered 14 days after the planned expiry; year-2 renewed = covered 365+14 days after it.
--   A check is "observable" only when its check date is <= today.
WITH ord AS (
  SELECT o.id order_id, o.user_id, o.created_at order_at, FORMAT_DATE('%Y-%m', DATE(o.created_at,'Europe/Berlin')) cohort,
         m.country, m.membership_type, um.id um_id, um.started_at, m.cycle,
         CASE m.cycle WHEN 'THREE_YEARS' THEN TIMESTAMP_ADD(um.started_at, INTERVAL 1096 DAY) WHEN 'FOURTEEN_MONTHS' THEN TIMESTAMP_ADD(um.started_at, INTERVAL 427 DAY) WHEN 'SIX_MONTHS' THEN TIMESTAMP_ADD(um.started_at, INTERVAL 183 DAY) WHEN 'THREE_MONTHS' THEN TIMESTAMP_ADD(um.started_at, INTERVAL 92 DAY) WHEN 'ONE_MONTH' THEN TIMESTAMP_ADD(um.started_at, INTERVAL 31 DAY) ELSE TIMESTAMP_ADD(um.started_at, INTERVAL 365 DAY) END planned_expiry
  FROM `fomf-dl`.platform_raw_membershipservice.public_membership_order o
  JOIN `fomf-dl`.platform_raw_membershipservice.public_membership m ON m.id=o.membership_id
  JOIN `fomf-dl`.platform_raw_membershipservice.public_user_membership um ON um.created_from_membership_order_id=o.id
  WHERE o.status='PAID' AND (o.group_membership_id IS NULL OR o.group_membership_id='') AND (o.clinic_membership_id IS NULL OR o.clinic_membership_id='')
    AND DATE(o.created_at,'Europe/Berlin') BETWEEN '2024-08-01' AND '2025-08-31' AND um.state='NEWLY_CREATED'),
prior AS (SELECT o.order_id, COUNT(p.id) prior_ums FROM ord o LEFT JOIN `fomf-dl`.platform_raw_membershipservice.public_user_membership p ON p.user_id=o.user_id AND p.created_at < o.order_at GROUP BY 1),
coh AS (SELECT o.*, IF(IFNULL(prior_ums,0)>0,'returning','first-time') member_kind FROM ord o LEFT JOIN prior USING(order_id)),
valid AS (
  SELECT user_id, started_at, expires_at, state, renewal_status,
         ((group_membership_id IS NOT NULL AND group_membership_id<>'') OR (clinic_membership_id IS NOT NULL AND clinic_membership_id<>'')) is_b2b
  FROM `fomf-dl`.platform_raw_membershipservice.public_user_membership WHERE state NOT IN ('REVOKED','NOT_PAID')),
per AS (
  SELECT c.cohort, c.order_id, c.country, c.membership_type, c.member_kind, c.cycle, DATE(c.planned_expiry) planned_expiry,
    DATE_ADD(DATE(c.planned_expiry), INTERVAL 14 DAY) y1_check, DATE_ADD(DATE(c.planned_expiry), INTERVAL 379 DAY) y2_check,
    EXISTS(SELECT 1 FROM valid v WHERE v.user_id=c.user_id AND v.started_at <= CURRENT_TIMESTAMP() AND v.expires_at > CURRENT_TIMESTAMP()) active_today,
    EXISTS(SELECT 1 FROM valid v WHERE v.user_id=c.user_id AND v.started_at <= CURRENT_TIMESTAMP() AND v.expires_at > CURRENT_TIMESTAMP() AND v.is_b2b) active_b2b_today,
    EXISTS(SELECT 1 FROM valid v WHERE v.user_id=c.user_id AND v.started_at <= CURRENT_TIMESTAMP() AND v.expires_at > CURRENT_TIMESTAMP() AND NOT v.is_b2b AND v.renewal_status='CANCELED') active_cancel_pending,
    EXISTS(SELECT 1 FROM valid v WHERE v.user_id=c.user_id AND DATE(v.started_at) <= DATE_ADD(DATE(c.planned_expiry), INTERVAL 14 DAY) AND DATE(v.expires_at) > DATE_ADD(DATE(c.planned_expiry), INTERVAL 14 DAY)) y1_covered,
    EXISTS(SELECT 1 FROM valid v WHERE v.user_id=c.user_id AND DATE(v.started_at) <= DATE_ADD(DATE(c.planned_expiry), INTERVAL 379 DAY) AND DATE(v.expires_at) > DATE_ADD(DATE(c.planned_expiry), INTERVAL 379 DAY)) y2_covered,
    (SELECT MAX(DATE(v.expires_at)) FROM valid v WHERE v.user_id=c.user_id) last_expiry
  FROM coh c)
SELECT cohort, country, membership_type, member_kind, cycle, planned_expiry, active_today, active_b2b_today, active_cancel_pending,
  y1_check <= CURRENT_DATE() y1_observable, y1_covered, y2_check <= CURRENT_DATE() y2_observable, y2_covered, last_expiry
FROM per ORDER BY cohort, planned_expiry
