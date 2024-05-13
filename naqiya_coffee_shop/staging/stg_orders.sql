with source as (
    select * from {{ source('coffee_shop', 'orders') }}
),

 renamed as (
    id as order_id,
    customer_id,
    total as order_total, 

    -- location info
    address,
    state,
    zip, 

    --timestamps 
    created_at
 )

 select * from renamed 