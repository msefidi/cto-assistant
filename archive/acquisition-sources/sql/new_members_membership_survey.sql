-- New B2C customers per month by self-reported source ("Wie haben Sie von uns erfahren?").
-- New customer = user's first paid purchase ever (since platform history starts May 2022):
--   single course = PAID non-member course booking with price > 0
--   membership    = PAID B2C membership order (NEWLY_CREATED, no earlier user_membership)
-- Cross-check: new members' own answer in the MEMBERSHIP checkout survey (multi-select; each answer weighted 1/k).
-- Source: booking survey on the first paid booking (single course); new members are the
-- "Mitgliedschaft" bucket and are redistributed afterwards by the single-course mix.
-- Excluded: FOMF staff accounts, answers "Test User" / "VA-Personal".
WITH src AS (
  SELECT booking_id, CASE
    WHEN m LIKE 'E-Mail%' OR m LIKE '%Newsletter%' THEN 'Email / newsletter'
    WHEN m LIKE 'Empfehlung%' THEN 'Colleague recommendation'
    WHEN m LIKE 'Beilage%' THEN 'Print: journal insert'
    WHEN m LIKE 'Inserat%' THEN 'Print: journal ad'
    WHEN m LIKE 'Postaussendung%' OR m LIKE '%Flyer) UK' THEN 'Print: postal flyer'
    WHEN m LIKE 'Plakat%' THEN 'Print: clinic poster'
    WHEN m LIKE 'Google%' OR m LIKE 'Bing%' THEN 'Search'
    WHEN m IN ('Facebook','Instagram','LinkedIn') THEN 'Social media'
    WHEN m LIKE 'Kongress%' THEN 'Congress / fair'
    WHEN m LIKE 'Referent%' THEN 'Speaker'
    WHEN m LIKE 'FomF%' OR m LIKE 'Ehemalig%' THEN 'FOMF website / former participant'
    WHEN m LIKE 'Einladung%' OR m LIKE 'Mitarbeiter:in Sponsor%' THEN 'Invitation / sponsor'
    WHEN m = 'Mitgliedschaft' THEN 'Membership'
    WHEN m IN ('Test User','VA-Personal') THEN 'EXCLUDE'
    ELSE 'Other' END channel
  FROM (SELECT booking_id, marketing_source_name_de m FROM `fomf-dl`.analysis.fct_course_booking_marketing_sources)),
staff AS (SELECT DISTINCT user_id FROM `fomf-dl`.analysis.fct_course_bookings WHERE is_fomf_user),
bk AS (  -- paid single-course bookings
  SELECT b.user_id, b.booking_date ts, 'Single course' kind, IFNULL(s.channel,'(no answer)') channel,
         b.total_price_eur eur, UPPER(IFNULL(b.country_code, b.booked_from_country)) country
  FROM `fomf-dl`.analysis.fct_course_bookings b LEFT JOIN src s USING(booking_id)
  WHERE b.booking_status='PAID' AND NOT b.is_member AND b.total_price_eur > 0),
mo AS (  -- paid B2C membership orders (any; the earliest one per user is the join)
  SELECT o.user_id, o.created_at ts, 'Membership' kind, o.id channel,
         o.total_price/100*IF(o.currency='CHF',1.05,1) eur, UPPER(m.country) country
  FROM `fomf-dl`.platform_raw_membershipservice.public_membership_order o
  JOIN `fomf-dl`.platform_raw_membershipservice.public_membership m ON m.id=o.membership_id
  LEFT JOIN `fomf-dl`.platform_raw_membershipservice.public_user_membership um ON um.created_from_membership_order_id=o.id
  WHERE o.status='PAID' AND IFNULL(o.group_membership_id,'')='' AND IFNULL(o.clinic_membership_id,'')=''
    AND o.total_price > 0 AND IFNULL(um.state,'') NOT IN ('REVOKED','NOT_PAID','OFFERED_BY_ADMIN')),  -- free (admin-offered) and revoked memberships are not purchases
first_buy AS (
  SELECT * FROM (SELECT * FROM bk UNION ALL SELECT * FROM mo)
  WHERE user_id NOT IN (SELECT user_id FROM staff)
  QUALIFY ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY ts, kind DESC)=1),
msrc AS (SELECT membership_order_id, CASE
    WHEN m LIKE 'E-Mail%' OR m LIKE '%Newsletter%' THEN 'Email / newsletter'
    WHEN m LIKE 'Empfehlung%' THEN 'Colleague recommendation'
    WHEN m LIKE 'Beilage%' THEN 'Print: journal insert'
    WHEN m LIKE 'Inserat%' THEN 'Print: journal ad'
    WHEN m LIKE 'Postflyer%' THEN 'Print: postal flyer'
    WHEN m LIKE 'Plakat%' THEN 'Print: clinic poster'
    WHEN m LIKE 'Google%' OR m LIKE 'Bing%' THEN 'Search'
    WHEN m IN ('Facebook','Instagram','LinkedIn') OR m LIKE 'Social%' THEN 'Social media'
    WHEN m LIKE 'FomF%' OR m LIKE 'Ehemalig%' THEN 'FOMF website / former participant'
    WHEN m = 'FOMF Klinik' THEN 'FOMF Klinik'
    WHEN m LIKE 'ChatGPT%' THEN 'AI tool'
    ELSE 'Other' END channel
  FROM (SELECT membership_order_id, marketing_source_name_de m FROM `fomf-dl`.analysis.fct_membership_marketing_sources)),
msw AS (SELECT membership_order_id, channel, COUNT(*) OVER (PARTITION BY membership_order_id) k FROM msrc)
SELECT CASE WHEN DATE(f.ts,'Europe/Berlin')<'2024-09-01' THEN 'Y0' WHEN DATE(f.ts,'Europe/Berlin')<'2025-09-01' THEN 'Y1' ELSE 'Y2' END yr, f.country, IFNULL(ms.channel,'(no answer)') channel, ROUND(SUM(IFNULL(1/ms.k,1)),2) n
FROM first_buy f JOIN `fomf-dl`.analysis.dim_users u USING(user_id) LEFT JOIN msw ms ON ms.membership_order_id=f.channel
WHERE f.kind='Membership' AND DATE(f.ts,'Europe/Berlin') BETWEEN '2023-09-01' AND '2026-08-31'
  AND DATE(u.created_at) >= '2022-03-01' AND f.country!='GBR'
GROUP BY ALL ORDER BY 1,2,4 DESC