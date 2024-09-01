SELECT * FROM retail_sale

	
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
DELETE FROM retail_sale
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
	
-- Data analysis & Business analysis problems--

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
  
  select * from Retail_sale
  Where Sale_date = '2022-11-05'
  
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
--     the quantity sold is more than 4 in the month of Nov-2022
  
 SELECT *
FROM retail_sale
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4
	
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select 
   category ,
   sum(total_sale) as net_sale,
   count(*) as total_sale
from Retail_sale
group by 1


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
    avg(age) as AVG_age
from Retail_sale
where category = 'Beauty'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from Retail_sale
where Total_sale > 1000 



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
      category,
	  gender,
	  count(*) as total_trans
from retail_sale
group by
      category,
	  gender
order by 1



-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select 
      year,
	  month,
	  avg_sale
from (
select
	extract (year From Sale_date) As Year,
	extract (month from Sale_date) As Month,
	AVG(total_sale) as avg_sale,
	Rank() over(partition by Extract (year From Sale_date) order By avg(total_sale)desc) as rank
from Retail_sale 
group by 1,2 
	)
as T1
where Rank = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select 
     customer_id,
	 sum(total_sale) as total_sale
From Retail_sale
group By 1
order By 2 desc
limit 5

    

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
     category,
	 count(distinct customer_id) as Count_Uniqe
from Retail_sale
group by category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale
as
(select *,
   case 
    when extract(hour from Sale_time)< 12 Then 'morning'
	when extract(hour from Sale_time) between 12 AND 17 Then 'afternoon'
	else 'Evening'
  End as Shift 
From retail_sale
 )
select shift,
      count(*) as total_orders
 from Hourly_sale
 group BY Shift
 
 
-- END OF PROJECT__
 
