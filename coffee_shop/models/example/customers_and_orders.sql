/* pulling number of orders and first created order per customer */
with customer_orders as (
  select
    customer_id,
    count(*) as num_orders,
    min(created_at) as first_order_at
  from {{source('coffee_shop', 'orders')}} as orders 
  group by 1
)

/* pulling customer information, coalescing order information */ 
select 
  customers.id as customer_id,
  customers.name,
  customers.email,
  customer_orders.num_orders, 
  customer_orders.first_order_at
from {{source('coffee_shop', 'customers')}} as customers
left join customer_orders  
  on customers.id = customer_orders.customer_id 