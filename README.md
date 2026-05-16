/* =====================================================
   ZEPTO PRODUCT ANALYSIS PROJECT
   ===================================================== */
# Zepto SQL Data Analysis Project

## Overview

This project analyzes Zepto product and inventory data using SQL to uncover business insights related to pricing, discounts, stock availability, revenue estimation, and inventory distribution.

The project demonstrates practical SQL skills used in real-world data analysis and business intelligence workflows.

---

## Dataset Information

The dataset contains product-level information such as:

- Product Name
- Category
- MRP (Maximum Retail Price)
- Discounted Selling Price
- Discount Percentage
- Stock Availability
- Product Weight
- Available Quantity

---

## Objectives

The main objectives of this analysis are:

- Explore and understand the dataset
- Clean inconsistent or invalid data
- Analyze discount patterns
- Identify high-value products
- Estimate revenue contribution by category
- Compare product value using price-per-gram analysis
- Analyze inventory distribution across categories

---

## SQL Concepts Used

This project uses the following SQL concepts:

- SELECT Statements
- Aggregate Functions
- GROUP BY
- ORDER BY
- HAVING Clause
- CASE Statements
- Data Cleaning
- Filtering and Sorting
- Business-Oriented Analysis Queries

---

## Project Structure

```text
zepto-sql-analysis/
│
├── README.md
├── zepto_analysis.sql
├── dataset/
│   └── zepto_v2.csv
├── screenshots/
│   ├── category_revenue.png
│   ├── discount_analysis.png
│   └── inventory_analysis.png
```

---

## Business Questions Solved

### 1. Data Exploration
- Total number of products
- Product categories
- Sample product records

### 2. Stock Availability Analysis
- Products in stock vs out of stock
- Duplicate product detection

### 3. Data Cleaning
- Removed products with invalid pricing
- Converted paise values into rupees

### 4. Discount Analysis
- Identified products with the highest discounts
- Found categories offering maximum average discounts

### 5. Revenue Analysis
- Estimated category-wise revenue using inventory quantity and selling price

### 6. Premium Product Analysis
- Identified expensive products with low discount percentages

### 7. Value-for-Money Analysis
- Calculated price per gram for products above 100g

### 8. Product Segmentation
- Classified products into:
  - Low
  - Medium
  - Bulk

### 9. Inventory Weight Analysis
- Calculated total inventory weight available for each category

---

## Key Insights

- Some categories provide significantly higher discounts than others.
- Bulk products generally offer better value per gram.
- A few premium products maintain high prices despite minimal discounts.
- Certain categories contribute heavily to estimated inventory revenue.
- Inventory weight distribution highlights stock concentration across categories.

---

## Tools Used

- SQL Server / PostgreSQL / MySQL
- GitHub

---

## How to Run

1. Import the dataset into your SQL database.
2. Open the `zepto_analysis.sql` file.
3. Run queries sequentially.
4. Analyze outputs and insights.

---

## Future Improvements

- Build an interactive Power BI dashboard
- Add trend visualizations
- Perform category-wise profitability analysis
- Create inventory forecasting models

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
-- 4. BUSINESS QUESTIONS
--------------------------------------------------------

-- Top discounted products
SELECT TOP 10
    name,
    mrp,
    discountPercent
FROM zepto_v2
ORDER BY discountPercent DESC;

-- High MRP but out of stock
SELECT TOP 20
    name,
    mrp
FROM zepto_v2
WHERE outOfStock = 1
    AND mrp > 300;

-- Estimated revenue by category
SELECT
    category,
    SUM(discountedSellingPrice * availableQuantity) AS totalRevenue
FROM zepto_v2
GROUP BY category
ORDER BY totalRevenue DESC;

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

-- Top categories with highest discounts
SELECT
    category,
    AVG(discountPercent) AS averageDiscount
FROM zepto_v2
GROUP BY category
ORDER BY averageDiscount DESC;

--------------------------------------------------------
-- 5. VALUE ANALYSIS
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
-- 6. PRODUCT SEGMENTATION
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
-- 7. INVENTORY ANALYSIS
--------------------------------------------------------

-- Total inventory weight per category
SELECT
    category,
    SUM(weightInGms * availableQuantity) AS total_inventory_weight
FROM zepto_v2
GROUP BY category
ORDER BY total_inventory_weight;
