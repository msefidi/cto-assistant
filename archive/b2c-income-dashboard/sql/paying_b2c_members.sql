-- Paying B2C members as of run date. Source: fomf-dl.analysis.dim_user_memberships + raw membership order/payment tables.
-- B2C 'regular' definition mirrors dbt fct_active_memberships_daily_wide (no group membership, excludes PJ/WSJ/KPJ companions and FOMF Klinik, excludes REVOKED and @fomf users).
-- 'Paying' additionally excludes OFFERED_BY_ADMIN (zero-price grants) and NOT_PAID (order still WAITING_FOR_PAYMENT).
WITH dedup AS (
  SELECT * FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY user_membership_id ORDER BY membership_start_datetime DESC) rn FROM `fomf-dl.analysis.dim_user_memberships`) WHERE rn=1
),
b2c AS (
  SELECT * FROM dedup
  WHERE (user_membership_state <> 'REVOKED' OR user_membership_state IS NULL)
    AND is_fomf_user = false
    AND group_membership_id IS NULL
    AND membership_name NOT IN ('FOMF PJ Begleiter','FOMF WSJ Begleiter','FOMF KPJ Begleiter','FOMF Klinik')
    AND CURRENT_DATE() BETWEEN DATE(membership_start_datetime) AND DATE(TIMESTAMP_SUB(membership_end_datetime, INTERVAL 86399 SECOND))
),
orders AS (
  SELECT * FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY id ORDER BY datastream_metadata.source_timestamp DESC) rn FROM `fomf-dl.platform_raw_membershipservice.public_membership_order`) WHERE rn=1
),
pays AS (
  -- latest payment record per order
  SELECT * FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY membership_order_id ORDER BY created_at DESC) rn FROM `fomf-dl.platform_raw_membershipservice.public_membership_payment`) WHERE rn=1
),
j AS (
  SELECT b.*, o.status order_status, o.total_price, o.membership_price, o.currency, o.is_upgrade_order, o.is_booking_conversion, p.payment_status, p.payment_method
  FROM b2c b
  LEFT JOIN orders o ON o.id = b.created_from_membership_order_id
  LEFT JOIN pays p ON p.membership_order_id = o.id
)
SELECT membership_country, membership_type, COUNT(*) paying_members, COUNTIF(renewal_status='CANCELED') cancellation_pending, COUNTIF(user_membership_state='PAUSED') paused
FROM j WHERE user_membership_state NOT IN ('OFFERED_BY_ADMIN','NOT_PAID') GROUP BY 1,2 ORDER BY 1,2;
