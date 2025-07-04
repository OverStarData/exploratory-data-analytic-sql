/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */


WITH yearly_product_sales as (

select
year(s.order_date) as order_year,
sum(s.sales_amount) as current_sales,
p.product_name
from [gold.fact_sales] s
left join [gold.dim_products] p
on s.product_key = p.product_key
where s.order_date is not null
group by year(s.order_date),p.product_name
)

select 
order_year,
current_sales,
product_name,
AVG(current_sales) over(partition by product_name) as average_sales,
(current_sales - AVG(current_sales) over(partition by product_name)) as diff_avg ,
case when (current_sales - AVG(current_sales) over(partition by product_name))  > 0
then 'above avg'
when (current_sales - AVG(current_sales) over(partition by product_name)) <0
then 'below avg'
else 'avg'
end avg_status,

lag(current_sales) over(partition by product_name order by order_year) as previous_year_sales,
(current_sales - lag(current_sales) over(partition by product_name order by order_year)) as diff_sales,
case when (current_sales - lag(current_sales) over(partition by product_name order by order_year)) > 0
then 'increase'
when (current_sales - lag(current_sales) over(partition by product_name order by order_year)) < 0 
then 'decrease'
else 'no change'
end diff_sales_status
from yearly_product_sales
order by product_name , order_year;

