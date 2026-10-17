-- B2C membership ARR (annual recurring revenue) at the 1st of each month, stacked by country, in EUR.
-- ARR(d) = sum over paid B2C memberships active on d of (order price annualised by membership cycle),
-- CHF converted at fixed 1.05 (same rate as analysis.fct_course_bookings.total_price_eur).
-- Paid = the membership's originating order is PAID with price > 0; states REVOKED / NOT_PAID / OFFERED_BY_ADMIN excluded.
-- B2C = no group and no clinic membership. Active on d = start <= d < expiry (Europe/Berlin dates).
-- Known simplification: upgrade orders carry only the upgrade delta (very few in the window).
-- Window: Sep 2025 – Sep 2026. Metabase native question on database "Bigquery (fomf-dl)".

WITH months AS (
  SELECT d FROM UNNEST(GENERATE_DATE_ARRAY('2025-09-01', '2026-09-01', INTERVAL 1 MONTH)) AS d
),
paid AS (
  SELECT
    DATE(um.created_at, 'Europe/Berlin') AS start_d,
    DATE(um.expires_at, 'Europe/Berlin') AS end_d,
    m.country,
    o.total_price / 100 * IF(o.currency = 'CHF', 1.05, 1.0) AS price_eur,
    CASE m.cycle
      WHEN 'ONE_YEAR'        THEN 1
      WHEN 'THREE_YEARS'     THEN 1 / 3
      WHEN 'FOURTEEN_MONTHS' THEN 12 / 14
      WHEN 'SIX_MONTHS'      THEN 2
      WHEN 'THREE_MONTHS'    THEN 4
      WHEN 'TWO_MONTHS'      THEN 6
      WHEN 'ONE_MONTH'       THEN 12
      ELSE 1
    END AS annual_factor
  FROM `platform_raw_membershipservice.public_user_membership` um
  JOIN `platform_raw_membershipservice.public_membership_order` o ON o.id = um.created_from_membership_order_id
  JOIN `platform_raw_membershipservice.public_membership` m ON m.id = um.membership_id
  WHERE o.status = 'PAID' AND o.total_price > 0
    AND (um.group_membership_id  IS NULL OR um.group_membership_id  = '')
    AND (um.clinic_membership_id IS NULL OR um.clinic_membership_id = '')
    AND um.state NOT IN ('REVOKED', 'NOT_PAID', 'OFFERED_BY_ADMIN')
)
SELECT
  d AS month,
  country,
  ROUND(SUM(price_eur * annual_factor), 0) AS arr_eur
FROM months
JOIN paid ON d >= start_d AND d < end_d
GROUP BY 1, 2
ORDER BY 1, 2
