
-- Calculate the total sales per month 
-- and the running total of sales over time 

select 
 order_month,
 total_sales,
 sum(total_sales) over(partition by order_month order by order_month )  as running_total_sales
 from (
select 

	DATETRUNC(month,order_date) order_month,
	sum(sales_amount) as total_sales
	from [gold.fact_sales]
	where order_date is not null
	group by DATETRUNC(month,order_date)
)t ;
