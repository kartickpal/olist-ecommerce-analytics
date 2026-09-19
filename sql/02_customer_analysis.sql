-- ============================================
-- OLIST E-COMMERCE CUSTOMER ANALYSIS
-- ============================================

-- 1. Total Customers
SELECT
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers;

-- 2. Customers by State
SELECT
    customer_state AS state,
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;

-- 3. Top Customers
SELECT
    c.customer_unique_id,
    ROUND(SUM(op.payment_value), 2) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spending DESC
LIMIT 10;

-- 4. Repeat Customers
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT o.order_id) >= 2
ORDER BY total_orders DESC;

-- 5. Customer Spending
SELECT
    c.customer_unique_id,
    ROUND(SUM(op.payment_value), 2) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_payments op
    ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spending DESC;

-- 6. Spending Segments
SELECT
    CASE
        WHEN total_spending < 100 THEN 'Low'
        WHEN total_spending < 500 THEN 'Medium'
        ELSE 'High'
    END AS spending_segment,
    COUNT(*) AS customer_count
FROM (
    SELECT
        c.customer_unique_id,
        SUM(op.payment_value) AS total_spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY c.customer_unique_id
) AS customer_spending
GROUP BY spending_segment
ORDER BY customer_count DESC;

-- 7. Top 3 Customers per state
WITH customer_spending AS (
    SELECT
        c.customer_unique_id,
        c.customer_state,
        ROUND(SUM(op.payment_value), 2) AS total_spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_payments op
        ON o.order_id = op.order_id
    GROUP BY
        c.customer_unique_id,
        c.customer_state
),
ranked_customers AS (
    SELECT
        customer_unique_id,
        customer_state,
        total_spending,
        ROW_NUMBER() OVER (
            PARTITION BY customer_state
            ORDER BY total_spending DESC
        ) AS customer_rank
    FROM customer_spending
)
SELECT
    customer_state AS state,
    customer_unique_id,
    total_spending,
    customer_rank
FROM ranked_customers
WHERE customer_rank <= 3
ORDER BY state, customer_rank;
