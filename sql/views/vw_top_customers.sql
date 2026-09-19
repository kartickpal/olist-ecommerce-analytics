-- Top Customers View

CREATE OR REPLACE VIEW vw_top_customers AS
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
    c.customer_state;