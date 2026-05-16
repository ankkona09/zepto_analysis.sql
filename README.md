# Zepto SQL Data Analysis Project

## Overview

This project analyzes Zepto product and inventory data using SQL to uncover business insights related to pricing, discounts, stock availability, revenue estimation, and inventory distribution.

The project demonstrates practical SQL skills used in real-world data analysis and business intelligence workflows.

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


## Objectives

The main objectives of this analysis are:

- Explore and understand the dataset
- Clean inconsistent or invalid data
- Analyze discount patterns
- Identify high-value products
- Estimate revenue contribution by category
- Compare product value using price-per-gram analysis
- Analyze inventory distribution across categories

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


## Key Insights

- Some categories provide significantly higher discounts than others.
- Bulk products generally offer better value per gram.
- A few premium products maintain high prices despite minimal discounts.
- Certain categories contribute heavily to estimated inventory revenue.
- Inventory weight distribution highlights stock concentration across categories.


## Tools Used

- SQL Server 
- GitHub


## How to Run

1. Import the dataset into your SQL database.
2. Open the `zepto_analysis.sql` file.
3. Run queries sequentially.
4. Analyze outputs and insights.


## Future Improvements

- Build an interactive Power BI dashboard
- Add trend visualizations
- Perform category-wise profitability analysis
- Create inventory forecasting models


