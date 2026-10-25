
SELECT order_id, order_item_id
FROM {{ ref('stg_order_items') }}
WHERE quantity <= 0 OR unit_price < 0