
SELECT
    order_item_id,
    order_id,
    product_name,
    quantity,
    unit_price,
    quantity * unit_price AS line_total,
    updated_at
FROM {{ source('ecommerce', 'order_items') }}
