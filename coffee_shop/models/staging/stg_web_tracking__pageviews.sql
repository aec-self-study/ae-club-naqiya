with source as (
    select * from {{ source('web_tracking', 'pageviews') }}
)

renamed as (
  select
    /*ids */ 
    distinct customer_id, 
    last_value(visitor_id) over (
      partition by customer_id 
      order by timestamp 
      rows between unbounded preceding and unbounded following 
    ) as visitor_id,
    
    /* visit attributes */ 
	  device_type,
    page,

    /* timestamps */ 
    timestamp as visited_at,
    lag (timestamp, 1) over 
      (partition by visitor_id order by timestamp) as last_visited_at

)

select * from renamed  
where extract (minute from visited_at) - extract(minute from last_visited_at) >= 30
  or last_visited_at is null
