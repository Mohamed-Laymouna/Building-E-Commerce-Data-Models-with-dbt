

SELECT 
    id,
    sequence_number,
    user_id,
    session_id,
    created_at,
    ip_address,
    city,
    state,
    postal_code,
    browser,
    traffic_source,
    uri,
    event_type

FROM {{ source('raw_data', 'events') }} 