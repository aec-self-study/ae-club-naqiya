/* grouping customers by when they signed up */ 
with customers as (
    select * from {{ ref('customers') }}
), 

base as (
    select
        date_trunc(first_order_at, month) as signup_month,
        count(*) as new_customers
    from customers 
    group by 1 
)

select * from final 
 