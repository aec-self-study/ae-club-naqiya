/* grouping customers by when they signed up */ 
select
    date_trunc(first_order_at, month) as signup_month,
    count(*) as new_customers
from {{ ref('customers_and_orders') }}
group by 1
 