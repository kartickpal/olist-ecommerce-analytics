-- Seller Revenue Contribution View

CREATE OR REPLACE VIEW vw_seller_revenue_contribution AS
SELECT
    seller_id,
    ROUND(SUM(price), 2) AS seller_revenue,
    ROUND(
        SUM(price) * 100.0 /
        SUM(SUM(price)) OVER (),
        2
    ) AS revenue_contribution_pct
FROM order_items
GROUP BY seller_id;