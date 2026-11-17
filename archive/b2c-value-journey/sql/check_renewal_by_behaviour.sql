-- Year-1 renewal by 12-month behaviour category, with the state of the covering membership (auto vs manual renewal, B2B) and status today. 20 Sep 2026.
-- Replace 'x' cohort filter: the WHERE p.cohort IN (__COHORTS__) of the main file is not used here; all cohorts.
-- Cohort size, membership status today, likely intent and first 30/90/365-day behaviour for every monthly cohort Aug 2024 – Aug 2026.
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
    AND DATE(o.created_at,'Europe/Berlin') BETWEEN '2024-08-01' AND '2026-08-31' AND um.state='NEWLY_CREATED'),
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
  FROM per p LEFT JOIN w7 USING(order_id) LEFT JOIN b7 USING(order_id)),
-- Behaviour in the first 30 / 90 / 365 days after the order (categories Inactive / Low-Episodic / Live-only / Digital-only / Hybrid are derived on the page):
--   att  = attended live: held a non-cancelled ticket for a live course or webinar taking place in the window, or watched a livestream for >= 10 minutes in the window
--   mv   = meaningful videos: on-demand media of >= 5 min duration of which the member watched >= 50% within the window (or completed it), any brand incl. Facharzt;
--          playback on a live event's own days is excluded (that is the livestream)
--   ap   = active periods: distinct days (30 d) / ISO weeks (90 d) / months (365 d) with playback on a meaningful video
--   obs  = the window has fully elapsed on the data date
tk AS (
  SELECT c.order_id, win, COUNT(*) n
  FROM coh c JOIN `fomf-dl`.analysis.fct_course_bookings b
    ON b.user_id=c.user_id AND b.booking_status NOT IN ('CANCELED','CANCELLED') AND b.original_content_type IN ('LIVE_COURSE','WEBINAR')
  CROSS JOIN UNNEST([30,90,365]) win
  WHERE b.start_date_time BETWEEN c.order_at AND TIMESTAMP_ADD(c.order_at, INTERVAL win DAY) AND b.booking_date <= TIMESTAMP_ADD(c.order_at, INTERVAL win DAY)
  GROUP BY 1,2),
ls AS (
  SELECT c.order_id, win, COUNT(*) n
  FROM coh c JOIN `fomf-dl`.analysis.fct_live_schedule_watch_events e ON e.user_id=c.user_id
  CROSS JOIN UNNEST([30,90,365]) win
  WHERE e.min_timestamp BETWEEN c.order_at AND TIMESTAMP_ADD(c.order_at, INTERVAL win DAY) AND IFNULL(e.watched_mins,0) >= 10
  GROUP BY 1,2),
pm AS (
  SELECT c.order_id, win, d.media_id, MAX(d.media_duration) dur, SUM(IF(d.diff_seconds>0, d.diff_seconds, 0)) sec, MAX(IF(d.completed,1,0)) done,
    ARRAY_AGG(DISTINCT d.watch_date) days
  FROM coh c JOIN `fomf-dl`.analysis.fct_watched_content_events d
    ON d.user_id=c.user_id AND d.watch_date BETWEEN DATE(c.order_at,'Europe/Berlin') AND DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL 365 DAY)
    AND NOT IFNULL(d.original_content_type IN ('LIVE_COURSE','WEBINAR') AND d.watch_date BETWEEN DATE(d.content_start_date_time,'Europe/Berlin') AND DATE(d.content_end_date_time,'Europe/Berlin'), FALSE)
  CROSS JOIN UNNEST([30,90,365]) win
  WHERE d.watch_date <= DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL win DAY)
  GROUP BY 1,2,3),
mv AS (
  SELECT order_id, win, COUNT(*) mv_n,
    COUNT(DISTINCT IF(win=30, dd, NULL)) ad, COUNT(DISTINCT IF(win=90, DATE_TRUNC(dd, ISOWEEK), NULL)) aw, COUNT(DISTINCT IF(win=365, DATE_TRUNC(dd, MONTH), NULL)) am
  FROM pm, UNNEST(days) dd
  WHERE dur >= 300 AND (sec >= 0.5*dur OR done=1)
  GROUP BY 1,2),
fw AS (
  SELECT c.order_id,
    DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL 30 DAY) <= CURRENT_DATE() obs30, DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL 90 DAY) <= CURRENT_DATE() obs90, DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL 365 DAY) <= CURRENT_DATE() obs365,
    EXISTS(SELECT 1 FROM tk WHERE tk.order_id=c.order_id AND tk.win=30) OR EXISTS(SELECT 1 FROM ls WHERE ls.order_id=c.order_id AND ls.win=30) att30,
    EXISTS(SELECT 1 FROM tk WHERE tk.order_id=c.order_id AND tk.win=90) OR EXISTS(SELECT 1 FROM ls WHERE ls.order_id=c.order_id AND ls.win=90) att90,
    EXISTS(SELECT 1 FROM tk WHERE tk.order_id=c.order_id AND tk.win=365) OR EXISTS(SELECT 1 FROM ls WHERE ls.order_id=c.order_id AND ls.win=365) att365,
    IFNULL(m30.mv_n,0) mv30, IFNULL(m30.ad,0) ap30, IFNULL(m90.mv_n,0) mv90, IFNULL(m90.aw,0) ap90, IFNULL(m365.mv_n,0) mv365, IFNULL(m365.am,0) ap365
  FROM coh c
  LEFT JOIN mv m30 ON m30.order_id=c.order_id AND m30.win=30
  LEFT JOIN mv m90 ON m90.order_id=c.order_id AND m90.win=90
  LEFT JOIN mv m365 ON m365.order_id=c.order_id AND m365.win=365)

, r AS (
  SELECT p.order_id, p.cohort, c.user_id, p.y1_check, p.y1_covered, p.active_today, p.active_cancel_pending,
    CASE WHEN f.att365 AND f.mv365>=24 AND f.ap365>=6 THEN 'Hybrid' WHEN f.att365 THEN 'Live-only' WHEN f.mv365>=24 AND f.ap365>=6 THEN 'Digital-only' WHEN f.mv365>=1 THEN 'Low/Episodic' ELSE 'Inactive' END cat
  FROM per p JOIN coh c USING(order_id) JOIN fw f USING(order_id)
  WHERE f.obs365 AND p.y1_check <= CURRENT_DATE()),
cov AS (
  SELECT r.order_id, ARRAY_AGG(v.state ORDER BY v.started_at DESC LIMIT 1)[OFFSET(0)] state, MAX(v.is_b2b) b2b
  FROM r JOIN valid v ON v.user_id=r.user_id AND DATE(v.started_at) <= r.y1_check AND DATE(v.expires_at) > r.y1_check GROUP BY 1)
SELECT cat, COUNT(*) members, COUNTIF(y1_covered) renewed, ROUND(100*COUNTIF(y1_covered)/COUNT(*)) rate,
  COUNTIF(cov.state IN ('AUTOMATICALLY_RENEWED','PAID_MANUALLY_AUTOMATICALLY_RENEWED')) auto_renewed, COUNTIF(cov.state IN ('EARLY_RENEWED','MANUALLY_RENEWED')) manual_renewed, COUNTIF(cov.b2b) via_b2b,
  COUNTIF(cov.state IS NOT NULL AND cov.state NOT IN ('AUTOMATICALLY_RENEWED','PAID_MANUALLY_AUTOMATICALLY_RENEWED','EARLY_RENEWED','MANUALLY_RENEWED') AND NOT cov.b2b) other_state,
  COUNTIF(active_today) active_today, COUNTIF(active_cancel_pending) cancel_pending, ROUND(100*COUNTIF(active_today)/COUNT(*)) active_rate
FROM r LEFT JOIN cov USING(order_id) GROUP BY 1 ORDER BY 2 DESC