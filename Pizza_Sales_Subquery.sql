select *
from pizza_sales


---Total sales for each pizza then selects the pizzas with the highest total sales within each category.

SELECT  pizza_name, pizza_category, total_sales
FROM (
    SELECT pizza_name, pizza_category, SUM(total_price) AS total_sales
    FROM pizza_sales
    GROUP BY pizza_name, pizza_category
) AS category_totals
WHERE total_sales = (
    SELECT MAX(total_sales)
    FROM (
        SELECT pizza_name, SUM(total_price) AS total_sales
        FROM pizza_sales s2
        WHERE s2.pizza_category = category_totals.pizza_category
        GROUP BY pizza_name
    ) AS category_max
) ORDER BY total_sales desc


--- This query lists all orders where the total price is above the average total for that same day for each pizza


SELECT 
    order_id,pizza_name
    order_date,
    total_price,
    (SELECT AVG(total_price)
     FROM pizza_sales s2
     WHERE s2.order_date = s1.order_date) AS avg_daily_total
FROM pizza_sales s1
WHERE total_price > (
    SELECT AVG(total_price)
    FROM pizza_sales s2
    WHERE s2.order_date = s1.order_date)



--- Pizza categories whose average total price is higher than the overall average across all

SELECT c.pizza_category, c.avg_category_price
FROM (
    SELECT pizza_category, AVG(total_price) AS avg_category_price
    FROM pizza_sales
    GROUP BY pizza_category
) c
WHERE c.avg_category_price > (SELECT AVG(total_price) FROM pizza_sales);


--- Pizzas whose total sales are above the average total sales across all pizzas

SELECT pizza_name, total_sales
FROM (
    SELECT pizza_name, SUM(total_price) AS total_sales
    FROM pizza_sales
    GROUP BY pizza_name
) AS pizza_totals
WHERE total_sales > (
    SELECT AVG(total_sales)
    FROM (
        SELECT SUM(total_price) AS total_sales
        FROM pizza_sales
        GROUP BY pizza_name
    ) AS all_pizza_totals
)
ORDER BY total_sales DESC;

--- Highest selling pizza for each day
SELECT s.order_date, s.pizza_name, s.total_sales
FROM (
    SELECT order_date, pizza_name, SUM(total_price) AS total_sales
    FROM pizza_sales
    GROUP BY order_date, pizza_name
) s
WHERE s.total_sales = (
    SELECT MAX(total_sales)
    FROM (
        SELECT order_date, pizza_name, SUM(total_price) AS total_sales
        FROM pizza_sales
        GROUP BY order_date, pizza_name
    ) AS daily_totals
    WHERE daily_totals.order_date = s.order_date
)
ORDER BY s.total_sales DESC


--- Pizzas with their sizes  whose total sales are above the overall average sales

SELECT pizza_size, pizza_name, total_sales
FROM (
    SELECT pizza_size, pizza_name, SUM(total_price) AS total_sales
    FROM pizza_sales
    GROUP BY pizza_size, pizza_name
) AS size_totals
WHERE total_sales > (
    SELECT AVG(size_total)
    FROM (
        SELECT SUM(total_price) AS size_total
        FROM pizza_sales
        GROUP BY pizza_size, pizza_name
    ) AS all_size_totals
)
ORDER BY pizza_size, total_sales DESC;