-- Loading the data into SQL
Create Database SQL_Pratice3;
Use SQL_Pratice3;

-- Creating table SQL_pratice
Create table SQL_pratice(
Order_ID INT,
Product VARCHAR(50),
Quantity_ordered INT,
Price_Each INT,
Order_Date DATE,
Address VARCHAR(20)
);

-- Getting the first 10 rows of our table
Select * 
from SQL_pratice
Limit 5;

-- Calculating the total revenue for the fiscal year
select 
Sum(Quantity_ordered*Price_Each) as Total_Revenue,
sum(Quantity_ordered) as total_qty_ordered
From SQL_pratice;

-- Calculating the monthly revenue

-- First convert the date format
SELECT Order_Date, 
CAST(Order_Date AS DATE) AS date_format
FROM SQL_pratice;

-- Next we get the monthly revenue
SELECT 
MONTH(order_date) AS month, 
sum(Quantity_Ordered) as total_qty_sold,
Sum(Quantity_ordered*Price_Each) as Total_Revenue,
Round((Sum(Quantity_ordered*Price_Each) - 
	LAG(Sum(Quantity_ordered*Price_Each), 1) OVER (ORDER BY MONTH(order_date))) /
     LAG(Sum(Quantity_ordered*Price_Each), 1) OVER (ORDER BY MONTH(order_date)) * 100, 2)AS Revenue_pct_change
FROM SQL_Pratice
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);

-- Calculating the Revenue for each products
Select
Distinct Product,
Price_Each as Price,
sum(Quantity_Ordered) as total_qty_ordered,
Sum(Quantity_Ordered * Price_Each) as Total_Revenue
From SQL_pratice
Group by Product,Price
Order by Total_Revenue DESC;


-- Calulating the most expensive product
Select
Distinct Product,
Price_Each as Prices
From SQL_pratice
Order by Prices DESC;

-- Most ordered product
Select
Distinct Product,
sum(Quantity_Ordered) as total_qty_ordered
From SQL_pratice
Group by Product,Quantity_Ordered
Order by 2 DESC;

-- City with the most orders
SELECT
Address,
sum(Quantity_Ordered) as total_qty_ordered,
Sum(Quantity_Ordered * Price_Each) as Total_Revenue
FROM SQL_pratice
Group By Address
Order By Sum(Quantity_Ordered * Price_Each) DESC;

-- What is the sales for each quarter
SELECT 
  CASE 
    WHEN MONTH(Order_date) BETWEEN 1 AND 3 THEN 'Q1'
    WHEN MONTH(Order_date) BETWEEN 4 AND 6 THEN 'Q2'
    WHEN MONTH(Order_date) BETWEEN 7 AND 9 THEN 'Q3'
    ELSE 'Q4'
  END AS quarter,
  SUM(Quantity_Ordered * Price_Each) AS total_revenue
FROM SQL_pratice
GROUP BY quarter;

-- Calculating for products that has more that 500 orders
Select
Distinct Product,
sum(Quantity_ordered) as Quantity
From SQL_pratice
Group by Product,Quantity_Ordered
Having Quantity > 500
Order by Quantity DESC;

-- -- Displaying all activities in San francisco
Select *
From SQL_pratice
Where Address = 'San Francisco'
Limit 50;

-- Final look
Select
count(distinct Product) as products,
Count(distinct Address) as cities,
sum(Quantity_ordered) as Number_of_orders,
Sum(Quantity_ordered*Price_Each) as Total_Revenue
From SQL_Pratice;






