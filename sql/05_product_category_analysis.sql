-- ============================================
-- OLIST PRODUCT & CATEGORY ANALYSIS
-- ============================================

-- 1. Product Categories
SELECT
    COALESCE(ct.product_category_name_english, 'Unknown') AS category,
    COUNT(DISTINCT p.product_id) AS product_count
FROM products p
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY COALESCE(ct.product_category_name_english, 'Unknown')
ORDER BY product_count DESC;

-- 2. Category Revenue
SELECT
    COALESCE(ct.product_category_name_english, 'Unknown') AS category,
    ROUND(SUM(oi.price), 2) AS category_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY COALESCE(ct.product_category_name_english, 'Unknown')
ORDER BY category_revenue DESC;

-- 3. Average Price
SELECT
    COALESCE(ct.product_category_name_english, 'Unknown') AS category,
    ROUND(AVG(oi.price), 2) AS average_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY COALESCE(ct.product_category_name_english, 'Unknown')
ORDER BY average_price DESC;

-- 4. Top Products
SELECT
    oi.product_id,
    COALESCE(ct.product_category_name_english, 'Unknown') AS category,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    COUNT(*) AS items_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY
    oi.product_id,
    COALESCE(ct.product_category_name_english, 'Unknown')
ORDER BY product_revenue DESC
LIMIT 10;

-- 5. Category Ranking
WITH category_revenue AS (
    SELECT
        COALESCE(ct.product_category_name_english, 'Unknown') AS category,
        ROUND(SUM(oi.price), 2) AS category_revenue
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN category_translation ct
        ON p.product_category_name = ct.product_category_name
    GROUP BY COALESCE(ct.product_category_name_english, 'Unknown')
)
SELECT
    category,
    category_revenue,
    RANK() OVER (
        ORDER BY category_revenue DESC
    ) AS category_rank
FROM category_revenue
ORDER BY category_rank;

-- 6. Monthly Category Growth
WITH monthly_category_revenue AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
        COALESCE(ct.product_category_name_english, 'Unknown') AS category,
        SUM(oi.price) AS monthly_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN category_translation ct
        ON p.product_category_name = ct.product_category_name
    GROUP BY
        DATE_TRUNC('month', o.order_purchase_timestamp),
        COALESCE(ct.product_category_name_english, 'Unknown')
),
category_growth AS (
    SELECT
        month,
        category,
        ROUND(monthly_revenue, 2) AS monthly_revenue,
        ROUND(
            LAG(monthly_revenue) OVER (
                PARTITION BY category
                ORDER BY month
            ),
            2
        ) AS previous_month_revenue
    FROM monthly_category_revenue
)
SELECT
    TO_CHAR(month, 'YYYY-MM') AS month,
    category,
    monthly_revenue,
    previous_month_revenue,
    ROUND(
        (monthly_revenue - previous_month_revenue)
        * 100.0
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS growth_percentage
FROM category_growth
ORDER BY month, category;