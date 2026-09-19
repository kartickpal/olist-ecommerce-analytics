-- Monthly Category Growth View

CREATE OR REPLACE VIEW vw_monthly_category_growth AS
WITH monthly_category_revenue AS (
    SELECT
        DATE_TRUNC('month', o.order_purchase_timestamp)::date AS month,
        COALESCE(
            ct.product_category_name_english,
            'Unknown'
        ) AS category,
        SUM(oi.price) AS monthly_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    LEFT JOIN category_translation ct
        ON p.product_category_name = ct.product_category_name
    GROUP BY
        DATE_TRUNC('month', o.order_purchase_timestamp)::date,
        COALESCE(
            ct.product_category_name_english,
            'Unknown'
        )
),
category_growth AS (
    SELECT
        month,
        category,
        ROUND(monthly_revenue, 2) AS monthly_revenue,
        ROUND(
            LAG(monthly_revenue) OVER (
                PARTITION BY category
                ORDER BY month
            ),
            2
        ) AS previous_month_revenue
    FROM monthly_category_revenue
)
SELECT
    month,
    category,
    monthly_revenue,
    previous_month_revenue,
    ROUND(
        (monthly_revenue - previous_month_revenue)
        * 100.0
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS growth_percentage
FROM category_growth;