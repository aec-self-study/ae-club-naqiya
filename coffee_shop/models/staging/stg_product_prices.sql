with source as (
    select * from {{ source('coffee_shop', 'product_prices') }}
),

 renamed as (
    id as product_prices_id,
    product_id, 
    price, 

    --timestamps 
    created_at,
    ended_at 
 )

 select * from renamed 