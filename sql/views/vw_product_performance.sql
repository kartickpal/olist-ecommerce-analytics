-- Product Performance View

CREATE OR REPLACE VIEW vw_product_performance AS
SELECT
    oi.product_id,
    COALESCE(ct.product_category_name_english, 'Unknown') AS category,
    COUNT(*) AS items_sold,
    ROUND(SUM(oi.price), 2) AS product_revenue,
    ROUND(AVG(oi.price), 2) AS average_price
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
GROUP BY
    oi.product_id,
    COALESCE(ct.product_category_name_english, 'Unknown');