SELECT *
FROM "BRIGHT"."COFFEE"."SHOP";

---Exploratory Data Analysis

---Checking number of coffee stores
SELECT DISTINCT store_location
FROM "BRIGHT"."COFFEE"."SHOP";

---Checking number of product categories
SELECT DISTINCT product_category
FROM "BRIGHT"."COFFEE"."SHOP";

---Checking number of product types
SELECT DISTINCT product_type
FROM "BRIGHT"."COFFEE"."SHOP";

------Date & Time functions
----Checking the earliest transaction date
SELECT MIN (transaction_date) AS first_operating_date
FROM "BRIGHT"."COFFEE"."SHOP";

----Checking the last transaction date
SELECT MAX (transaction_date) AS last_operating_date
FROM "BRIGHT"."COFFEE"."SHOP";

----Checking the earliest time
SELECT MIN (transaction_time) AS earliest_time
FROM "BRIGHT"."COFFEE"."SHOP";

----Checking the latest time
SELECT MAX (transaction_time) AS latest_time
FROM "BRIGHT"."COFFEE"."SHOP";
________________________________________________________________________________________________________
-----Query for main table
SELECT product_category,
       SUM (transaction_qty*unit_price) AS revenue,
       store_location,
       transaction_date,
       product_type,
DAYNAME(transaction_date) AS day_name,
CASE
    WHEN DAYNAME (transaction_date) IN ('Sat','Sun') THEN 'Weekend'
    ElSE 'Weekday'
END AS day_classification,
MONTHNAME (transaction_date) AS month_name,
transaction_time,
CASE
    WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN '01. Morning'
    WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN '02. Afternoon'
    WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN '03. Evening'
    WHEN transaction_time >= '20:00:00' THEN '04. Night'
    END AS time_bucket,
    HOUR (transaction_time) AS hour_of_day
FROM "BRIGHT"."COFFEE"."SHOP"    
GROUP BY product_category,
         store_location,
         transaction_date,
         time_bucket,
         transaction_time,
         product_type
ORDER BY revenue DESC;
