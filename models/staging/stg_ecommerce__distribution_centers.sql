WITH source AS (
  SELECT * FROM {{ ref('ecommerce__distribution_centers') }}
)

SELECT
  id,
  name,
  latitude,
  longitude
FROM source