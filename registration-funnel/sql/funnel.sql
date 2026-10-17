-- Web registration funnel (Segment), cohort = first landing on /user/registration, 7 Jul – 6 Oct 2026
DECLARE d0 TIMESTAMP DEFAULT TIMESTAMP('2026-07-07', 'Europe/Berlin');
DECLARE d1 TIMESTAMP DEFAULT TIMESTAMP('2026-10-07', 'Europe/Berlin');
WITH rs AS (
  SELECT anonymous_id, step, timestamp ts, context_ip ip, event_source_name src, registration_type rt, context_user_agent ua
  FROM `fomf-dl.segment_raw_unify.registration_step`
  WHERE timestamp >= d0 AND anonymous_id IS NOT NULL),
landing AS (
  SELECT anonymous_id, ARRAY_AGG(STRUCT(ts, ip, src, rt, ua) ORDER BY ts LIMIT 1)[OFFSET(0)] f
  FROM rs WHERE step='landing' AND ts < d1 GROUP BY 1),
ipd AS (
  SELECT ip, DATE(ts,'Europe/Berlin') d, COUNT(DISTINCT anonymous_id) n FROM rs WHERE step='landing' GROUP BY 1,2),
ev AS (
  SELECT anonymous_id, step, ts FROM rs WHERE step!='landing'
  UNION ALL SELECT anonymous_id, 'account', timestamp FROM `fomf-dl.segment_raw_unify.signup_started` WHERE timestamp >= d0 AND anonymous_id IS NOT NULL
  UNION ALL SELECT anonymous_id, 'login', timestamp FROM `fomf-dl.segment_raw_unify.login` WHERE timestamp >= d0 AND anonymous_id IS NOT NULL
  UNION ALL SELECT anonymous_id, 'done', timestamp FROM `fomf-dl.segment_raw_unify.signup_completed` WHERE timestamp >= d0 AND anonymous_id IS NOT NULL),
per AS (
  SELECT l.anonymous_id, l.f,
    MIN(IF(e.step='full-personal-info', e.ts, NULL)) t1,
    MIN(IF(e.step='account', e.ts, NULL)) ta,
    MIN(IF(e.step='medical-info', e.ts, NULL)) t2,
    MIN(IF(e.step='occupation-type-based', e.ts, NULL)) t3,
    MIN(IF(e.step='marketing-source', e.ts, NULL)) t4,
    MIN(IF(e.step='done', e.ts, NULL)) td,
    MIN(IF(e.step='login', e.ts, NULL)) tl
  FROM landing l LEFT JOIN ev e ON e.anonymous_id=l.anonymous_id AND e.ts >= l.f.ts AND e.ts < TIMESTAMP_ADD(l.f.ts, INTERVAL 30 DAY)
  GROUP BY 1,2),
cls AS (
  SELECT p.*, ipd.n ip_landings,
    -- deepest stage reached (later evidence implies earlier steps; covers events lost on the login redirect)
    CASE WHEN td IS NOT NULL THEN 6 WHEN t4 IS NOT NULL THEN 5 WHEN t3 IS NOT NULL THEN 4 WHEN t2 IS NOT NULL THEN 3
         WHEN ta IS NOT NULL THEN 2 WHEN t1 IS NOT NULL THEN 1 ELSE 0 END stage
  FROM per p LEFT JOIN ipd ON ipd.ip=p.f.ip AND ipd.d=DATE(p.f.ts,'Europe/Berlin'))
SELECT
  FORMAT_TIMESTAMP('%Y-%m', f.ts, 'Europe/Berlin') month,
  f.ts >= TIMESTAMP('2026-07-27 12:00:00', 'Europe/Berlin') has_step4,
  REPLACE(f.src, 'FOMF.', '') country,
  COALESCE(f.rt, 'STANDARD') type,
  IF(REGEXP_CONTAINS(f.ua, r'Mobile|Android|iPhone'), 'mobile', 'desktop') device,
  (REGEXP_CONTAINS(f.ua, r'(?i)headless|bot|crawl|spider|lighthouse') OR (ip_landings >= 3 AND stage = 0)) bot,
  (stage = 0 AND tl < TIMESTAMP_ADD(f.ts, INTERVAL 1 DAY)) login_1d,
  stage,
  COUNT(*) n,
  -- for funnel timing
  APPROX_QUANTILES(TIMESTAMP_DIFF(td, f.ts, SECOND), 2)[OFFSET(1)] med_sec_to_done
FROM cls GROUP BY 1,2,3,4,5,6,7,8 ORDER BY 1,2,3,4,5,6,7,8
