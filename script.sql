-- Commandes récentes avec au moins 3 jours de retard (hors commandes annulées)
WITH recent_date AS (
    SELECT MAX(order_purchase_timestamp) AS max_date
    FROM orders
)
SELECT order_id, customer_id, order_delivered_customer_date, order_estimated_delivery_date
FROM orders, recent_date
WHERE order_status != 'cancelled'
AND order_delivered_customer_date >= DATE(order_estimated_delivery_date, '+3 days')
AND order_purchase_timestamp > DATE(max_date, '-3 months');

-- Vendeurs avec un chiffre d'affaires supérieur à 100 000 Real
SELECT seller_id, SUM(price + freight_value) AS total_revenue
FROM order_items
JOIN orders ON orders.order_id = order_items.order_id
WHERE orders.order_status = 'delivered'
GROUP BY seller_id
HAVING total_revenue > 100000;

-- Nouveaux vendeurs (moins de 3 mois) ayant vendu plus de 30 produits
WITH recent_date AS (
    SELECT MAX(order_purchase_timestamp) AS max_date
    FROM orders
)
SELECT order_items.seller_id, COUNT(order_items.product_id) AS total_products_sold
FROM order_items
JOIN sellers ON order_items.seller_id = sellers.seller_id
CROSS JOIN recent_date
WHERE order_items.shipping_limit_date >= DATE(max_date, '-3 months')
GROUP BY order_items.seller_id
HAVING total_products_sold > 30;

-- Les 5 codes postaux avec le pire score de reviews (plus de 30 reviews sur 12 mois)
WITH recent_review_date AS (
    SELECT MAX(review_creation_date) AS max_review_date
    FROM order_reviews
)
SELECT seller_zip_code_prefix, AVG(review_score) AS average_score, COUNT(review_id) AS total_reviews
FROM order_reviews
JOIN orders ON orders.order_id = order_reviews.order_id
JOIN order_items ON order_items.order_id = orders.order_id
JOIN sellers ON order_items.seller_id = sellers.seller_id
JOIN recent_review_date
WHERE review_creation_date >= DATE(max_review_date, '-12 months')
GROUP BY seller_zip_code_prefix
HAVING total_reviews > 30
ORDER BY average_score ASC
LIMIT 5;