-- B2C membership revenue per month, stacked by country, in EUR (CHF converted at 1.05 — same fixed
-- rate the analytics team uses in analysis.fct_course_bookings.total_price_eur).
-- Basis: PAID membership orders by order creation month (payments land within the same hour, so
-- this is effectively cash basis). B2C = no group and no clinic membership on the order.
-- Net of revoked memberships (order whose resulting user membership is in state REVOKED — withdrawals).
-- Country comes from the membership catalog, because membership_country on orders is NULL before Jun 2026.
-- Window: Sep 2025 – Sep 2026 (strategy meeting). Intended as a Metabase native question on
-- database "Bigquery (fomf-dl)"; paste as-is (table names are unqualified on purpose).

SELECT
  DATE_TRUNC(DATE(o.created_at, 'Europe/Berlin'), MONTH) AS month,
  m.country                                                AS country,
  ROUND(SUM(o.total_price / 100 * IF(o.currency = 'CHF', 1.05, 1.0)), 0) AS revenue_eur
FROM `platform_raw_membershipservice.public_membership_order` o
JOIN `platform_raw_membershipservice.public_membership` m
  ON m.id = o.membership_id
WHERE o.status = 'PAID'
  AND (o.group_membership_id  IS NULL OR o.group_membership_id  = '')
  AND (o.clinic_membership_id IS NULL OR o.clinic_membership_id = '')
  AND o.id NOT IN (
    SELECT created_from_membership_order_id
    FROM `platform_raw_membershipservice.public_user_membership`
    WHERE state = 'REVOKED' AND created_from_membership_order_id IS NOT NULL
  )
  AND DATE(o.created_at, 'Europe/Berlin') BETWEEN '2025-09-01' AND '2026-09-30'
GROUP BY 1, 2
ORDER BY 1, 2
