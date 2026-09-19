-- Executive KPI View

CREATE OR REPLACE VIEW vw_executive_kpis AS
SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_unique_id) AS total_customers,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value,
    ROUND(
        COUNT(*) FILTER (
            WHERE o.order_delivered_customer_date IS NOT NULL
              AND o.order_delivered_customer_date > o.order_estimated_delivery_date
        ) * 100.0
        / NULLIF(
            COUNT(*) FILTER (
                WHERE o.order_delivered_customer_date IS NOT NULL
            ),
            0
        ),
        2
    ) AS late_delivery_percentage
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN customers c
    ON o.customer_id = c.customer_id;