-- my frist sql project sql_project_p2--
create database sql_project_p2;


create table retail_sales (
			
			transactions_id int primary key,	
			sale_date date,	
			sale_time time,
			customer_id	int,
			gender varchar(20),
			age	int,
			category varchar(20),
			quantiy	int,
			price_per_unit int,
			cogs float,
			total_sale int
			
);

--limit ---
select*
from retail_sales
limit 10;

---count(*)----

select count(*)
from retail_sales;


--customer id count--
select count(customer_id)
from retail_sales;

--distinct--
select count(distinct quantiy)
from retail_sales;

select count(distinct category)
from retail_sales;

--null values & delet---
select *
from retail_sales 
where 	transactions_id	IS NULL or
		sale_date IS NULL or	
		sale_time IS NULL or	
		customer_id	IS NULL or
		gender IS NULL or	
		age	IS NULL or
		category IS NULL or
		quantiy	IS NULL or
		price_per_unit IS NULL or
		cogs IS NULL or
		total_sale	IS NULL ; 

delete from retail_sales
where 	transactions_id	IS NULL or
		sale_date IS NULL or	
		sale_time IS NULL or	
		customer_id	IS NULL or
		gender IS NULL or	
		age	IS NULL or
		category IS NULL or
		quantiy	IS NULL or
		price_per_unit IS NULL or
		cogs IS NULL or
		total_sale IS NULL;

--data analysis & busness problems--		

1) write a quary to retrive all the column for sales made on 22-11-05? 
select sale_date
from retail_sales
where sale_date='05-11-22';

2)write a quary to retrive all the transictions where the catogary is clothing and the quantiy is 
sold more then 10 in the month of nov_22?
select*
from retail_sales
where 
      category = 'clothing'
and
      TO_CHAR(sale_date,'YYYY-MM')='2022-11'
and
      quantiy >= 4;
select distinct category
from retail_sales;
select min(sale_date),max(sale_date)
from retail_sales;
select*
from retail_sales
where to_char(sale_date,'YYYY-MM')='2022-11'
AND
      quantiy>= 4;
3)write a quary to calculate total sale for each category?
select category, 
    sum (quantiy * price_per_unit)as total_sales
from retail_sales
 group by category;

4)write a sql query to find the average age of customers who purchased items from the 'beauty' category?
select 
round (avg(age),2) as avg_age
from retail_sales
where category='beauty';

5)write a sql query to find all transactions where the total_sales is greater then 1000?
select transactions_id
from retail_sales
where total_sale>1000;

6)write a sql query to find the total number of transactions (transactuon_id)made by each gender
by each category?
select  gender,category,count(transactions_id)
from retail_sales
group by gender,category
order by gender,category;

7)write a sql query to calculate the average sale for each month. find out best selling month in each year?
select 
       year,
	   month,
	   avg_sale
from
(select
		extract(year from sale_date)as year,
		extract(month from sale_date)as month,
		avg(total_sale)as avg_sale,
		rank()over(partition by extract(year from sale_date)order by avg(total_sale)desc)as rank
from retail_sales
group by 1,2
)as t1
where rank=1

8)write a sql query to find the top 5 customers based on the highest total sales?
select customer_id,sum(total_sale)as total_sales
From retail_sales
group by customer_id
order by 2 DESC
LIMIT 5;

9)WRITE A SQL QUERRY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY?
SELECT CATEGORY,COUNT(DISTINCT customer_id)AS CNT_UNIQUE_CS
FROM RETAIL_SALES
GROUP BY CATEGORY;

10)WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS(EXAMPLE MORNING<12,AFTERNOON BETWEEN 12&17,EVENING>17)?
WITH HOURLY_SALE
AS
(
SELECT *,
	CASE 
		WHEN EXTRACT(HOUR FROM SALE_TIME)<12 THEN 'MORNING'
		WHEN EXTRACT (HOUR FROM SALE_TIME)BETWEEN 12 AND 17 THEN 'AFTERNOON'
		END AS SHIFT
FROM RETAIL_SALES
)
SELECT
	SHIFT,
	COUNT(*)AS TOTAL_ORDERS
FROM HOURLY_SALE
GROUP BY SHIFT

--END OF PROJECT--
