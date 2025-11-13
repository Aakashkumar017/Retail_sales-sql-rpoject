-- How many uniuque customers we have ?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales

--DATA CLEANING
--DELETE NULL VALE
DELETE FROM retail_sales
WHERE 
    retail_sales.transactions_id IS NULL
    OR
    retail_sales.sale_date IS NULL
    OR 
    retail_sales.sale_date IS NULL
    OR
    retail_sales.gender IS NULL
    OR
    retail_sales.category IS NULL
    OR
    retail_sales.quantiy IS NULL
    OR
    retail_sales.cogs IS NULL
    OR
    retail_sales.total_sale IS NULL;

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT 
	*
FROM retail_sales
WHERE retail_sales.sale_date='2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-202

SELECT 
 	retail_sales.transactions_id
FROM retail_sales
WHERE category='Clothing'
		AND
	  quantiy>=2
	  	AND
	  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category , sum(total_sale) FROM retail_sales
GROUP BY category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
	round(AVG(AGE))
FROM retail_sales
WHERE category='Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT 
	retail_sales.transactions_id 
FROM retail_sales
WHERE total_sale >1000




-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
	count(retail_sales.transactions_id), 
	category,
	retail_sales.gender 
FROM retail_sales
	GROUP BY  category,gender

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
	year,
	month,
	avg_sale,
	RANK() OVER(PARTITION BY year ORDER BY avg_sale DESC ) AS Rnk
FROM (
SELECT
	EXTRACT(YEAR FROM Sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale)  as avg_sale
FROM retail_sales
		group by EXTRACT(YEAR FROM Sale_date), 	
		EXTRACT(MONTH FROM sale_date)
) as t1
order by year ,Rnk , month

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT
	retail_sales.customer_id, 
	sum(total_sale) as total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale desc
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
	category,
	COUNT(DISTINCT customer_id)
FROM retail_sales
GROUP BY category


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM Sale_time)>12 THEN 'Afternoon'
		ELSE 'Evening'
	END AS SHIFT
FROM retail_sales


--show TABLE
SELECT * FROM retail_sales

--END RETAIL SALES PROJECT
		