# 🍕 Pizza Sales Analysis & Dashboard

![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Level](https://img.shields.io/badge/Level-Intermediate--Advanced-green)
![Queries](https://img.shields.io/badge/Queries-30-orange)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![GitHub last commit](https://img.shields.io/github/last-commit/mr-deepak-kp/pizza_sales_sql_project)
![GitHub repo size](https://img.shields.io/github/repo-size/mr-deepak-kp/pizza_sales_sql_project)
![GitHub stars](https://img.shields.io/github/stars/mr-deepak-kp/pizza_sales_sql_project?style=social)
![GitHub forks](https://img.shields.io/github/forks/mr-deepak-kp/pizza_sales_sql_project?style=social)

---

## 📌 Project Overview

This project performs a comprehensive SQL-based analysis of a **Pizza Sales dataset** to extract meaningful business insights and answer real-world KPI-driven questions.

The analysis covers revenue trends, order patterns, best and worst-selling pizzas, category-wise and size-wise breakdowns — helping understand sales strategy and business performance.

---

## 🎯 Objectives

- 💰 Calculate key revenue and order KPIs
- 📅 Analyze daily and hourly order trends
- 🍕 Identify top and bottom selling pizzas
- 📊 Calculate percentage contribution by category and size
- 📆 Explore monthly and quarterly revenue trends
- 🔍 Find peak days, hours, and high-value items

---

## 🧠 Skills Demonstrated

| Skill | Description |
|-------|-------------|
| SQL (Intermediate Level) | Aggregations, filtering, sorting |
| KPI Calculations | Revenue, average order value, quantity sold |
| Date & Time Functions | DAYNAME, HOUR, MONTH, QUARTER |
| Subqueries | Percentage contribution calculations |
| GROUP BY & ORDER BY | Category, size, name-level breakdowns |
| LIMIT | Top N / Bottom N analysis |
| CAST & DECIMAL | Precise numeric formatting |
| Business Problem Solving | Translating business questions into SQL |

---

## 🏗️ Database Schema

```sql
CREATE DATABASE pizza_sales_analysis;
USE pizza_sales_analysis;

CREATE TABLE pizza_sales (
    pizza_id        INT,
    order_id        INT,
    pizza_name_id   VARCHAR(50),
    quantity        INT,
    order_date      DATE,
    order_time      TIME,
    unit_price      DECIMAL(10,2),
    total_price     DECIMAL(10,2),
    pizza_size      VARCHAR(50),
    pizza_category  VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name      TEXT
);
```

---

## 🚀 How to Run the Project

**1. Clone the repository**

```bash
git clone https://github.com/mr-deepak-kp/pizza_sales_sql_project.git
```

**2. Create the database and table**

Run `pizza_sales_schema.sql` to set up the database and table structure.

**3. Import the CSV dataset — use Windows CMD ⚠️**

> MySQL 8.0 Command Line Client shortcut does **not** support `--local-infile=1`.  
> Use normal Windows CMD for full flag control.

```sql
-- Login via CMD: mysql -u root -p --local-infile=1
USE pizza_sales_analysis;

LOAD DATA LOCAL INFILE 'C:/path/to/pizza_sales.csv'
INTO TABLE pizza_sales
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
```

**4. Run the analysis queries**

Execute all 30 queries from `pizza_sales_query_solutions.sql`. Each is self-contained.

---

## 📋 Business Problems & Solutions — 30 SQL Queries

---

### 🔢 A. KPI Queries

---

#### Q1. Total Revenue

```sql
SELECT SUM(total_price) AS total_revenue
FROM pizza_sales;
```

**Objective:** Calculate the total revenue generated from all pizza sales.

---

#### Q2. Average Order Value

```sql
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS avg_order_value
FROM pizza_sales;
```

**Objective:** Calculate the average revenue per distinct order.

---

#### Q3. Total Pizzas Sold

```sql
SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;
```

**Objective:** Find the total number of pizzas sold across all orders.

---

#### Q4. Total Distinct Orders

```sql
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;
```

**Objective:** Count the total number of unique orders placed.

---

#### Q5. Average Pizzas Per Order

```sql
SELECT ROUND(SUM(quantity) / COUNT(DISTINCT order_id), 2) AS avg_pizzas_per_order
FROM pizza_sales;
```

**Objective:** Calculate the average number of pizzas per order.

---

### 📅 B. Trend Analysis

---

#### Q6. Daily Trend of Orders (Day of Week)

```sql
SELECT DAYNAME(order_date) AS order_day,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date);
```

**Objective:** Find the total orders placed on each day of the week.

---

#### Q7. Hourly Trend of Orders

```sql
SELECT HOUR(order_time) AS order_hour,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);
```

**Objective:** Identify peak hours based on order volume.

---

#### Q13. Daily Trend — January Only

```sql
SELECT DAYNAME(order_date) AS order_day,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY DAYNAME(order_date);
```

**Objective:** Analyze daily order patterns specifically for January.

---

#### Q14. Daily Trend — Quarter 1

```sql
SELECT DAYNAME(order_date) AS order_day,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
WHERE QUARTER(order_date) = 1
GROUP BY DAYNAME(order_date);
```

**Objective:** Find the daily order trend across the first quarter.

---

#### Q15. Total Orders per Month

```sql
SELECT MONTH(order_date) AS month_number,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);
```

**Objective:** See how order volumes vary month by month.

---

#### Q16. Total Revenue per Quarter

```sql
SELECT QUARTER(order_date) AS quarter_number,
       SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY QUARTER(order_date)
ORDER BY QUARTER(order_date);
```

**Objective:** Compare revenue across all four quarters of the year.

---

#### Q23. Top 3 Days with Most Orders

```sql
SELECT DAYNAME(order_date) AS order_day,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date)
ORDER BY total_orders DESC
LIMIT 3;
```

**Objective:** Identify the 3 busiest days of the week.

---

#### Q24. Top 3 Hours with Most Orders

```sql
SELECT HOUR(order_time) AS order_hour,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY total_orders DESC
LIMIT 3;
```

**Objective:** Find the 3 peak hours for order volume.

---

#### Q25. Month with Maximum Revenue

```sql
SELECT MONTH(order_date) AS month_number,
       SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY MONTH(order_date)
ORDER BY total_revenue DESC
LIMIT 1;
```

**Objective:** Identify the single highest-revenue month of the year.

---

### 📊 C. Category & Size Analysis

---

#### Q8. % of Total Sales by Pizza Category

```sql
SELECT pizza_category,
       SUM(total_price) AS total_revenue,
       ROUND(SUM(total_price) * 100 /
           (SELECT SUM(total_price) FROM pizza_sales), 2) AS sales_percentage
FROM pizza_sales
GROUP BY pizza_category;
```

**Objective:** Find each category's share of total revenue.

---

#### Q9. % of Total Sales by Pizza Size

```sql
SELECT pizza_size,
       SUM(total_price) AS total_revenue,
       ROUND(SUM(total_price) * 100 /
           (SELECT SUM(total_price) FROM pizza_sales), 2) AS sales_percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;
```

**Objective:** Find each pizza size's contribution to total revenue.

---

#### Q10. Pizzas Sold per Category — February

```sql
SELECT pizza_category,
       SUM(quantity) AS total_quantity_sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY total_quantity_sold DESC;
```

**Objective:** Analyze category-level sales volume for the month of February.

---

#### Q17. Pizza Category with Highest Total Sales

```sql
SELECT pizza_category,
       SUM(total_price) AS total_sales
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_sales DESC
LIMIT 1;
```

**Objective:** Identify the single best-performing category by revenue.

---

#### Q18. Pizza Size with Highest Number of Orders

```sql
SELECT pizza_size,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_orders DESC
LIMIT 1;
```

**Objective:** Find which pizza size is ordered most frequently.

---

#### Q21. % Contribution of Each Category to Quantity Sold

```sql
SELECT pizza_category,
       SUM(quantity) AS total_quantity,
       ROUND(SUM(quantity) * 100 /
           (SELECT SUM(quantity) FROM pizza_sales), 2) AS percentage_contribution
FROM pizza_sales
GROUP BY pizza_category;
```

**Objective:** Measure each category's share of total units sold.

---

#### Q22. % Contribution of Each Size to Quantity Sold

```sql
SELECT pizza_size,
       SUM(quantity) AS total_quantity,
       ROUND(SUM(quantity) * 100 /
           (SELECT SUM(quantity) FROM pizza_sales), 2) AS percentage_contribution
FROM pizza_sales
GROUP BY pizza_size;
```

**Objective:** Measure each pizza size's share of total units sold.

---

#### Q26. Pizza Category with Least Pizzas Sold

```sql
SELECT pizza_category,
       SUM(quantity) AS total_quantity_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_quantity_sold ASC
LIMIT 1;
```

**Objective:** Find the lowest-performing category by quantity.

---

#### Q29. Total Orders per Pizza Size

```sql
SELECT pizza_size,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_orders DESC;
```

**Objective:** Compare order frequency across all pizza sizes.

---

#### Q30. Total Revenue by Pizza Category (Descending)

```sql
SELECT pizza_category,
       SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_revenue DESC;
```

**Objective:** Rank all pizza categories by revenue, highest to lowest.

---

### 🍕 D. Pizza-Level Analysis

---

#### Q11. Top 5 Best-Selling Pizzas

```sql
SELECT pizza_name,
       SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold DESC
LIMIT 5;
```

**Objective:** Find the 5 most popular pizzas by total quantity sold.

---

#### Q12. Bottom 5 Least-Selling Pizzas

```sql
SELECT pizza_name,
       SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold ASC
LIMIT 5;
```

**Objective:** Find the 5 least popular pizzas by total quantity sold.

---

#### Q19. Total Quantity Sold per Pizza Name

```sql
SELECT pizza_name,
       SUM(quantity) AS total_quantity_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity_sold DESC;
```

**Objective:** Rank all pizzas by total units sold.

---

#### Q20. Average Quantity per Order (by Order ID)

```sql
SELECT order_id,
       AVG(quantity) AS avg_quantity
FROM pizza_sales
GROUP BY order_id;
```

**Objective:** Find the average number of pizzas in each individual order.

---

#### Q27. Pizza Name with Highest Revenue

```sql
SELECT pizza_name,
       SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 1;
```

**Objective:** Identify the single most profitable pizza.

---

#### Q28. Pizza Name with Lowest Revenue

```sql
SELECT pizza_name,
       SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC
LIMIT 1;
```

**Objective:** Identify the least profitable pizza.

---

## 📊 Key Insights

- 💰 Total revenue and average order value reveal overall business health
- 📅 Certain days and hours consistently drive higher order volumes
- 🍕 A small number of pizzas contribute disproportionately to total revenue
- 📦 Pizza size and category distribution shows clear customer preferences
- 📆 Quarterly revenue trends highlight seasonal sales patterns
- 🔍 Bottom-selling pizzas are candidates for menu optimization

---

## 📌 Future Improvements

- [ ] Build an interactive dashboard using **Power BI / Tableau**
- [ ] Add **customer segmentation** analysis
- [ ] Perform **cohort analysis** on repeat orders
- [ ] Optimize queries using **indexing** on order_date and pizza_category
- [ ] Connect to a live data pipeline for real-time KPI tracking

---

## 📁 Project Files

| File | Description |
|------|-------------|
| `pizza_sales_schema.sql` | Database and table creation + CSV import script |
| `pizza_sales_query_solutions.sql` | All 30 SQL queries with answers |
| `PIZZA_SALES_SQL_QUERIES.docx` | Original query document with output screenshots |

---

## 🤝 Connect With Me

[![GitHub](https://img.shields.io/badge/GitHub-mr--deepak--kp-181717?style=for-the-badge&logo=github)](https://github.com/mr-deepak-kp)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-deepak--kumar--prasad-0A66C2?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/deepak-kumar-prasad/)

---

*Pizza Sales Data Analysis · MySQL · SQL · Business Intelligence*
