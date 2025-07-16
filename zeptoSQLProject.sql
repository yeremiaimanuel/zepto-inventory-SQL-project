DROP TABLE IF EXISTS Zepto

USE zeptoSQLProject

ALTER TABLE grocery
ADD sku_id INT IDENTITY(1,1) PRIMARY KEY;

-- 1. Data Exploration
-- a.Count row of data
SELECT COUNT (*) FROM grocery
-- b. Show sample data
SELECT TOP 10 * FROM grocery;
-- c. Check missing/NULL values
SELECT * FROM grocery
WHERE Category IS NULL
	OR name IS NULL
	OR mrp IS NULL
	OR discountPercent IS NULL
	OR availableQuantity IS NULL
	OR discountedSellingPrice IS NULL
	OR weightInGms IS NULL
	OR outOfStock IS NULL
	OR quantity IS NULL
-- d. Check various category of product
SELECT DISTINCT Category 
FROM grocery
GROUP BY Category
-- e. Check product in stock vs out of stock
SELECT outOfStock, COUNT(sku_id) as count
FROM grocery
GROUP BY outOfStock
-- f. List of number of SKU by name
SELECT name, COUNT (sku_id) as 'Number of SKUs'
FROM grocery
GROUP BY name
HAVING COUNT(sku_id)>1
ORDER BY COUNT(sku_id) DESC

-- 2. Data Cleaning
-- a. Check zero pricing
SELECT * FROM grocery
WHERE mrp=0 OR discountedSellingPrice=0

-- b. Handling zero pricing
DELETE FROM grocery
WHERE mrp=0 OR discountedSellingPrice=0

-- c. Convert Paise to Rupee
/* 
  For your information:
  This dataset contains currency values from India.
  In the Indian currency system:
    - 1 Rupee = 100 Paise
    - 1 Paise = 1/100 of a Rupee
*/
UPDATE grocery
SET mrp=mrp/100.0,
	discountedSellingPrice=discountedSellingPrice/100.0

SELECT mrp, discountedSellingPrice FROM grocery

-- Analyze Data
-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT 
	TOP 10 name, 
	mrp, 
	discountPercent
FROM grocery
ORDER BY discountPercent DESC	

-- Q2.What are the Products with High MRP but Out of Stock
SELECT 
	DISTINCT name,
	mrp
FROM grocery
WHERE outOfStock = 'True' and mrp > 300
ORDER BY mrp DESC;

-- Q3.Calculate Estimated Revenue for each category
SELECT 
	Category, 
	SUM(discountedSellingPrice * availableQuantity) AS estimated_revenue
FROM grocery
GROUP BY Category
ORDER BY estimated_revenue

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT 
	DISTINCT name, 
	mrp, 
	discountPercent
FROM grocery
WHERE mrp>500 AND discountPercent<10
ORDER BY mrp DESC, discountPercent DESC

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT 
	TOP 5 Category, 
	ROUND(AVG(discountPercent),2) AS average_discount
FROM grocery
GROUP BY Category
ORDER BY average_discount DESC

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT 
	name, 
	weightInGms, 
	discountedSellingPrice, 
	ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM grocery
WHERE weightInGms>100
ORDER BY price_per_gram

--Q7.Group the products into categories like Low, Medium, Bulk.
SELECT 
	DISTINCT name,
	weightInGms,
	CASE 
		WHEN WeightInGms>1000 THEN 'Low'
		WHEN WeightInGms>5000 THEN 'Medium'
		ELSE 'Bulk'
	END AS weight_category
FROM grocery

--Q8.What is the Total Inventory Weight Per Category 
SELECT 
	Category, 
	SUM(CAST(weightInGms AS BIGINT) * availableQuantity) AS total_weight
FROM grocery
GROUP BY Category
ORDER BY total_weight
