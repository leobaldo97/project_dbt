
SELECT 
	a.customer_id,
	a.customer_name,
	a.email,
	a.signup_date,
	a.country,
	r.region,
	COUNT(CASE WHEN b.order_status = 'completed' THEN b.order_id END) AS total_orders,
	SUM(CASE WHEN b.order_status = 'completed' THEN b.order_total ELSE 0 END) AS total_spent,
	ROUND(COALESCE(SUM(CASE WHEN b.order_status = 'completed' THEN b.order_total ELSE 0 END) / NULLIF(COUNT(CASE WHEN b.order_status = 'completed' THEN b.order_id END),0),0),2) AS avg_order_value
FROM {{ ref('stg_customers') }} a

LEFT JOIN  {{ ref('fct_orders') }} b

ON a.customer_id = b.customer_id

LEFT JOIN {{ ref('country_regions') }} r

ON a.country = r.country

GROUP BY 
	a.customer_id,
	a.customer_name,
	a.email,
	a.signup_date,
	a.country,
	r.region


