with source as (
    select * from {{ source('coffee_shop', 'customers') }}
),

 renamed as (
    id as customer_id,
    name,
    email 
  
 )

 select * from renamed 