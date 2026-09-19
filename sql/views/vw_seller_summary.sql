-- Seller Summary View

CREATE OR REPLACE VIEW vw_seller_summary AS
SELECT
    oi.seller_id,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(*) AS products_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(SUM(oi.freight_value), 2) AS total_freight,
    ROUND(AVG(oi.price), 2) AS average_price
FROM order_items oi
GROUP BY oi.seller_id;