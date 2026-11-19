-- Baseline for the ÖKG pilot: FOMF's own cardiology refreshers (AT, CH, DE), paid bookings, member share and money per event.
-- Run read-only: bq query --use_legacy_sql=false --project_id=fomf-dl < this file, or archive/b2c-value-journey/tools/mbq.sh -f <this file>
-- Money columns: individual_revenue_eur = non-member ticket revenue; member_cash_eur = cash members paid on top;
-- member_credit_value_eur = list-price value members booked through their All Access package (no cash to FOMF).
select country_code, brand_type, date(start_date_time) as event_date,
  count(*) as paid_bookings,
  countif(is_member) as member_bookings,
  round(100 * countif(is_member) / count(*)) as member_share_pct,
  countif(active_livestream_counts > 0) as livestream,
  countif(active_on_site_counts > 0) as on_site,
  round(sum(individual_revenue_eur)) as nonmember_ticket_revenue_eur,
  round(sum(member_cash_eur)) as member_cash_eur,
  round(sum(member_credit_value_eur)) as member_credit_value_eur,
  round(avg(if(not is_member, total_price_eur, null))) as avg_nonmember_price_eur
from `fomf-dl`.analysis.fct_course_bookings
where booking_status = 'PAID'
  and brand_type in ('UPDATE_REFRESHER', 'REFRESHER')
  and short_title in ('Kardiologie', 'Cardiologie')
  and start_date_time >= '2023-01-01' and start_date_time < '2026-12-31'
group by 1, 2, 3
order by 1, 3;

-- Reach: AT accounts with a cardiology specialty and how many hold an active package today (all package types).
-- with act as (select distinct user_id from `fomf-dl`.analysis.dim_user_memberships
--   where membership_start_datetime <= current_timestamp() and membership_end_datetime > current_timestamp() and membership_country = 'AUT')
-- select count(distinct u.user_id) as at_cardio_users, count(distinct act.user_id) as at_cardio_active_members
-- from `fomf-dl`.analysis.dim_users u left join act using (user_id)
-- where coalesce(u.country, u.registration_country) in ('AT', 'AUT')
--   and (u.specialty_v2_name_de_de like '%Kardiologie%' or u.speciality_group like '%Kardiologie%');
