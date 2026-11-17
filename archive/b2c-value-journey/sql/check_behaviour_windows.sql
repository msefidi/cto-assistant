-- Exploration for the "first 30 / 90 days" behaviour segments (20 Sep 2026).
-- Per member and window N (30, 90 days after the order):
--   live signal   = booked a live course / webinar ticket in the window (book), or held a valid ticket for one taking place in the window (att)
--   digital mins  = on-demand minutes watched in the window (fct_watched_content_events, diff_seconds > 0; any brand incl. Facharzt)
-- Output: segment distribution among observable members for several digital thresholds and both live definitions.
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

win AS (SELECT c.*, DATE(c.order_at,'Europe/Berlin') d0 FROM coh c),
b AS (
  SELECT w.order_id,
    COUNTIF(b.booking_date >= w.order_at AND b.booking_date <= TIMESTAMP_ADD(w.order_at, INTERVAL 30 DAY)) book30,
    COUNTIF(b.booking_date >= w.order_at AND b.booking_date <= TIMESTAMP_ADD(w.order_at, INTERVAL 90 DAY)) book90,
    COUNTIF(b.booking_date <= TIMESTAMP_ADD(w.order_at, INTERVAL 30 DAY) AND b.start_date_time BETWEEN w.order_at AND TIMESTAMP_ADD(w.order_at, INTERVAL 30 DAY)) att30,
    COUNTIF(b.booking_date <= TIMESTAMP_ADD(w.order_at, INTERVAL 90 DAY) AND b.start_date_time BETWEEN w.order_at AND TIMESTAMP_ADD(w.order_at, INTERVAL 90 DAY)) att90
  FROM win w JOIN `fomf-dl`.analysis.fct_course_bookings b
    ON b.user_id=w.user_id AND b.booking_status NOT IN ('CANCELED','CANCELLED') AND b.original_content_type IN ('LIVE_COURSE','WEBINAR')
    AND b.booking_date <= TIMESTAMP_ADD(w.order_at, INTERVAL 90 DAY)
  GROUP BY 1),
wt AS (
  SELECT w.order_id,
    SUM(IF(d.watch_date <= DATE_ADD(w.d0, INTERVAL 30 DAY) AND d.diff_seconds>0, d.diff_seconds, 0))/60 mins30,
    SUM(IF(d.diff_seconds>0, d.diff_seconds, 0))/60 mins90
  FROM win w JOIN `fomf-dl`.analysis.fct_watched_content_events d
    ON d.user_id=w.user_id AND d.watch_date BETWEEN w.d0 AND DATE_ADD(w.d0, INTERVAL 90 DAY)
  GROUP BY 1),
per AS (
  SELECT w.cohort, w.order_id, w.d0,
    DATE_ADD(w.d0, INTERVAL 30 DAY) <= CURRENT_DATE() obs30, DATE_ADD(w.d0, INTERVAL 90 DAY) <= CURRENT_DATE() obs90,
    IFNULL(book30,0)>0 book30, IFNULL(book90,0)>0 book90, IFNULL(book30,0)+IFNULL(att30,0)>0 live30, IFNULL(book90,0)+IFNULL(att90,0)>0 live90,
    IFNULL(mins30,0) mins30, IFNULL(mins90,0) mins90
  FROM win w LEFT JOIN b USING(order_id) LEFT JOIN wt USING(order_id)),
u AS (
  SELECT 30 win, book30 book, live30 live, mins30 mins FROM per WHERE obs30
  UNION ALL SELECT 90, book90, live90, mins90 FROM per WHERE obs90),
t AS (SELECT thr FROM UNNEST([0, 5, 15, 30, 60]) thr),
sg AS (
  SELECT u.win, t.thr, ldef, CASE WHEN l AND (IF(thr=0, mins>0, mins>=thr)) THEN 'Hybrid' WHEN l THEN 'Live only' WHEN IF(thr=0, mins>0, mins>=thr) THEN 'Digital only' ELSE 'Low/inactive' END seg
  FROM u CROSS JOIN t CROSS JOIN UNNEST([STRUCT('book' AS ldef, u.book AS l), STRUCT('book+att', u.live)]) )
SELECT win, CAST(thr AS INT64) thr, ldef, seg, COUNT(*) n, ROUND(100*COUNT(*)/SUM(COUNT(*)) OVER (PARTITION BY win, CAST(thr AS INT64), ldef)) pct
FROM sg GROUP BY 1,2,3,4 ORDER BY 1,2,3,4
