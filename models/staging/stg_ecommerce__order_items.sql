

SELECT *
FROM {{ source('raw_data', 'order_items') }} 
