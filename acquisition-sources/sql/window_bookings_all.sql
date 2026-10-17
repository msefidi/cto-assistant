-- All paid course bookings (new and existing customers) 1 Jan – 22 Sep per year, DACH, by period and whether the
-- booking survey answer was the postal flyer. Cash = total_price_eur (members pay mostly with credit, so their cash is small).
SELECT EXTRACT(YEAR FROM DATE(b.booking_date,'Europe/Berlin')) yr,
  CASE WHEN FORMAT_DATE('%m-%d', DATE(b.booking_date,'Europe/Berlin')) <= '05-31' THEN 'A' WHEN FORMAT_DATE('%m-%d', DATE(b.booking_date,'Europe/Berlin')) <= '08-17' THEN 'B' ELSE 'C' END period,
  b.is_member, s.marketing_source_name_de LIKE 'Postaussendung%' postal,
  COUNT(*) bookings, ROUND(SUM(IFNULL(b.total_price_eur,0))) cash_eur, ROUND(SUM(IFNULL(b.member_credit_value_eur,0))) credit_value_eur
FROM `fomf-dl`.analysis.fct_course_bookings b LEFT JOIN `fomf-dl`.analysis.fct_course_booking_marketing_sources s USING(booking_id)
WHERE b.booking_status='PAID' AND NOT IFNULL(b.is_fomf_user,false) AND UPPER(IFNULL(b.country_code,b.booked_from_country)) IN ('DEU','AUT','CHE')
  AND EXTRACT(YEAR FROM DATE(b.booking_date,'Europe/Berlin')) BETWEEN 2024 AND 2026
  AND FORMAT_DATE('%m-%d', DATE(b.booking_date,'Europe/Berlin')) BETWEEN '01-01' AND '09-22'
  AND b.content_type IN ('LIVE_COURSE','ONDEMAND_COURSE')
GROUP BY ALL ORDER BY 1,2,3,4
