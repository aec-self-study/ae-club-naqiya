/* finding the number of orders per customer and their first order */ 
with num_orders as (
  select 
    count(*) as num_orders, 
    customer_id, 
    min(created_at) as first_order 
  from  `analytics-engineers-club.coffee_shop.orders`
  group by 2
)

/* finding customer information and appending their number of orders*/ 
select 
id as customer_id,
name, 
email, 
num_orders,
first_order 
from `analytics-engineers-club.coffee_shop.customers` customers  
left join num_orders 
  on num_orders.customer_id = customers.id 
