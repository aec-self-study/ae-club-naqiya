with base as (
  select 
    date_trunc(orders.created_at, week) as week,
    products.category as product_category, 
    sum(product_prices.price) as total_sales
  from {{ ref('order_items') }} 
  left join {{ ref('products') }} 
      on order_items.product_id = products.product_id
  left join {{ ref('orders') }} 
      on order_items.order_id = orders.order_id
  left join {{ ref('product_prices') }}
      on order_items.product_id = product_prices.product_id 
  group by 1,2
  order by 1 desc 
)

select 
  *
from base 
