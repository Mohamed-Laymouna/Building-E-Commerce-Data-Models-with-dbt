WITH customer_base AS (
    SELECT 
        id AS user_id,
        first_name AS customer_first_name,
        last_name AS customer_last_name,
        country AS customer_country,
        traffic_source AS customer_acquisition_channel
    FROM {{ ref('stg_ecommerce__users')}}
)

, order_items AS (
    SELECT 
        user_id,
        SUM(sale_price) AS total_amount_spent,
        COUNT(DISTINCT id) AS total_items_purchased,
        MIN(created_at) AS first_order_completed_at,
        MAX(created_at) AS last_order_completed_at
    FROM {{ ref('stg_ecommerce__order_items') }}
    WHERE status = 'Complete'
    GROUP BY 1
)

, orders AS (
    SELECT * 
    FROM {{ ref('int_orders__pivoted') }}
)

, web_traffic AS (
    SELECT *
    FROM {{ ref('int_events__pivoted') }}
)

SELECT
    cb.user_id,
    -- dimensions
    cb.customer_first_name,
    cb.customer_last_name,
    cb.customer_country,
    cb.customer_acquisition_channel,
    -- facts 
    oi.total_amount_spent,
    oi.total_items_purchased,
    oi.first_order_completed_at,
    oi.last_order_completed_at,
    o.num_orders,
    o.num_orders_Shipped,
    o.num_orders_Complete,
    o.num_orders_Processing,
    o.num_orders_Cancelled,
    o.num_orders_Returned,
    wt.num_web_sessions,
    wt.num_traffic_source_Adwords,
    wt.num_traffic_source_Email,
    wt.num_traffic_source_Facebook,
    wt.num_traffic_source_Organic,
    wt.num_traffic_source_YouTube,
    wt.num_browser_Chrome,
    wt.num_browser_Firefox,
    wt.num_browser_Safari,
    wt.num_browser_IE,
    wt.num_browser_Other

FROM customer_base cb
LEFT JOIN order_items oi 
    on cb.user_id = oi.user_id
LEFT JOIN orders o
    ON cb.user_id = o.user_id 
LEFT JOIN web_traffic wt 
    ON cb.user_id = wt.user_id
