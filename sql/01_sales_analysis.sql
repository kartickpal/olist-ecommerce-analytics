-- ============================================
-- OLIST E-COMMERCE SALES ANALYSIS
-- ============================================

-- 1. Total Revenue
SELECT
    SUM(price) AS total_revenue
FROM order_items;

-- 2. Monthly Revenue
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    SUM(oi.price) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_TRUNC('month', o.order_purchase_timestamp)
ORDER BY month;

-- 3. Revenue by Category
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

-- 4. Revenue by State
SELECT
    c.customer_state AS state,
    ROUND(SUM(oi.price), 2) AS state_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY state_revenue DESC;

-- 5. Average Order Value
SELECT
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id;

-- 6. Top Products
SELECT
    oi.product_id,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    COUNT(*) AS items_sold
FROM order_items oi
GROUP BY oi.product_id
ORDER BY product_revenue DESC
LIMIT 10;