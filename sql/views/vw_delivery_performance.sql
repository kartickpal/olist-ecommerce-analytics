-- Delivery Performance View

CREATE OR REPLACE VIEW vw_delivery_performance AS
SELECT
    order_id,
    order_status,
    order_purchase_timestamp,
    order_estimated_delivery_date,
    order_delivered_customer_date,
    ROUND(
        EXTRACT(
            EPOCH FROM (
                order_delivered_customer_date
                - order_purchase_timestamp
            )
        ) / 86400,
        2
    ) AS delivery_days,
    CASE
        WHEN order_delivered_customer_date > order_estimated_delivery_date
        THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;