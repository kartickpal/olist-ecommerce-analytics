-- ============================================
-- OLIST DELIVERY & OPERATIONS ANALYSIS
-- ============================================

-- 1. Average Delivery Days
SELECT
    ROUND(
        AVG(
            EXTRACT(
                EPOCH FROM (
                    order_delivered_customer_date
                    - order_purchase_timestamp
                )
            ) / 86400
        ),
        2
    ) AS average_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- 2. Late Orders
SELECT
    COUNT(*) AS late_orders
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_delivered_customer_date > order_estimated_delivery_date;

-- 3. Late-Delivery Percentage
SELECT
    ROUND(
        COUNT(*) FILTER (
            WHERE order_delivered_customer_date IS NOT NULL
              AND order_delivered_customer_date > order_estimated_delivery_date
        ) * 100.0
        / COUNT(*) FILTER (
            WHERE order_delivered_customer_date IS NOT NULL
        ),
        2
    ) AS late_delivery_percentage
FROM orders;

-- 4. Delivery Delay
SELECT
    order_id,
    ROUND(
        EXTRACT(
            EPOCH FROM (
                order_delivered_customer_date
                - order_estimated_delivery_date
            )
        ) / 86400,
        2
    ) AS delivery_delay_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
ORDER BY delivery_delay_days DESC;

-- 5. Estimated vs Actual Delivery
SELECT
    order_id,
    order_estimated_delivery_date,
    order_delivered_customer_date,
    ROUND(
        EXTRACT(
            EPOCH FROM (
                order_delivered_customer_date
                - order_estimated_delivery_date
            )
        ) / 86400,
        2
    ) AS delivery_difference_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
ORDER BY delivery_difference_days DESC;