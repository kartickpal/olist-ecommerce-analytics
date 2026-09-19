-- Category Summary View

CREATE OR REPLACE VIEW vw_category_summary AS
SELECT
    COALESCE(ct.product_category_name_english, 'Unknown') AS category,
    COUNT(DISTINCT p.product_id) AS product_count,
    ROUND(SUM(oi.price), 2) AS category_revenue,
    ROUND(AVG(oi.price), 2) AS average_price
FROM products p
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    COALESCE(ct.product_category_name_english, 'Unknown');