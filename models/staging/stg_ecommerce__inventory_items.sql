

SELECT *
FROM {{ source('raw_data', 'inventory_items') }} 
