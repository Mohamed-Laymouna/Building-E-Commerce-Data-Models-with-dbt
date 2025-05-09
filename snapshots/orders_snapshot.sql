{% snapshot orders_snapshot %}

{{
    config(
      target_schema='dbt_transformed',
      unique_key='order_id',
      strategy='timestamp',
      updated_at='created_at' 
    )
}}

SELECT * 
FROM {{ source('raw_data', 'orders') }}

{% endsnapshot %}
