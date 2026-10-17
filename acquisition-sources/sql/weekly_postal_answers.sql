-- Weekly count of "Postaussendung (Flyer)" answers in the booking survey (all paid/unpaid bookings) and "Postflyer" in the
-- membership survey, DACH, 2024 – Sep 2026. Used to date when each mailing landed.
SELECT DATE_TRUNC(DATE(b.booking_date,'Europe/Berlin'), WEEK(MONDAY)) wk, UPPER(IFNULL(b.country_code,b.booked_from_country)) country, 'booking' survey, COUNT(*) n
FROM `fomf-dl`.analysis.fct_course_booking_marketing_sources s JOIN `fomf-dl`.analysis.fct_course_bookings b USING(booking_id)
WHERE s.marketing_source_name_de LIKE 'Postaussendung%' AND b.booking_date >= '2023-11-01'
GROUP BY ALL
UNION ALL
SELECT DATE_TRUNC(DATE(o.created_at,'Europe/Berlin'), WEEK(MONDAY)), UPPER(m.country), 'membership', COUNT(*)
FROM `fomf-dl`.analysis.fct_membership_marketing_sources s
JOIN `fomf-dl`.platform_raw_membershipservice.public_membership_order o ON o.id=s.membership_order_id
JOIN `fomf-dl`.platform_raw_membershipservice.public_membership m ON m.id=o.membership_id
WHERE s.marketing_source_name_de LIKE 'Postflyer%' AND o.created_at >= '2023-11-01' AND o.status='PAID'
GROUP BY ALL ORDER BY 1,2,3