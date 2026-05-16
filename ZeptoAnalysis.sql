/* =====================================================
   ZEPTO PRODUCT ANALYSIS PROJECT
   ===================================================== */

--------------------------------------------------------
-- 1. DATA EXPLORATION
--------------------------------------------------------

-- Total rows
SELECT COUNT(*)
FROM zepto_v2;

-- Sample data
SELECT *
FROM zepto_v2;

-- Unique product categories
SELECT DISTINCT category
FROM zepto_v2
ORDER BY category;

--------------------------------------------------------
-- 2. STOCK ANALYSIS
--------------------------------------------------------

-- Products in stock vs out of stock
SELECT
    outOfStock,
    COUNT(name) AS total_products
FROM zepto_v2
GROUP BY outOfStock;

-- Duplicate product names
SELECT
    name,
    COUNT(name) AS duplicate_count
FROM zepto_v2
GROUP BY name
HAVING COUNT(name) > 1
ORDER BY duplicate_count DESC;

--------------------------------------------------------
-- 3. DATA CLEANING
--------------------------------------------------------

-- Products with MRP = 0
SELECT *
FROM zepto_v2
WHERE mrp = 0;

-- Remove invalid products
DELETE FROM zepto_v2
WHERE mrp = 0;

-- Convert paise to rupees
UPDATE zepto_v2
SET
    mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

--------------------------------------------------------
-- 4. DISCOUNT ANALYSIS
--------------------------------------------------------

-- Top discounted products
SELECT TOP 10
    name,
    mrp,
    discountPercent
FROM zepto_v2
ORDER BY discountPercent DESC;

-- Top categories with highest discounts
SELECT
    category,
    AVG(discountPercent) AS averageDiscount
FROM zepto_v2
GROUP BY category
ORDER BY averageDiscount DESC;

--------------------------------------------------------
-- 5. STOCK & PREMIUM PRODUCT ANALYSIS
--------------------------------------------------------

-- High MRP but out of stock
SELECT TOP 20
    name,
    mrp
FROM zepto_v2
WHERE outOfStock = 1
    AND mrp > 300;

-- Expensive products with low discount
SELECT
    category,
    name,
    mrp,
    discountPercent
FROM zepto_v2
WHERE mrp > 500
    AND discountPercent < 10
ORDER BY mrp DESC;

--------------------------------------------------------
-- 6. REVENUE ANALYSIS
--------------------------------------------------------

-- Estimated revenue by category
SELECT
    category,
    SUM(discountedSellingPrice * availableQuantity) AS totalRevenue
FROM zepto_v2
GROUP BY category
ORDER BY totalRevenue DESC;

--------------------------------------------------------
-- 7. VALUE ANALYSIS
--------------------------------------------------------

-- Price per gram analysis
SELECT
    name,
    discountedSellingPrice,
    weightInGms,
    ROUND(discountedSellingPrice / weightInGms, 2) AS pricePerGram
FROM zepto_v2
WHERE weightInGms >= 100
ORDER BY pricePerGram;

--------------------------------------------------------
-- 8. PRODUCT SEGMENTATION
--------------------------------------------------------

SELECT
    name,
    weightInGms,
    CASE
        WHEN weightInGms < 1000 THEN 'Low'
        WHEN weightInGms < 5000 THEN 'Medium'
        ELSE 'Bulk'
    END AS productCategory
FROM zepto_v2;

--------------------------------------------------------
-- 9. INVENTORY ANALYSIS
--------------------------------------------------------

-- Total inventory weight per category
SELECT
    category,
    SUM(weightInGms * availableQuantity) AS total_inventory_weight
FROM zepto_v2
GROUP BY category
ORDER BY total_inventory_weight;
