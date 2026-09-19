-- 1. Check missing delivery dates in orders
SELECT
    COUNT(*) AS total_orders,
    COUNT(order_delivered_customer_date) AS delivered_orders,
    COUNT(*) - COUNT(order_delivered_customer_date) AS missing_delivery_dates
FROM orders;

-- 2. Check order status distribution
SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- 3. Check duplicate order IDs
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_order_ids,
    COUNT(*) - COUNT(DISTINCT order_id) AS duplicate_rows
FROM orders;

-- 4. Check missing product categories
SELECT
    COUNT(*) AS total_products,
    COUNT(product_category_name) AS products_with_category,
    COUNT(*) - COUNT(product_category_name) AS missing_categories
FROM products;

-- 5. Check missing product dimensions
SELECT
    COUNT(*) AS total_products,
    COUNT(product_weight_g) AS products_with_weight,
    COUNT(product_length_cm) AS products_with_length,
    COUNT(product_height_cm) AS products_with_height,
    COUNT(product_width_cm) AS products_with_width
FROM products;

-- 6. Check missing review scores
SELECT
    COUNT(*) AS total_reviews,
    COUNT(review_score) AS reviews_with_score,
    COUNT(*) - COUNT(review_score) AS missing_review_scores
FROM order_reviews;

-- 7. Check missing payment values
SELECT
    COUNT(*) AS total_payment_records,
    COUNT(payment_value) AS payments_with_value,
    COUNT(*) - COUNT(payment_value) AS missing_payment_values
FROM order_payments;

-- 8. Check duplicate product IDs
SELECT
    COUNT(*) AS total_product_rows,
    COUNT(DISTINCT product_id) AS unique_product_ids,
    COUNT(*) - COUNT(DISTINCT product_id) AS duplicate_rows
FROM products;

-- 9. Check missing customer states
SELECT
    COUNT(*) AS total_customers,
    COUNT(customer_state) AS customers_with_state,
    COUNT(*) - COUNT(customer_state) AS missing_states
FROM customers;

-- 10. Check missing seller states
SELECT
    COUNT(*) AS total_sellers,
    COUNT(seller_state) AS sellers_with_state,
    COUNT(*) - COUNT(seller_state) AS missing_states
FROM sellers;