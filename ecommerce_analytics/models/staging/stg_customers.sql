
SELECT
    customer_id,
    customer_name,
    email,
    signup_date,
    country
FROM {{ source('ecommerce', 'customers') }}
