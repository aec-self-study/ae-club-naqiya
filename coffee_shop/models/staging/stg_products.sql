with source as (
    select * from {{ source('coffee_shop', 'products') }}
),

 renamed as (
    id as product_id,
    name, 
    category, 

    --timestamps 
    created_at
 )

 select * from renamed 