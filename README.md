# 📦 Zepto Inventory SQL Project
This project involves the exploration, cleaning, and analysis of inventory data from Zepto, a quick-commerce grocery delivery platform. Built using SQL Server, this project demonstrates how to manage real-world datasets through SQL queries focusing on data quality, structure, and insight extraction.

## 📚 Project Overview
- Database Name: zeptoSQLProject
- Main Table: grocery
- Primary Key Added: sku_id (IDENTITY)

This dataset contains product information including category, pricing (MRP and discounted), quantity, weight, stock status, and more.

## 🧩 SQL Sections Covered
### 1. 🧭 Data Exploration
- Basic analysis to understand the structure and content of the dataset:
- Count rows and show sample data.
- Check for missing/null values.
- Explore distinct product categories.
- Analyze stock status and SKU distribution.

### 2. 🧹 Data Cleaning
- Steps taken to clean and standardize the dataset:
- Remove zero-priced items.
- Convert pricing from Paise to Rupees (1 Rupee = 100 Paise).
- Eliminate duplicate SKUs based on name.

### 3. 📊 Data Analysis & Business Insights
- Answering practical business questions using SQL:
- Top discounted products.
- High-MRP items that are out of stock.
- Revenue estimation by category.
- Best value products (price per gram).
- Category-level discount comparisons.
- Inventory weight classification.
- Total inventory weight per category.

## 🛠 Key SQL Techniques Used
- SELECT, WHERE, GROUP BY, HAVING, ORDER BY
- DISTINCT, TOP, CASE, ROUND, CAST
- Aggregate functions: SUM, AVG, COUNT
- Data cleaning via DELETE, UPDATE
- Type conversion for currency and large calculations
