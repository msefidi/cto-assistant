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
lw AS (
  SELECT c.order_id,
    COUNTIF(b.booking_date <= TIMESTAMP_ADD(c.order_at, INTERVAL 30 DAY) AND (b.booking_date >= c.order_at OR b.start_date_time BETWEEN c.order_at AND TIMESTAMP_ADD(c.order_at, INTERVAL 30 DAY))) l30,
    COUNTIF(b.booking_date <= TIMESTAMP_ADD(c.order_at, INTERVAL 90 DAY) AND (b.booking_date >= c.order_at OR b.start_date_time BETWEEN c.order_at AND TIMESTAMP_ADD(c.order_at, INTERVAL 90 DAY))) l90,
    COUNTIF(b.booking_date >= c.order_at OR b.start_date_time BETWEEN c.order_at AND TIMESTAMP_ADD(c.order_at, INTERVAL 365 DAY)) l365
  FROM win c JOIN `fomf-dl`.analysis.fct_course_bookings b ON b.user_id=c.user_id AND b.booking_status NOT IN ('CANCELED','CANCELLED') AND b.original_content_type IN ('LIVE_COURSE','WEBINAR') AND b.booking_date <= TIMESTAMP_ADD(c.order_at, INTERVAL 365 DAY)
  GROUP BY 1),
-- per member, per window, per media: minutes and completion
pm AS (
  SELECT w.order_id, win, d.media_id, d.content_id, SUM(IF(d.diff_seconds>0, d.diff_seconds, 0))/60 mins, MAX(IF(d.completed,1,0)) done
  FROM win w JOIN `fomf-dl`.analysis.fct_watched_content_events d
    ON d.user_id=w.user_id AND d.watch_date BETWEEN w.d0 AND DATE_ADD(w.d0, INTERVAL 365 DAY)
    AND NOT IFNULL(d.original_content_type IN ('LIVE_COURSE','WEBINAR') AND d.watch_date BETWEEN DATE(d.content_start_date_time,'Europe/Berlin') AND DATE(d.content_end_date_time,'Europe/Berlin'), FALSE)
  CROSS JOIN UNNEST([30, 90, 365]) win
  WHERE d.watch_date <= DATE_ADD(w.d0, INTERVAL win DAY)
  GROUP BY 1,2,3,4),
agg AS (
  SELECT order_id, win, SUM(mins) mins, COUNT(*) media_n, COUNTIF(mins>=10 OR done=1) media10_n, COUNTIF(mins>=20 OR done=1) media20_n, SUM(done) done_n, COUNT(DISTINCT content_id) content_n
  FROM pm GROUP BY 1,2),
cp AS (
  SELECT w.order_id, win, COUNT(*) content_done_n
  FROM win w JOIN `fomf-dl`.analysis.fct_content_progress_by_user p ON p.user_id=w.user_id AND p.completed_content AND p.updated_at BETWEEN w.order_at AND TIMESTAMP_ADD(w.order_at, INTERVAL 365 DAY)
  CROSS JOIN UNNEST([30, 90, 365]) win WHERE p.updated_at <= TIMESTAMP_ADD(w.order_at, INTERVAL win DAY) GROUP BY 1,2),
u AS (
  SELECT w.order_id, win, DATE_ADD(w.d0, INTERVAL win DAY) <= CURRENT_DATE() obs,
    CASE win WHEN 30 THEN IFNULL(l30,0)>0 WHEN 90 THEN IFNULL(l90,0)>0 ELSE IFNULL(l365,0)>0 END live,
    IFNULL(mins,0) mins, IFNULL(media_n,0) media_n, IFNULL(media10_n,0) media10_n, IFNULL(media20_n,0) media20_n, IFNULL(done_n,0) done_n, IFNULL(content_done_n,0) content_done_n
  FROM win w CROSS JOIN UNNEST([30, 90, 365]) win LEFT JOIN lw USING(order_id) LEFT JOIN agg USING(order_id, win) LEFT JOIN cp USING(order_id, win)
  WHERE DATE_ADD(w.d0, INTERVAL win DAY) <= CURRENT_DATE()),
rules AS (
  SELECT win, live, r.name rule, r.d
  FROM u, UNNEST([
    STRUCT('A mins>=15' AS name, mins>=15 AS d), STRUCT('B mins>=60', mins>=60), STRUCT('C mins>=180', mins>=180),
    STRUCT('D 1 video>=10min/done', media10_n>=1), STRUCT('E 2 videos>=10min/done', media10_n>=2), STRUCT('F 3 videos>=10min/done', media10_n>=3), STRUCT('G 5 videos>=10min/done', media10_n>=5),
    STRUCT('H 2 videos>=20min/done', media20_n>=2), STRUCT('I 1 video completed', done_n>=1), STRUCT('J 1 content completed', content_done_n>=1),
    STRUCT('K per month: videos>=10min >= months', media10_n >= win/30)]) r)
SELECT win, rule,
  ROUND(100*COUNTIF(live AND NOT d)/COUNT(*)) live_only, ROUND(100*COUNTIF(NOT live AND d)/COUNT(*)) digital_only, ROUND(100*COUNTIF(live AND d)/COUNT(*)) hybrid, ROUND(100*COUNTIF(NOT live AND NOT d)/COUNT(*)) low, COUNT(*) n
FROM rules GROUP BY 1,2 ORDER BY 1,2
