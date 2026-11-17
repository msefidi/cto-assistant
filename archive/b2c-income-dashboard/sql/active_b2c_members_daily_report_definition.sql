-- "Active B2C members" — EXACT definition of the Metabase card "Total B2C" (question 959)
-- on the "Daily Membership Update" dashboard (265). Question 959 is built on the saved
-- native question "Dim User Memberships B2C" (question 2891). Reproduced here for BigQuery.
-- Used by dashboard "B2C Membership Income" (1816), questions 7855 (scalar) and 7856 (by country/type).
-- NOTE: counts ACTIVE, not PAYING — includes NOT_PAID and OFFERED_BY_ADMIN states (~390 in Sep 2026).
-- The stricter "paying" variant is in paying_b2c_members.sql.

WITH b2c AS (   -- = question 2891
  SELECT *
  FROM `fomf-dl.analysis.dim_user_memberships`
  WHERE (group_membership_id IS NULL OR group_membership_id = '')
    AND (clinic_membership_id IS NULL OR clinic_membership_id = '')
    AND (NOT LOWER(email) LIKE '%fomf%' OR email IS NULL)
    AND membership_name NOT IN ('FOMF PJ Begleiter','FOMF KPJ Begleiter','FOMF WSJ Begleiter','FOMF Empfehlungsmitgliedschaft')
)
SELECT membership_country, membership_type, COUNT(DISTINCT user_id) AS active_members
FROM b2c
WHERE membership_end_datetime >= CURRENT_TIMESTAMP()   -- question 959 filter
  AND is_fomf_user = FALSE                              -- question 959 filter
GROUP BY 1, 2
ORDER BY 1, 2;
