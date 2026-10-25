SELECT 
    a.order_id,
    b.customer_id,
    b.order_date,
    b.order_status,
    GREATEST(
        MAX(b.updated_at),
        MAX(a.updated_at)
    ) AS last_modified_at,
    SUM(a.quantity) AS total_items,
    SUM(a.line_total) AS order_total

FROM {{ ref('stg_order_items') }} a

JOIN {{ ref('stg_orders') }} b
    ON a.order_id = b.order_id

GROUP BY 
    a.order_id,
    b.customer_id,
    b.order_date,
    b.order_status


{% if is_incremental() %}

HAVING GREATEST(
    MAX(b.updated_at),
    MAX(a.updated_at)
) > COALESCE(
    (
        SELECT t.last_modified_at
        FROM {{ this }} t
        WHERE t.order_id = a.order_id
    ),
    TIMESTAMP '1900-01-01'
)

{% endif %}