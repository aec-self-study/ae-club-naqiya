{{ config (materialized='table') }}

with customers as (
      select * from {{ ref('stg_customers') }}
),

orders as (
  select * from {{ ref('stg_orders') }}
),


customer_orders as (
  select
     customer_id,
     count(*) as num_orders,
     min(created_at) as first_order_at
  from orders 
  group by 1
), 

base as (
  select 
    customers.id as customer_id,
    customers.name,
    customers.email,
    coalesce(customer_orders.n_orders, 0) as n_orders,
    customer_orders.first_order_at
from customers
left join customer_orders
  on customers.id = customer_orders.customer_id 
), 

select * from base 