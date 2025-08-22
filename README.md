Subquery : Pizza Sales Analysis

Note: This is not an actual business project, but a set of example queries designed to demonstrate the use of subqueries in SQL. The queries provide insights into pizza sales data and illustrate how subqueries can be used to calculate totals, averages, and top performers across different categories, days, and sizes.

This project demonstrates the use of subqueries in SQL to analyze pizza sales data. 
we investigate sales patterns across various dimensions: by pizza type, by category, by individual order, by day, and by size. The queries highlight methods for aggregating data, contrasting with averages, and pinpointing top performers.

Queries Included:

1. View all data
   
SELECT * FROM pizza_sales;

2. Top-Selling pizza category

SELECT pizza_name, pizza_category, total_sales
.......

3. Orders above daily average

SELECT order_id, pizza_name, order_date, total_price, ...

4. Categories above overall average price

SELECT c.pizza_category, c.avg_category_price ...

5. Pizzas above overall average sales

SELECT pizza_name, total_sales ...

6. Highest-selling pizza each day

SELECT s.order_date, s.pizza_name, s.total_sales ...

8. Pizzas with sizes above average sales

SELECT pizza_size, pizza_name, total_sales ...
