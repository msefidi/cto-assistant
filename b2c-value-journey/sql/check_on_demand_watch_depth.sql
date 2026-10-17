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
  FROM coh c),
-- Likely intent: what the member did in the first 7 days after buying.
--   live: booked a live course or webinar ticket (original_content_type LIVE_COURSE/WEBINAR), any participation type
--   fa:   first watched a Facharztvorbereitung / specialist-certificate course (brand SYFAT or SPECIALIST_CERTIFICATE)
--   od:   first watched any other on-demand content (recordings, SummedUp, Skill, WebOp, webinars)
w7 AS (
  SELECT c.order_id,
    MIN(IF(e.content_brand IN ('SYFAT','SPECIALIST_CERTIFICATE'), e.first_watch_date, NULL)) fa_date,
    MIN(IF(e.content_brand IN ('SYFAT','SPECIALIST_CERTIFICATE'), NULL, e.first_watch_date)) od_date
  FROM coh c JOIN `fomf-dl`.analysis.fct_user_watched_content_events e
    ON e.user_id=c.user_id AND e.first_watch_date BETWEEN DATE(c.order_at,'Europe/Berlin') AND DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL 7 DAY)
  GROUP BY 1),
b7 AS (
  SELECT c.order_id, MIN(TIMESTAMP_DIFF(b.booking_date, c.order_at, MINUTE)) live_min, MIN(DATE(b.booking_date,'Europe/Berlin')) live_date,
    COUNTIF(b.original_content_type='WEBINAR') webinar_n, COUNTIF(b.original_content_type<>'WEBINAR') course_n
  FROM coh c JOIN `fomf-dl`.analysis.fct_course_bookings b
    ON b.user_id=c.user_id AND b.booking_date BETWEEN c.order_at AND TIMESTAMP_ADD(c.order_at, INTERVAL 7 DAY) AND b.booking_status NOT IN ('CANCELED','CANCELLED')
    AND b.original_content_type IN ('LIVE_COURSE','WEBINAR')
  GROUP BY 1),
intent AS (
  SELECT p.order_id, live_min, live_date, fa_date, od_date, webinar_n, course_n,
    CASE
      WHEN live_date IS NULL AND fa_date IS NULL AND od_date IS NULL THEN 'Unknown'
      WHEN live_date IS NOT NULL AND fa_date IS NULL AND od_date IS NULL THEN 'Live-led'
      WHEN live_date IS NULL AND fa_date IS NOT NULL AND (od_date IS NULL OR fa_date <= od_date) THEN 'Facharzt-led'
      WHEN live_date IS NULL AND fa_date IS NULL THEN 'On-demand-led'
      WHEN live_date IS NULL AND od_date < fa_date THEN 'Mixed'
      WHEN live_min <= 60 THEN 'Live-led'                                   -- booked at the checkout: the course was the trigger
      WHEN fa_date IS NOT NULL AND fa_date < live_date AND (od_date IS NULL OR fa_date <= od_date) THEN 'Facharzt-led'
      WHEN od_date IS NOT NULL AND od_date < live_date AND (fa_date IS NULL OR od_date < fa_date) THEN 'On-demand-led'
      WHEN live_date < IFNULL(fa_date, DATE '9999-12-31') AND live_date < IFNULL(od_date, DATE '9999-12-31') THEN 'Live-led'
      ELSE 'Mixed'
    END intent
  FROM per p LEFT JOIN w7 USING(order_id) LEFT JOIN b7 USING(order_id))
, od AS (
  SELECT c.cohort, c.order_id, i.intent,
    IFNULL(SUM(IF(d.diff_seconds>0, d.diff_seconds, 0)),0)/60 mins_7d,
    COUNT(DISTINCT d.media_id) media_n,
    MAX(IF(d.completed, 1, 0)) any_completed
  FROM coh c JOIN intent i USING(order_id)
  LEFT JOIN `fomf-dl`.analysis.fct_watched_content_events d
    ON d.user_id=c.user_id AND d.watch_date BETWEEN DATE(c.order_at,'Europe/Berlin') AND DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL 7 DAY)
    AND (d.content_brand IS NULL OR d.content_brand NOT IN ('SYFAT','SPECIALIST_CERTIFICATE'))
  WHERE i.intent='On-demand-led'
  GROUP BY 1,2,3)
SELECT scope, bucket, COUNT(*) members FROM (
  SELECT IF(cohort='2024-08','Aug 2024','All cohorts') scope,
    CASE WHEN mins_7d < 1 THEN 'a <1 min' WHEN mins_7d < 5 THEN 'b 1-5 min' WHEN mins_7d < 15 THEN 'c 5-15 min' WHEN mins_7d < 60 THEN 'd 15-60 min' ELSE 'e 60+ min' END bucket
  FROM od
  UNION ALL
  SELECT 'All cohorts', CASE WHEN mins_7d < 1 THEN 'a <1 min' WHEN mins_7d < 5 THEN 'b 1-5 min' WHEN mins_7d < 15 THEN 'c 5-15 min' WHEN mins_7d < 60 THEN 'd 15-60 min' ELSE 'e 60+ min' END FROM od WHERE cohort='2024-08')
GROUP BY 1,2 ORDER BY 1,2
