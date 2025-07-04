
/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/



with base_cte as (

select 
	s.order_number as order_number,
	s.product_key as product_key,
	s.order_date as order_date,
	s.sales_amount as sales_amount,
	s.quantity as quantity,
	c.customer_id as customer_id,
	c.customer_key,
	c.customer_number as customer_number,
	CONCAT(c.first_name , ' ' , c.last_name) as customer_name,
	DATEDIFF( year , c.birthdate, getdate()) as age

	from [gold.fact_sales] as s
	left join [gold.dim_customers] as c
	on s.customer_key = c.customer_key

	where s.order_date is not null
)
,customer_agg as (

select 
	customer_key,
 	customer_number,
	customer_name,
	age,
	COUNT(distinct order_number) as total_orders,
	SUM(sales_amount) as total_sales,
	sum( quantity) as total_quantity,
	count(distinct product_key) as total_product,
	max(order_date) as max_order_date,
	DATEDIFF(month, MAX(order_date),min(order_date)) as life_span
from base_cte
group by 
	customer_key,
   	customer_number,
	customer_name,
	age
)

select 
	customer_key,
 	customer_number,
	customer_name,
	age,
	case when age < 20 then 'under 20 '
	when age >20 and age <30 then '20-30'
	when age >30 and age < 45 then '30-45'
	when age > 45  and age< 55then '45-55'
	else ' > 55'
	end age_group,
	total_orders,
	 total_sales,
	total_quantity,
	total_product,
	max_order_date,
	life_span,
	 case when life_span > 12 and  total_sales > 5000 then 'VIP'
	 when life_span> 12 and total_sales <= 5000 then 'regular'
	 else 'new'
	end customer_segment 
from customer_agg;
