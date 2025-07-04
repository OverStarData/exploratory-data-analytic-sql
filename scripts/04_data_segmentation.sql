
/*Segment products into cost ranges and 
count how many products fall into each segment*/



with category_sales as (

select 
p.category,
sum(s.sales_amount) as total_sales
from [gold.fact_sales] as s
left join [gold.dim_products] as p
on p.product_key = s.product_key
group by p.category
)

select 
category,
total_sales,
SUM(total_sales) over() as overall_sales,
CONCAT(round((CAST(total_sales as float) / SUM(total_sales) over()) * 100, 2), '%') percentage_of_total_sales
from category_sales
order by total_sales desc;



