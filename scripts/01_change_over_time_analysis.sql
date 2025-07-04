

-- trends over time

-- Analyse sales performance over time

select 
	DATETRUNC(YEAR,order_date) as order_year,
	sum(sales_amount) as sales,
	count(distinct customer_key) as total_customers,
	sum(quantity) as total_quantity
from [gold.fact_sales]
where order_date is not null
group by DATETRUNC(YEAR,order_date)
order by DATETRUNC(YEAR,order_date);



select 
	DATETRUNC(month,order_date) as order_year,
	sum(sales_amount) as sales,
	count(distinct customer_key) as total_customers,
	sum(quantity) as total_quantity
from [gold.fact_sales]
where order_date is not null
group by DATETRUNC(month,order_date)
order by DATETRUNC(month,order_date)