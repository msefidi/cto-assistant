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
