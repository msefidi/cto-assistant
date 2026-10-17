-- 24-month value (LTV proxy) of new B2C customers acquired Jun 2022 – Aug 2024, by entry product x career stage x specialty.
-- Revenue = cash: paid course bookings (total_price_eur) + PAID B2C membership orders (CHF x 1.05), within 24 months of the first purchase incl. it.
-- Base definitions as in new_customers_by_source.sql:
-- New B2C customers per month by self-reported source ("Wie haben Sie von uns erfahren?").
-- New customer = user's first paid purchase ever, for accounts created from Mar 2022 on
-- (older accounts were migrated and their earlier purchases are not in the data):
--   single course = PAID non-member course booking with price > 0
--   membership    = PAID B2C membership order (NEWLY_CREATED, no earlier user_membership)
-- Source: booking survey on the first paid booking (single course); new members are the
-- "Mitgliedschaft" bucket and are redistributed afterwards by the single-course mix.
-- Excluded: UK (GBR), FOMF staff accounts, answers "Test User" / "VA-Personal".
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
  SELECT o.user_id, o.created_at ts, 'Membership' kind, 'Membership' channel,
         o.total_price/100*IF(o.currency='CHF',1.05,1) eur, UPPER(m.country) country
  FROM `fomf-dl`.platform_raw_membershipservice.public_membership_order o
  JOIN `fomf-dl`.platform_raw_membershipservice.public_membership m ON m.id=o.membership_id
  LEFT JOIN `fomf-dl`.platform_raw_membershipservice.public_user_membership um ON um.created_from_membership_order_id=o.id
  WHERE o.status='PAID' AND IFNULL(o.group_membership_id,'')='' AND IFNULL(o.clinic_membership_id,'')=''
    AND o.total_price > 0 AND IFNULL(um.state,'') NOT IN ('REVOKED','NOT_PAID','OFFERED_BY_ADMIN')),  -- free (admin-offered) and revoked memberships are not purchases
first_buy AS (
  SELECT * FROM (SELECT * FROM bk UNION ALL SELECT * FROM mo)
  WHERE user_id NOT IN (SELECT user_id FROM staff)
  QUALIFY ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY ts, kind DESC)=1)
,
seg AS (  -- career stage + specialty group per user (same rules as b2c-value-journey prof CTE)
  SELECT user_id, stage,
    CASE WHEN ARRAY_LENGTH(g)=0 THEN 'Not stated' WHEN ARRAY_LENGTH(g)=1 THEN g[OFFSET(0)]
         WHEN ARRAY_LENGTH(g)=2 AND 'Innere Medizin' IN UNNEST(g) AND 'Kardiologie' IN UNNEST(g) THEN 'Kardiologie' ELSE 'Several' END spec
  FROM (
    SELECT user_id, stage,
      ARRAY(SELECT DISTINCT CASE TRIM(e)
              WHEN 'Allgemeinmedizin' THEN 'Allgemeinmedizin' WHEN 'Praktische Ärztin/Praktischer Arzt' THEN 'Allgemeinmedizin' WHEN 'Innere und Allgemeinmedizin (Hausarzt)' THEN 'Allgemeinmedizin'
              WHEN 'Innere Medizin' THEN 'Innere Medizin' WHEN 'Psychiatrie' THEN 'Psychiatrie' WHEN 'Psychiatrie und Psychotherapie' THEN 'Psychiatrie'
              WHEN 'Pädiatrie' THEN 'Pädiatrie' WHEN 'Kinder- und Jugendmedizin' THEN 'Pädiatrie'
              WHEN 'Kardiologie' THEN 'Kardiologie' WHEN 'Innere Medizin und Kardiologie' THEN 'Kardiologie'
              WHEN 'Gynäkologie' THEN 'Gynäkologie' WHEN 'Frauenheilkunde und Geburtshilfe' THEN 'Gynäkologie'
              WHEN 'Anästhesiologie' THEN 'Anästhesiologie' WHEN 'Neurologie' THEN 'Neurologie'
              ELSE 'Other' END
            FROM UNNEST(entries) e WHERE TRIM(e) <> '') g
    FROM (
      SELECT user_id,
        CASE occupation_type WHEN 'DOCTOR' THEN 'Facharzt' WHEN 'ASSISTANT_DOCTOR' THEN 'Assistenzarzt' ELSE 'Other / unknown' END stage,
        CASE WHEN specialty_v2_name_de_de IS NOT NULL THEN IF(IFNULL(ARRAY_LENGTH(specialities_v2),1) <= 1, [specialty_v2_name_de_de], SPLIT(specialty_v2_name_de_de, ', '))
             WHEN speciality_group IS NOT NULL THEN SPLIT(speciality_group, ', ') ELSE [] END entries
      FROM `fomf-dl`.analysis.dim_users WHERE DATE(created_at) >= '2022-03-01'))),
cust AS (SELECT f.user_id, f.ts, f.kind, f.country, s.stage, s.spec FROM first_buy f JOIN seg s USING(user_id)
  WHERE DATE(f.ts,'Europe/Berlin') BETWEEN '2022-06-01' AND '2024-08-31' AND f.channel!='EXCLUDE' AND f.country!='GBR'),
rev AS (
  SELECT c.user_id, SUM(IF(x.ts < TIMESTAMP_ADD(c.ts, INTERVAL 365 DAY), x.eur, 0)) r12, SUM(x.eur) r24
  FROM cust c JOIN (
    SELECT user_id, booking_date ts, total_price_eur eur FROM `fomf-dl`.analysis.fct_course_bookings WHERE booking_status='PAID' AND total_price_eur>0
    UNION ALL SELECT user_id, ts, eur FROM mo) x
  ON x.user_id=c.user_id AND x.ts >= c.ts AND x.ts < TIMESTAMP_ADD(c.ts, INTERVAL 730 DAY)
  GROUP BY 1)
SELECT c.kind, c.stage, c.spec, COUNT(*) customers, ROUND(AVG(IFNULL(r.r12,0))) ltv12, ROUND(AVG(IFNULL(r.r24,0))) ltv24,
  COUNTIF(EXISTS(SELECT 1 FROM mo m WHERE m.user_id=c.user_id AND m.ts>=c.ts AND m.ts < TIMESTAMP_ADD(c.ts, INTERVAL 730 DAY))) became_member
FROM cust c LEFT JOIN rev r USING(user_id) GROUP BY ALL ORDER BY 1,2,4 DESC