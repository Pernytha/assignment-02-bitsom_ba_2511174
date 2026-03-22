-- ==========================================
-- CREATE DATABASE
-- ==========================================
CREATE DATABASE IF NOT EXISTS retail_dw;
USE retail_dw;

-- DROP TABLES (for re-run safety)
-- ==========================================
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;

-- ==========================================
-- DIMENSION TABLES
-- ==========================================

-- Date Dimension
CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE,
    year INT,
    month INT,
    month_name VARCHAR(20)
);

-- Store Dimension
CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    store_city VARCHAR(50)
);

-- Product Dimension
CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

-- FACT TABLE
-- ==========================================

CREATE TABLE fact_sales (
    sales_id INT PRIMARY KEY,
    date_id INT,
    store_id INT,
    product_id INT,
    units_sold INT,
    unit_price DECIMAL(10,2),
    total_sales DECIMAL(12,2),

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- ==========================================
-- CLEANED DIMENSION DATA
-- ==========================================
-- Dates (standardized to YYYY-MM-DD)

INSERT INTO dim_date (date_id, full_date, year, month, month_name) VALUES
(1,'2023-08-29',2023,8,'August'),
(2,'2023-12-12',2023,12,'December'),
(3,'2023-02-05',2023,2,'February'),
(4,'2023-02-20',2023,2,'February'),
(5,'2023-01-15',2023,1,'January'),
(6,'2023-08-09',2023,8,'August'),
(7,'2023-03-31',2023,3,'March'),
(8,'2023-10-26',2023,10,'October'),
(9,'2023-12-08',2023,12,'December'),
(10,'2023-08-15',2023,8,'August');

INSERT INTO dim_store VALUES
(1,'Chennai Anna','Chennai'),
(2,'Delhi South','Delhi'),
(3,'Bangalore MG','Bangalore'),
(4,'Pune FC Road','Pune'),
(5,'Mumbai Central','Mumbai');

INSERT INTO dim_product VALUES
(1,'Speaker','Electronics'),
(2,'Tablet','Electronics'),
(3,'Phone','Electronics'),
(4,'Smartwatch','Electronics'),
(5,'Atta 10kg','Grocery'),
(6,'Jeans','Clothing'),
(7,'Biscuits','Grocery');


INSERT INTO fact_sales
(sales_id, date_id, store_id, product_id, units_sold, unit_price, total_sales) VALUES

(1,1,1,1,3,49262.78,147788.34),
(2,2,1,2,11,23226.12,255487.32),
(3,3,1,3,20,48703.39,974067.80),
(4,4,2,2,14,23226.12,325165.68),
(5,5,1,4,10,58851.01,588510.10),
(6,6,3,5,12,52464,629568.0),
(7,7,4,4,6,58851.01,353106.06),
(8,8,4,6,16,2317.47,37079.52),
(9,9,3,7,9,27469.99,247229.91),
(10,10,3,4,3,58851.01,176553.03); 

SHOW TABLES;
DESCRIBE dim_date;
DESCRIBE dim_store;
DESCRIBE fact_sales;
