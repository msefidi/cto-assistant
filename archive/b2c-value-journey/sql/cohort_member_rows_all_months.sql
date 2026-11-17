-- Cohort size, membership status today, likely intent, first 30/90/365-day behaviour, month-by-month activity (M1..M12), profile segment (stage, specialty) and money (membership fees, ticket cash, credit value) for every monthly cohort Aug 2024 – Aug 2026.
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
    (SELECT MAX(DATE(v.expires_at)) FROM valid v WHERE v.user_id=c.user_id) last_expiry,
    -- the membership covering the year-1 check day was created by automatic renewal (renewal is on by default; the alternative is an early/manual renewal or a B2B membership)
    EXISTS(SELECT 1 FROM valid v WHERE v.user_id=c.user_id AND DATE(v.started_at) <= DATE_ADD(DATE(c.planned_expiry), INTERVAL 14 DAY) AND DATE(v.expires_at) > DATE_ADD(DATE(c.planned_expiry), INTERVAL 14 DAY) AND v.state IN ('AUTOMATICALLY_RENEWED','PAID_MANUALLY_AUTOMATICALLY_RENEWED')) y1_auto
  FROM coh c),
-- Likely intent: what the member did in the first 7 days after buying. Seven classes (Mahyar, 20 Sep 2026):
--   Refresher-led            booked a live course ticket (brands REFRESHER / UPDATE_REFRESHER; 5% are other live formats such as Fortbildungstage)
--   Webinar-led              booked a WebUp webinar ticket (WUEX, WUIF, WU660)
--   On-demand accredited-led first watched an ONDEMAND_ACCREDITED course (enrolments are not bookings, so watching is the only signal)
--   SYFAT-led                first watched SYFAT / SPECIALIST_CERTIFICATE content
--   On-demand-led            first watched any other media-library content (course recordings, SummedUp, Skill, WebOp, webinar recordings, PJ training)
--   Mixed / Unknown          tie on the first day / no signal
-- Tie rules: one signal → that class; a live booking (Refresher or webinar) within 60 minutes of the order wins (earliest); otherwise the earliest
-- signal day wins (bookings by minute, watches by day); on the same day a CME product (accredited, SYFAT) beats generic on-demand; anything else left is Mixed.
w7 AS (
  SELECT c.order_id,
    MIN(IF(e.content_brand IN ('SYFAT','SPECIALIST_CERTIFICATE'), e.first_watch_date, NULL)) sy_date,
    MIN(IF(e.content_brand = 'ONDEMAND_ACCREDITED', e.first_watch_date, NULL)) oda_date,
    MIN(IF(IFNULL(e.content_brand,'') NOT IN ('SYFAT','SPECIALIST_CERTIFICATE','ONDEMAND_ACCREDITED'), e.first_watch_date, NULL)) od_date
  FROM coh c JOIN `fomf-dl`.analysis.fct_user_watched_content_events e
    ON e.user_id=c.user_id AND e.first_watch_date BETWEEN DATE(c.order_at,'Europe/Berlin') AND DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL 7 DAY)
  GROUP BY 1),
b7 AS (
  SELECT c.order_id,
    MIN(IF(b.original_content_type='LIVE_COURSE', TIMESTAMP_DIFF(b.booking_date, c.order_at, MINUTE), NULL)) ref_min, MIN(IF(b.original_content_type='LIVE_COURSE', DATE(b.booking_date,'Europe/Berlin'), NULL)) ref_date,
    MIN(IF(b.original_content_type='WEBINAR', TIMESTAMP_DIFF(b.booking_date, c.order_at, MINUTE), NULL)) web_min, MIN(IF(b.original_content_type='WEBINAR', DATE(b.booking_date,'Europe/Berlin'), NULL)) web_date,
    MIN(TIMESTAMP_DIFF(b.booking_date, c.order_at, MINUTE)) live_min, MIN(DATE(b.booking_date,'Europe/Berlin')) live_date,
    COUNTIF(b.original_content_type='WEBINAR') webinar_n, COUNTIF(b.original_content_type<>'WEBINAR') course_n
  FROM coh c JOIN `fomf-dl`.analysis.fct_course_bookings b
    ON b.user_id=c.user_id AND b.booking_date BETWEEN c.order_at AND TIMESTAMP_ADD(c.order_at, INTERVAL 7 DAY) AND b.booking_status NOT IN ('CANCELED','CANCELLED')
    AND b.original_content_type IN ('LIVE_COURSE','WEBINAR')
  GROUP BY 1),
sig AS (
  SELECT p.order_id, live_min, live_date, sy_date fa_date, od_date, oda_date, webinar_n, course_n,
    ARRAY(SELECT AS STRUCT t, d, mn FROM UNNEST([STRUCT('Refresher-led' AS t, ref_date AS d, ref_min AS mn), STRUCT('Webinar-led', web_date, web_min),
                                                 STRUCT('On-demand accredited-led', oda_date, NULL), STRUCT('SYFAT-led', sy_date, NULL), STRUCT('On-demand-led', od_date, NULL)]) WHERE d IS NOT NULL) sigs
  FROM per p LEFT JOIN w7 USING(order_id) LEFT JOIN b7 USING(order_id)),
intent AS (
  SELECT * EXCEPT(sigs),
    CASE
      WHEN ARRAY_LENGTH(sigs)=0 THEN 'Unknown'
      WHEN ARRAY_LENGTH(sigs)=1 THEN sigs[OFFSET(0)].t
      WHEN (SELECT COUNT(*) FROM UNNEST(sigs) s WHERE s.mn <= 60) > 0 THEN (SELECT s.t FROM UNNEST(sigs) s WHERE s.mn <= 60 ORDER BY s.mn, s.t LIMIT 1)
      ELSE (SELECT IF(COUNT(*)=1, ANY_VALUE(s.t), 'Mixed') FROM UNNEST(sigs) s
            WHERE s.d = (SELECT MIN(x.d) FROM UNNEST(sigs) x)
              AND NOT (s.t='On-demand-led' AND EXISTS(SELECT 1 FROM UNNEST(sigs) y WHERE y.d = s.d AND y.t IN ('On-demand accredited-led','SYFAT-led'))))
    END intent
  FROM sig),
-- Behaviour in the first 30 / 90 / 365 days after the order (categories Inactive / Low-Episodic / Live-only / Digital-only / Hybrid are derived on the page):
--   att  = attended live: held a non-cancelled ticket for a live course or webinar taking place in the window, or watched a livestream for >= 10 minutes in the window
--   mv   = meaningful videos: on-demand media of >= 5 min duration of which the member watched >= 50% within the window (or completed it), any brand incl. Facharzt;
--          playback on a live event's own days is excluded (that is the livestream)
--   ap   = active periods: distinct days (30 d) / ISO weeks (90 d) / months (365 d) with playback on a meaningful video
--   product reach (v16): attR/attW = attended a live course / a webinar; mva/mvs/mvo = meaningful videos that are accredited / SYFAT / other library content
--   obs  = the window has fully elapsed on the data date
tk AS (
  SELECT c.order_id, win, COUNT(*) n, COUNTIF(b.original_content_type='LIVE_COURSE') r_n, COUNTIF(b.original_content_type='WEBINAR') w_n
  FROM coh c JOIN `fomf-dl`.analysis.fct_course_bookings b
    ON b.user_id=c.user_id AND b.booking_status NOT IN ('CANCELED','CANCELLED') AND b.original_content_type IN ('LIVE_COURSE','WEBINAR')
  CROSS JOIN UNNEST([30,90,365]) win
  WHERE b.start_date_time BETWEEN c.order_at AND TIMESTAMP_ADD(c.order_at, INTERVAL win DAY) AND b.booking_date <= TIMESTAMP_ADD(c.order_at, INTERVAL win DAY)
  GROUP BY 1,2),
ls AS (
  SELECT c.order_id, win, COUNT(*) n, COUNTIF(e.original_content_type='LIVE_COURSE') r_n, COUNTIF(e.original_content_type='WEBINAR') w_n
  FROM coh c JOIN `fomf-dl`.analysis.fct_live_schedule_watch_events e ON e.user_id=c.user_id
  CROSS JOIN UNNEST([30,90,365]) win
  WHERE e.min_timestamp BETWEEN c.order_at AND TIMESTAMP_ADD(c.order_at, INTERVAL win DAY) AND IFNULL(e.watched_mins,0) >= 10
  GROUP BY 1,2),
pm AS (
  SELECT c.order_id, win, d.media_id, MAX(d.media_duration) dur, SUM(IF(d.diff_seconds>0, d.diff_seconds, 0)) sec, MAX(IF(d.completed,1,0)) done,
    MAX(CASE WHEN d.content_brand='ONDEMAND_ACCREDITED' THEN 'A' WHEN d.content_brand IN ('SYFAT','SPECIALIST_CERTIFICATE') THEN 'S' ELSE 'O' END) grp,
    ARRAY_AGG(DISTINCT d.watch_date) days
  FROM coh c JOIN `fomf-dl`.analysis.fct_watched_content_events d
    ON d.user_id=c.user_id AND d.watch_date BETWEEN DATE(c.order_at,'Europe/Berlin') AND DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL 365 DAY)
    AND NOT IFNULL(d.original_content_type IN ('LIVE_COURSE','WEBINAR') AND d.watch_date BETWEEN DATE(d.content_start_date_time,'Europe/Berlin') AND DATE(d.content_end_date_time,'Europe/Berlin'), FALSE)
  CROSS JOIN UNNEST([30,90,365]) win
  WHERE d.watch_date <= DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL win DAY)
  GROUP BY 1,2,3),
mv AS (
  SELECT order_id, win, COUNT(DISTINCT media_id) mv_n,
    COUNT(DISTINCT IF(grp='A', media_id, NULL)) mva, COUNT(DISTINCT IF(grp='S', media_id, NULL)) mvs, COUNT(DISTINCT IF(grp='O', media_id, NULL)) mvo,
    COUNT(DISTINCT IF(win=30, dd, NULL)) ad, COUNT(DISTINCT IF(win=90, DATE_TRUNC(dd, ISOWEEK), NULL)) aw, COUNT(DISTINCT IF(win=365, DATE_TRUNC(dd, MONTH), NULL)) am
  FROM pm, UNNEST(days) dd
  WHERE dur >= 300 AND (sec >= 0.5*dur OR done=1)
  GROUP BY 1,2),
-- Month by month (v20, 21 Sep 2026): member-months M1..M12 = [order date + (k-1) months, order date + k months). Per month: attended live (same rule as att),
--   watched >= 1 meaningful video (>= 50% of a >= 5 min video within that month, or completed). mlive/mdig = 12-bit masks (bit k-1 = month k), mobs = months fully elapsed on the data date.
mb AS (
  SELECT c.order_id, c.user_id, k, DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL k-1 MONTH) d0, DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL k MONTH) d1
  FROM coh c CROSS JOIN UNNEST(GENERATE_ARRAY(1,12)) k),
ml AS (
  SELECT b.order_id, b.k FROM mb b JOIN `fomf-dl`.analysis.fct_course_bookings x
    ON x.user_id=b.user_id AND x.booking_status NOT IN ('CANCELED','CANCELLED') AND x.original_content_type IN ('LIVE_COURSE','WEBINAR')
    AND DATE(x.start_date_time,'Europe/Berlin') >= b.d0 AND DATE(x.start_date_time,'Europe/Berlin') < b.d1 AND DATE(x.booking_date,'Europe/Berlin') < b.d1
  UNION DISTINCT
  SELECT b.order_id, b.k FROM mb b JOIN `fomf-dl`.analysis.fct_live_schedule_watch_events e
    ON e.user_id=b.user_id AND DATE(e.min_timestamp,'Europe/Berlin') >= b.d0 AND DATE(e.min_timestamp,'Europe/Berlin') < b.d1 AND IFNULL(e.watched_mins,0) >= 10),
md AS (
  SELECT order_id, k FROM (
    SELECT b.order_id, b.k, d.media_id, MAX(d.media_duration) dur, SUM(IF(d.diff_seconds>0, d.diff_seconds, 0)) sec, MAX(IF(d.completed,1,0)) done
    FROM mb b JOIN `fomf-dl`.analysis.fct_watched_content_events d
      ON d.user_id=b.user_id AND d.watch_date >= b.d0 AND d.watch_date < b.d1
      AND NOT IFNULL(d.original_content_type IN ('LIVE_COURSE','WEBINAR') AND d.watch_date BETWEEN DATE(d.content_start_date_time,'Europe/Berlin') AND DATE(d.content_end_date_time,'Europe/Berlin'), FALSE)
    GROUP BY 1,2,3)
  WHERE dur >= 300 AND (sec >= 0.5*dur OR done=1)
  GROUP BY 1,2),
mm AS (
  SELECT b.order_id, SUM(IF(l.k IS NOT NULL, 1 << (b.k-1), 0)) mlive, SUM(IF(d.k IS NOT NULL, 1 << (b.k-1), 0)) mdig, COUNTIF(b.d1 <= CURRENT_DATE()) mobs
  FROM mb b LEFT JOIN ml l ON l.order_id=b.order_id AND l.k=b.k LEFT JOIN md d ON d.order_id=b.order_id AND d.k=b.k
  GROUP BY 1),
fw AS (
  SELECT c.order_id,
    DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL 30 DAY) <= CURRENT_DATE() obs30, DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL 90 DAY) <= CURRENT_DATE() obs90, DATE_ADD(DATE(c.order_at,'Europe/Berlin'), INTERVAL 365 DAY) <= CURRENT_DATE() obs365,
    EXISTS(SELECT 1 FROM tk WHERE tk.order_id=c.order_id AND tk.win=30) OR EXISTS(SELECT 1 FROM ls WHERE ls.order_id=c.order_id AND ls.win=30) att30,
    EXISTS(SELECT 1 FROM tk WHERE tk.order_id=c.order_id AND tk.win=90) OR EXISTS(SELECT 1 FROM ls WHERE ls.order_id=c.order_id AND ls.win=90) att90,
    EXISTS(SELECT 1 FROM tk WHERE tk.order_id=c.order_id AND tk.win=365) OR EXISTS(SELECT 1 FROM ls WHERE ls.order_id=c.order_id AND ls.win=365) att365,
    IFNULL(m30.mv_n,0) mv30, IFNULL(m30.ad,0) ap30, IFNULL(m90.mv_n,0) mv90, IFNULL(m90.aw,0) ap90, IFNULL(m365.mv_n,0) mv365, IFNULL(m365.am,0) ap365,
    IFNULL((SELECT SUM(r_n) FROM tk WHERE tk.order_id=c.order_id AND tk.win=30),0) + IFNULL((SELECT SUM(r_n) FROM ls WHERE ls.order_id=c.order_id AND ls.win=30),0) > 0 attR30,
    IFNULL((SELECT SUM(w_n) FROM tk WHERE tk.order_id=c.order_id AND tk.win=30),0) + IFNULL((SELECT SUM(w_n) FROM ls WHERE ls.order_id=c.order_id AND ls.win=30),0) > 0 attW30,
    IFNULL((SELECT SUM(r_n) FROM tk WHERE tk.order_id=c.order_id AND tk.win=90),0) + IFNULL((SELECT SUM(r_n) FROM ls WHERE ls.order_id=c.order_id AND ls.win=90),0) > 0 attR90,
    IFNULL((SELECT SUM(w_n) FROM tk WHERE tk.order_id=c.order_id AND tk.win=90),0) + IFNULL((SELECT SUM(w_n) FROM ls WHERE ls.order_id=c.order_id AND ls.win=90),0) > 0 attW90,
    IFNULL((SELECT SUM(r_n) FROM tk WHERE tk.order_id=c.order_id AND tk.win=365),0) + IFNULL((SELECT SUM(r_n) FROM ls WHERE ls.order_id=c.order_id AND ls.win=365),0) > 0 attR365,
    IFNULL((SELECT SUM(w_n) FROM tk WHERE tk.order_id=c.order_id AND tk.win=365),0) + IFNULL((SELECT SUM(w_n) FROM ls WHERE ls.order_id=c.order_id AND ls.win=365),0) > 0 attW365,
    IFNULL(m30.mva,0) mva30, IFNULL(m30.mvs,0) mvs30, IFNULL(m30.mvo,0) mvo30, IFNULL(m90.mva,0) mva90, IFNULL(m90.mvs,0) mvs90, IFNULL(m90.mvo,0) mvo90, IFNULL(m365.mva,0) mva365, IFNULL(m365.mvs,0) mvs365, IFNULL(m365.mvo,0) mvo365
  FROM coh c
  LEFT JOIN mv m30 ON m30.order_id=c.order_id AND m30.win=30
  LEFT JOIN mv m90 ON m90.order_id=c.order_id AND m90.win=90
  LEFT JOIN mv m365 ON m365.order_id=c.order_id AND m365.win=365),
-- Segment cut (v21): career stage and specialty from the user profile (analysis.dim_users), collapsed to coarse codes so the export stays identifier-free.
--   stage: D = DOCTOR, A = ASSISTANT_DOCTOR, X = other or empty occupation type (psychotherapists, psychologists, other HCPs: ~1%)
--   spec : G Allgemeinmedizin (incl. Praktische/r Arzt, Hausarzt), I Innere Medizin, P Psychiatrie, K Pädiatrie / Kinder- und Jugendmedizin, C Kardiologie / Innere Medizin und Kardiologie,
--          O = other single specialty, M = several specialties in different groups, U = not stated.
--          Source: the v2 profile field (specialty_v2_name_de_de, one name per selected specialty, joined by ", ") when set, else the legacy speciality_group.
--          Signups since Nov 2025 fill only the v2 field. A member listing Innere Medizin together with its cardiology subspecialty counts as Kardiologie, not as several.
prof AS (
  SELECT order_id, stage,
    CASE WHEN ARRAY_LENGTH(g)=0 THEN 'U' WHEN ARRAY_LENGTH(g)=1 THEN g[OFFSET(0)]
         WHEN ARRAY_LENGTH(g)=2 AND 'I' IN UNNEST(g) AND 'C' IN UNNEST(g) THEN 'C' ELSE 'M' END spec
  FROM (
    SELECT order_id, stage,
      ARRAY(SELECT DISTINCT CASE TRIM(e)
              WHEN 'Allgemeinmedizin' THEN 'G' WHEN 'Praktische Ärztin/Praktischer Arzt' THEN 'G' WHEN 'Innere und Allgemeinmedizin (Hausarzt)' THEN 'G'
              WHEN 'Innere Medizin' THEN 'I' WHEN 'Psychiatrie' THEN 'P' WHEN 'Pädiatrie' THEN 'K' WHEN 'Kinder- und Jugendmedizin' THEN 'K'
              WHEN 'Kardiologie' THEN 'C' WHEN 'Innere Medizin und Kardiologie' THEN 'C' ELSE 'O' END
            FROM UNNEST(entries) e WHERE TRIM(e) <> '') g
    FROM (
      SELECT c.order_id,
        CASE ANY_VALUE(u.occupation_type) WHEN 'DOCTOR' THEN 'D' WHEN 'ASSISTANT_DOCTOR' THEN 'A' ELSE 'X' END stage,
        CASE WHEN ANY_VALUE(u.specialty_v2_name_de_de) IS NOT NULL THEN IF(IFNULL(ANY_VALUE(ARRAY_LENGTH(u.specialities_v2)),1) <= 1, [ANY_VALUE(u.specialty_v2_name_de_de)], SPLIT(ANY_VALUE(u.specialty_v2_name_de_de), ', '))
             WHEN ANY_VALUE(u.speciality_group) IS NOT NULL THEN SPLIT(ANY_VALUE(u.speciality_group), ', ') ELSE [] END entries
      FROM coh c LEFT JOIN `fomf-dl`.analysis.dim_users u ON u.user_id=c.user_id GROUP BY c.order_id))),
-- Economics (v23, 21 Sep 2026): what the member paid, in EUR (CHF x 1.05, order totals net of promo codes), cash basis as in the "B2C Membership Income" Metabase dashboard.
--   fee1 = the cohort order (+ any upgrade order, which only carries the upgrade delta); fee2 / fee3 = the second / third-and-later PAID B2C membership orders of the same user
--          after the cohort order whose resulting membership is not REVOKED / NOT_PAID (renewals of every kind, early renewals, re-joins after a lapse; each renewal is its own order row)
--   tix  = cash paid for course / webinar tickets after joining: member cash on top of membership credit + tickets bought as a non-member (after a lapse)
--   cvR / cvW = list-price value of live-course / webinar tickets covered by membership credit after joining (analysis.fct_course_bookings.member_credit_value_eur)
pay AS (
  SELECT c.order_id, o.total_price/100*IF(o.currency='CHF',1.05,1) eur, IFNULL(o.is_upgrade_order,FALSE) upg,
    ROW_NUMBER() OVER (PARTITION BY c.order_id ORDER BY o.created_at) seq
  FROM coh c
  JOIN `fomf-dl`.platform_raw_membershipservice.public_membership_order o ON o.user_id=c.user_id AND o.created_at>c.order_at AND o.status='PAID'
    AND (o.group_membership_id IS NULL OR o.group_membership_id='') AND (o.clinic_membership_id IS NULL OR o.clinic_membership_id='')
  JOIN `fomf-dl`.platform_raw_membershipservice.public_user_membership um ON um.created_from_membership_order_id=o.id AND um.state NOT IN ('REVOKED','NOT_PAID')),
money AS (
  SELECT c.order_id,
    ROUND(o.total_price/100*IF(o.currency='CHF',1.05,1) + IFNULL((SELECT SUM(eur) FROM pay WHERE pay.order_id=c.order_id AND upg),0)) fee1,
    ROUND(IFNULL((SELECT SUM(eur) FROM pay WHERE pay.order_id=c.order_id AND NOT upg AND seq=1),0)) fee2,
    ROUND(IFNULL((SELECT SUM(eur) FROM pay WHERE pay.order_id=c.order_id AND NOT upg AND seq>=2),0)) fee3,
    ROUND(IFNULL(t.tix,0)) tix, ROUND(IFNULL(t.cvR,0)) cvR, ROUND(IFNULL(t.cvW,0)) cvW
  FROM coh c JOIN `fomf-dl`.platform_raw_membershipservice.public_membership_order o ON o.id=c.order_id
  LEFT JOIN (
    SELECT c.order_id, SUM(IFNULL(b.member_cash_eur,0)+IFNULL(b.individual_revenue_eur,0)) tix,
      SUM(IF(b.original_content_type='LIVE_COURSE', CAST(IFNULL(b.member_credit_value_eur,0) AS FLOAT64), 0)) cvR,
      SUM(IF(b.original_content_type='WEBINAR', CAST(IFNULL(b.member_credit_value_eur,0) AS FLOAT64), 0)) cvW
    FROM coh c JOIN `fomf-dl`.analysis.fct_course_bookings b ON b.user_id=c.user_id AND b.booking_date>=c.order_at AND b.booking_status NOT IN ('CANCELED','CANCELLED')
    GROUP BY 1) t ON t.order_id=c.order_id)
SELECT p.cohort, p.country, p.membership_type, p.member_kind, p.cycle, p.planned_expiry, p.active_today, p.active_b2b_today, p.active_cancel_pending,
  p.y1_check <= CURRENT_DATE() y1_observable, p.y1_covered, p.y2_check <= CURRENT_DATE() y2_observable, p.y2_covered,
  i.intent, i.live_min, i.live_date IS NOT NULL has_live, i.od_date IS NOT NULL has_od, i.fa_date IS NOT NULL has_fa, IFNULL(i.webinar_n,0) webinar_n, IFNULL(i.course_n,0) course_n,
  f.obs30, f.att30, f.obs90, f.att90, f.obs365, f.att365, f.mv30, f.ap30, f.mv90, f.ap90, f.mv365, f.ap365, p.y1_auto,
  f.attR30, f.attW30, f.attR90, f.attW90, f.attR365, f.attW365, f.mva30, f.mvs30, f.mvo30, f.mva90, f.mvs90, f.mvo90, f.mva365, f.mvs365, f.mvo365,
  IFNULL(mm.mlive,0) mlive, IFNULL(mm.mdig,0) mdig, IFNULL(mm.mobs,0) mobs,
  IFNULL(pr.stage,'X') stage, IFNULL(pr.spec,'U') spec,
  IFNULL(mo.fee1,0) fee1, IFNULL(mo.fee2,0) fee2, IFNULL(mo.fee3,0) fee3, IFNULL(mo.tix,0) tix, IFNULL(mo.cvR,0) cvR, IFNULL(mo.cvW,0) cvW
FROM per p LEFT JOIN intent i USING(order_id) LEFT JOIN fw f USING(order_id) LEFT JOIN mm USING(order_id) LEFT JOIN prof pr USING(order_id) LEFT JOIN money mo USING(order_id)
WHERE p.cohort IN (__COHORTS__)
ORDER BY p.cohort, p.planned_expiry, p.country, p.membership_type, p.member_kind, i.intent, i.live_min
