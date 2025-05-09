{% snapshot inventory_snapshot %}

{{
    config(
      target_schema='dbt_transformed',
      unique_key='id',
      strategy='timestamp',
      updated_at='created_at'
    )
}}

SELECT * 
FROM {{ source('raw_data', 'inventory_items') }}

{% endsnapshot %}