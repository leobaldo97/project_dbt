
SELECT
    order_id,
    customer_id,
    order_date,
    {{ normalize_status('status') }} AS order_status,
    updated_at
FROM {{ source('ecommerce', 'orders') }}
