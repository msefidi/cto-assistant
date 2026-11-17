-- One row per new B2C member of cohort 2024-08 with the acquisition signals used by the dashboard.
-- No identifiers are exported. Base cohort definition: see cohort_base.sql / AGENTS.md.
WITH ord AS (
  SELECT o.id order_id, o.user_id, o.created_at order_at, DATE(o.created_at,'Europe/Berlin') order_d, o.total_price, o.currency, m.country, m.membership_type, m.cycle, m.price list_price,
         um.id um_id, um.state um_state, um.started_at, um.expires_at, um.renewal_status
  FROM `fomf-dl`.platform_raw_membershipservice.public_membership_order o
  JOIN `fomf-dl`.platform_raw_membershipservice.public_membership m ON m.id=o.membership_id
  JOIN `fomf-dl`.platform_raw_membershipservice.public_user_membership um ON um.created_from_membership_order_id=o.id
  WHERE o.status='PAID' AND (o.group_membership_id IS NULL OR o.group_membership_id='') AND (o.clinic_membership_id IS NULL OR o.clinic_membership_id='')
    AND DATE(o.created_at,'Europe/Berlin') BETWEEN '2024-08-01' AND '2024-08-31'
    AND um.state = 'NEWLY_CREATED'),
prior AS (
  SELECT o.order_id, COUNT(p.id) prior_ums
  FROM ord o LEFT JOIN `fomf-dl`.platform_raw_membershipservice.public_user_membership p ON p.user_id=o.user_id AND p.created_at < o.order_at
  GROUP BY 1),
coh AS (SELECT o.*, IF(IFNULL(prior_ums,0)>0,'returning','first-time') member_kind FROM ord o LEFT JOIN prior USING(order_id))
, ms AS (SELECT membership_order_id, ARRAY_AGG(DISTINCT CASE
 WHEN marketing_source_name_de LIKE 'Google%' OR marketing_source_name_de LIKE 'Bing%' THEN 'Search'
 WHEN marketing_source_name_de LIKE '%Newsletter%' OR marketing_source_name_de LIKE 'E-Mail%' THEN 'Email / Newsletter'
 WHEN marketing_source_name_de LIKE 'Empfehlung%' THEN 'Colleague recommendation'
 WHEN marketing_source_name_de LIKE 'Postflyer%' THEN 'Post flyer'
 WHEN marketing_source_name_de LIKE 'Beilage%' OR marketing_source_name_de LIKE 'Inserat%' THEN 'Journal insert / ad'
 WHEN marketing_source_name_de LIKE 'Plakat%' THEN 'Clinic poster'
 WHEN marketing_source_name_de LIKE 'FomF%' THEN 'FOMF website'
 WHEN marketing_source_name_de LIKE 'Ehemalig%' THEN 'Former participant'
 WHEN marketing_source_name_de IN ('Facebook','Instagram','LinkedIn') OR marketing_source_name_de LIKE 'Social%' THEN 'Social media'
 ELSE marketing_source_name_de END) srcs FROM `fomf-dl`.analysis.fct_membership_marketing_sources GROUP BY 1),
u AS (SELECT user_id, created_at reg_at, occupation_type, speciality_group FROM `fomf-dl`.analysis.dim_users),
bk AS (SELECT c.order_id, COUNT(b.booking_id) prior_bookings, ROUND(SUM(IFNULL(b.total_price_eur,0))) prior_booking_eur FROM coh c LEFT JOIN `fomf-dl`.analysis.fct_course_bookings b ON b.user_id=c.user_id AND b.booking_date < c.order_at AND b.booking_status NOT IN ('CANCELED','CANCELLED') GROUP BY 1),
w AS (SELECT c.order_id, COUNT(*) prior_watch_items FROM coh c JOIN `fomf-dl`.analysis.fct_user_watched_content_events e ON e.user_id=c.user_id AND e.first_watch_date < c.order_d GROUP BY 1),
pc AS (SELECT membership_order_id, STRING_AGG(promo_code) promo FROM `fomf-dl`.platform_raw_membershipservice.public_membership_order_item WHERE membership_order_item_type='PROMO_CODE' GROUP BY 1),
pg AS (SELECT c.order_id, p.timestamp, p.context_campaign_source utm_s, p.context_campaign_medium utm_m, REGEXP_EXTRACT(p.context_page_referrer, r'https?://([^/]+)') ref
 FROM coh c JOIN `fomf-dl`.segment_raw_unify.pages p ON p.user_id=c.user_id AND p.timestamp BETWEEN TIMESTAMP_SUB(c.order_at, INTERVAL 90 DAY) AND c.order_at
 WHERE p.context_campaign_source IS NOT NULL OR (p.context_page_referrer IS NOT NULL AND NOT REGEXP_CONTAINS(p.context_page_referrer, r'fomf\.(de|ch|at|org)|localhost'))
 QUALIFY ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY timestamp)=1),
anyp AS (SELECT DISTINCT c.order_id FROM coh c JOIN `fomf-dl`.segment_raw_unify.pages p ON p.user_id=c.user_id AND p.timestamp BETWEEN TIMESTAMP_SUB(c.order_at, INTERVAL 90 DAY) AND c.order_at),
p24 AS (SELECT c.order_id, COUNTIF(REGEXP_CONTAINS(p.context_page_path, r'/booking/events')) course_booking_pages, COUNTIF(REGEXP_CONTAINS(p.context_page_path, r'/product|/content/')) catalogue_pages, COUNTIF(REGEXP_CONTAINS(p.context_page_path, r'/mediathek|/livestream')) media_pages, COUNT(*) pages FROM coh c JOIN `fomf-dl`.segment_raw_unify.pages p ON p.user_id=c.user_id AND p.timestamp BETWEEN TIMESTAMP_SUB(c.order_at, INTERVAL 24 HOUR) AND c.order_at GROUP BY 1),
fb AS (SELECT c.order_id, TIMESTAMP_DIFF(b.booking_date, c.order_at, MINUTE) min_to_first_booking,
   CASE WHEN b.content_type='WEBINAR' THEN 'Webinar (WebUp)' WHEN b.booking_participation_type='ON_SITE' THEN 'Course, on site' WHEN b.booking_participation_type='LIVESTREAM' THEN 'Course, livestream' ELSE IFNULL(b.content_type,'Course') END first_booking_kind,
   TIMESTAMP_DIFF(b.start_date_time, c.order_at, DAY) first_booking_days_to_event, IFNULL(b.membership_credit_effective,false) first_booking_on_credit, ROUND(IFNULL(b.total_price_eur,0)) first_booking_paid_eur
 FROM coh c JOIN `fomf-dl`.analysis.fct_course_bookings b ON b.user_id=c.user_id AND b.booking_date >= c.order_at AND b.booking_status NOT IN ('CANCELED','CANCELLED')
 QUALIFY ROW_NUMBER() OVER (PARTITION BY c.order_id ORDER BY b.booking_date)=1),
b7 AS (SELECT c.order_id, COUNT(b.booking_id) bookings_7d_after FROM coh c JOIN `fomf-dl`.analysis.fct_course_bookings b ON b.user_id=c.user_id AND b.booking_date BETWEEN c.order_at AND TIMESTAMP_ADD(c.order_at, INTERVAL 7 DAY) AND b.booking_status NOT IN ('CANCELED','CANCELLED') GROUP BY 1),
fw AS (SELECT c.order_id, MIN(DATE_DIFF(e.first_watch_date, c.order_d, DAY)) first_watch_days FROM coh c JOIN `fomf-dl`.analysis.fct_user_watched_content_events e ON e.user_id=c.user_id AND e.first_watch_date >= c.order_d GROUP BY 1)
SELECT c.member_kind, c.country, c.membership_type, ROUND(c.total_price/100*IF(c.currency='CHF',1.05,1)) paid_eur, EXTRACT(DAY FROM c.order_d) order_day,
 IFNULL(u.occupation_type,'unknown') occupation, IFNULL(SPLIT(u.speciality_group, ',')[SAFE_OFFSET(0)],'unknown') speciality,
 DATE_DIFF(c.order_d, DATE(u.reg_at), DAY) account_age_days,
 IFNULL(bk.prior_bookings,0) prior_bookings, IFNULL(bk.prior_booking_eur,0) prior_booking_eur, IFNULL(w.prior_watch_items,0) prior_watch_items,
 IFNULL(ms.srcs, ['(not answered)']) sources, pc.promo,
 CASE WHEN pg.utm_s IS NOT NULL THEN CASE WHEN LOWER(pg.utm_s) LIKE '%hs_email%' OR LOWER(pg.utm_m)='email' THEN 'Email (HubSpot)' WHEN LOWER(pg.utm_s) LIKE '%facebook%' OR LOWER(pg.utm_s) LIKE '%meta%' THEN 'Paid social' ELSE 'Other campaign' END
      WHEN pg.ref LIKE '%google%' OR pg.ref LIKE '%bing%' OR pg.ref LIKE '%yahoo%' THEN 'Organic search'
      WHEN pg.ref IS NOT NULL THEN 'Other referrer'
      WHEN anyp.order_id IS NOT NULL THEN 'Direct / no external touch' ELSE 'No web data' END web_first_touch,
 CASE WHEN p24.course_booking_pages>0 THEN 'Course booking flow' WHEN p24.catalogue_pages>0 THEN 'Course catalogue / course page' WHEN p24.media_pages>0 THEN 'Media library' WHEN p24.pages>0 THEN 'Membership pages only' ELSE 'No web activity' END pre_purchase_context,
 fb.min_to_first_booking, fb.first_booking_kind, fb.first_booking_days_to_event, fb.first_booking_on_credit, fb.first_booking_paid_eur,
 IFNULL(b7.bookings_7d_after,0) bookings_7d_after, fw.first_watch_days
FROM coh c LEFT JOIN u USING(user_id) LEFT JOIN bk USING(order_id) LEFT JOIN w USING(order_id) LEFT JOIN ms ON ms.membership_order_id=c.order_id LEFT JOIN pc ON pc.membership_order_id=c.order_id LEFT JOIN pg USING(order_id) LEFT JOIN anyp USING(order_id) LEFT JOIN p24 USING(order_id) LEFT JOIN fb USING(order_id) LEFT JOIN b7 USING(order_id) LEFT JOIN fw USING(order_id)
ORDER BY c.order_at
