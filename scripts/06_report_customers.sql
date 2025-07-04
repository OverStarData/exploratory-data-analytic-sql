

    -- group customers into  into three segment based on spending behavior

    -- vip:  at least 12 month history  and spending more than 5000
    -- regular: at least 12 month history  and spending more than 5000 or less
    -- new: lifespan less than 12 month


with customer_spending as (


select
c.customer_key,
SUM(s.sales_amount) as total_spending,
MIN(s.order_date) as first_order,
MAX(s.order_date) as last_order,
DATEDIFF(month, min(order_date), MAX(order_date)) as life_span
from [gold.fact_sales] as s
left join [gold.dim_customers] as c
on s.customer_key = c.customer_key
group by c.customer_key
)

select
COUNT(customer_key) as total_cutomers,
customer_segment
from
(
select 
customer_key,
case when life_span > 12 and  total_spending > 5000 then 'VIP'
 when life_span> 12 and total_spending <= 5000 then 'regular'
 else 'new'
end customer_segment
from customer_spending
)t
group by customer_segment
order by COUNT(customer_key) desc;
