use pizza
go

create or alter view dbo.vw_KPI_1_Total_Orders As 
SELECT count(distinct order_id) As Total_orders
from pizza_sales

go

CREATE OR ALTER VIEW dbo.vw_KPI_2_Total_Revenue AS
SELECT SUM(total_price) AS [Total Revenue]
FROM dbo.pizza_sales;

go

create or alter view dbo.vw_Kpi_3_Avg_Order_Value As
select sum(total_price)/count(distinct order_id) As Avg_Order_Value
from pizza_sales

go

create or alter view dbo.vw_Kpi_4_Total_pizza_sold as
select sum(quantity) As Total_Pizza_sold
from pizza_sales

go  

CREATE OR ALTER VIEW dbo.vw_KPI_5_Avg_Pizzas_Per_Order AS
SELECT CAST(
         CAST(SUM(quantity) AS DECIMAL(10,2)) /
         CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))
       AS DECIMAL(10,2)) AS AVG_Pizzas_Per_Order
FROM dbo.pizza_sales;

go 

create or alter view dbo.vw_chart_1_Daily_Trend_Total_Orders As
select 
DATEPART(weekday,order_date) as Day_num,
DATENAME(weekday,order_date) as order_day,
COUNT(distinct order_id) as total_orders
 from pizza_sales
 group by datename(weekday,order_date), datepart(weekday,order_date);

 go
 
 create or alter view dbo.vw_Chart_2_Monthly_trend_for_Total_Orders as
Select
DATEPART(month,order_date) as Month_Num,
Datename(Month,order_date) as Month_name,
count(distinct order_id) as Total_orders
from pizza_sales
group by DATEPART(month,order_date), datename (month,order_date)

go

create or alter view dbo.vw_Chart_3_Pct_Sales_By_Category As
select
pizza_category,
ROUND(sum(Total_price),2) As Total_Sales,
Round(
      Sum(total_price)*100.0/ (SELECT sum(Total_price) FROM pizza_sales),2) As PTC
From pizza_sales
Group by pizza_category;

GO

CREATE OR ALTER VIEW dbo.vw_chart_4_PTC_Sales_By_Size As
SELECT 
Pizza_size,
Round(sum(Total_price),2) As total_sales,
Round(
sum(Total_Price)*100.0/(Select sum(total_price) FROM pizza_sales),2) As PTC
from pizza_sales
group by pizza_size

Go

create or alter view dbo.vw_chart_5_Total_Pizza_Sold_By_Category As
select pizza_category,
sum(Quantity) As Total_quantity_sold
from pizza_sales
group by pizza_category

Go
USE [Pizza];
GO

CREATE OR ALTER VIEW dbo.vw_Top5_Pizzas_By_Revenue AS
SELECT TOP 5
    pizza_name,
    ROUND(SUM(total_price), 2) AS Total_Revenue
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;
GO


 CREATE OR ALTER VIEW dbo.vw_Top5_Pizzas_By_Quantity AS
SELECT TOP 5
    pizza_name,
    ROUND(SUM(quantity), 2) AS Total_Quantity
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC;
GO

create or alter view dbo.vw_Top5_pizzas_by_Total_Orders As
Select Top 5
pizza_name ,
round(count(distinct Order_id),2) As Total_Orders
From pizza_sales
group by pizza_name
order by Total_orders DESC;

go 

CREATE OR ALTER VIEW dbo.vw_Bottom5_Pizzas_By_Revenue AS
SELECT TOP 5
pizza_name,
ROUND(SUM(total_price), 2) AS Total_Revenue
FROM dbo.pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;
GO

create or alter view dbo.vw_Bottom5_Pizzas_By_Quantity As
select Top 5
pizza_name,
round(sum(quantity),2) As Total_Quantity 
From pizza_sales
Group by pizza_name
Order by Total_Quantity Asc;
go


create or alter view dbo.vw_Bottom5_pizzas_by_Total_Orders As
Select Top 5
pizza_name ,
round(count(distinct Order_id),2) As Total_Orders
From pizza_sales
group by pizza_name
order by Total_orders Asc;

go



