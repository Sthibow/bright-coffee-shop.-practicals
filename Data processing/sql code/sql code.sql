 SELECT
    transaction_date AS purchase_date,
    DAYNAME(transaction_date) AS day_name,
    MONTHNAME(transaction_date) AS month_name,
    DAYOFMONTH(transaction_date) AS day_of_month,

    CASE
        WHEN DAYNAME(transaction_date) IN ('Monday','Tuesday','Wednesday','Thursday','Friday') THEN 'Weekday'
        ELSE 'Weekend'
    END AS day_classification,

    CASE
        WHEN DATE_FORMAT(transaction_date, 'HH:MM:SS') BETWEEN '00:00:00' AND '11:59:59' THEN '01.Morning'
        WHEN DATE_FORMAT(transaction_date, 'HH:MM:SS') BETWEEN '12:00:00' AND '17:59:59' THEN '02.Afternoon'
        WHEN DATE_FORMAT(transaction_date, 'HH:MM:SS') BETWEEN '18:00:00' AND '23:59:59' THEN '03.Evening'
        ELSE '04.Night'
    END AS time_of_day,

    COUNT(DISTINCT store_id) AS number_of_stores,
    COUNT(DISTINCT transaction_id) AS number_of_sales,
    COUNT(DISTINCT product_id) AS number_of_products,

    SUM(transaction_qty * unit_price) AS revenue_per_day,

    CASE
        WHEN SUM(transaction_qty * unit_price) <= 50 THEN '01.Low spender'
        WHEN SUM(transaction_qty * unit_price) BETWEEN 51 AND 100 THEN '02.Medium spender'
        ELSE '03.High spender'
    END AS spend_bucket,

    store_location,
    product_category,
    product_detail

FROM bright_coffee_shop_analysis

GROUP BY
    transaction_date,
    DAYNAME(transaction_date),
    MONTHNAME(transaction_date),
    DAYOFMONTH(transaction_date),
    CASE
        WHEN DAYNAME(transaction_date) IN ('Monday','Tuesday','Wednesday','Thursday','Friday') THEN 'Weekday'
        ELSE 'Weekend'
    END,
    CASE
        WHEN DATE_FORMAT(transaction_date, 'HH:MM:SS') BETWEEN '00:00:00' AND '11:59:59' THEN '01.Morning'
        WHEN DATE_FORMAT(transaction_date, 'HH:MM:SS') BETWEEN '12:00:00' AND '17:59:59' THEN '02.Afternoon'
        WHEN DATE_FORMAT(transaction_date, 'HH:MM:SS') BETWEEN '18:00:00' AND '23:59:59' THEN '03.Evening'
        ELSE '04.Night'
    END,
    store_location,
    product_category,
    product_detail;
     

