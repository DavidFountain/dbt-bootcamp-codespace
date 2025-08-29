WITH LC AS (
    SELECT
        *
    FROM {{ref("dim_listings_cleansed")}}
),

HC AS (
    SELECT
        *
    FROM {{ref("dim_hosts_cleansed")}}
)

SELECT
    LC.listing_id
    ,LC.listing_name
    ,LC.room_type
    ,LC.minimum_nights
    ,LC.price
    ,LC.host_id
    ,HC.host_name
    ,HC.is_superhost AS host_is_superhost
    ,LC.created_at
    ,GREATEST(LC.updated_at, HC.updated_at) as updated_at
FROM LC
LEFT JOIN HC
    ON (LC.host_id = HC.host_id)
