CREATE DATABASE pizza_sales_analysis;

DROP DATABASE IF EXISTS pizza_sales_analysis;
USE pizza_sales_analysis;

-- CREATING TABLE 
CREATE TABLE pizza_sales(
	pizza_id INT,
	order_id INT,
	pizza_name_id VARCHAR(50),
	quantity INT,
	order_date DATE,
	order_time TIME,
	unit_price DECIMAL(10,2),
	total_price DECIMAL(10,2),
    pizza_size VARCHAR(50),
	pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
	pizza_name TEXT
    );
    
-- Importing data 

USE pizza_sales_analysis;

LOAD DATA LOCAL INFILE 'C:/Users/dkraz/OneDrive/Desktop/pizza_sales/pizza_sales.csv'
INTO TABLE pizza_sales
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'   
IGNORE 1 ROWS;  

SELECT * FROM pizza_sales;
SELECT COUNT(*) as "totalData" FROM pizza_sales;
TRUNCATE TABLE pizza_sale;









