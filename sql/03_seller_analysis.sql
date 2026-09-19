-- ============================================
-- OLIST E-COMMERCE SELLER ANALYSIS
-- ============================================

-- 1. Seller Revenue
SELECT
    oi.seller_id,
    ROUND(SUM(oi.price), 2) AS seller_revenue
FROM order_items oi
GROUP BY oi.seller_id
ORDER BY seller_revenue DESC;

-- 2. Products Sold
SELECT
    seller_id,
    COUNT(*) AS products_sold
FROM order_items
GROUP BY seller_id
ORDER BY products_sold DESC;

-- 3. Orders
SELECT
    seller_id,
    COUNT(DISTINCT order_id) AS total_orders
FROM order_items
GROUP BY seller_id
ORDER BY total_orders DESC;

-- 4. Average Price
SELECT
    seller_id,
    ROUND(AVG(price), 2) AS average_price
FROM order_items
GROUP BY seller_id
ORDER BY average_price DESC;

-- 5. Freight Cost
SELECT
    seller_id,
    ROUND(SUM(freight_value), 2) AS total_freight_cost
FROM order_items
GROUP BY seller_id
ORDER BY total_freight_cost DESC;

-- 6. Revenue Contribution
SELECT
    seller_id,
    ROUND(SUM(price), 2) AS seller_revenue,
    ROUND(
        SUM(price) * 100.0 /
        SUM(SUM(price)) OVER (),
        2
    ) AS revenue_contribution_pct
FROM order_items
GROUP BY seller_id
ORDER BY seller_revenue DESC;

-- 7. Top Seller by State
WITH seller_state_revenue AS (
    SELECT
        s.seller_state,
        oi.seller_id,
        ROUND(SUM(oi.price), 2) AS seller_revenue
    FROM sellers s
    JOIN order_items oi
        ON s.seller_id = oi.seller_id
    GROUP BY
        s.seller_state,
        oi.seller_id
),
ranked_sellers AS (
    SELECT
        seller_state,
        seller_id,
        seller_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY seller_state
            ORDER BY seller_revenue DESC
        ) AS seller_rank
    FROM seller_state_revenue
)
SELECT
    seller_state AS state,
    seller_id,
    seller_revenue
FROM ranked_sellers
WHERE seller_rank = 1
ORDER BY seller_revenue DESC;

-- 8. Seller Performance Summary
SELECT
    seller_id,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS products_sold,
    ROUND(SUM(price), 2) AS total_revenue,
    ROUND(SUM(freight_value), 2) AS total_freight,
    ROUND(AVG(price), 2) AS average_price
FROM order_items
GROUP BY seller_id
ORDER BY total_revenue DESC;