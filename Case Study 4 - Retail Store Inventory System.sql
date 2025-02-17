--  Case Study 4 : Retail Store Inventory System

  --     Scenario:      
-- Design a database to manage a retail store's inventory, suppliers, and sales.

      Tasks:      
1.       Create the Database:      
   - Name the database `RetailDB`.

2.       Create Tables:      
   -       Products Table:      
     - `id`: INT, Primary Key, Auto Increment
     - `name`: VARCHAR(50), Not Null
     - `price`: DECIMAL(10, 2), Not Null, Check Price > 0
     - `stock`: INT, Not Null, Check Stock >= 0
   -       Suppliers Table:      
     - `id`: INT, Primary Key, Auto Increment
     - `name`: VARCHAR(50), Not Null
     - `contact`: VARCHAR(50)
   -       Sales Table:      
     - `id`: INT, Primary Key, Auto Increment
     - `product_id`: INT, Foreign Key References `Products(id)`
     - `date`: DATE, Not Null
     - `quantity`: INT, Not Null, Check Quantity > 0
     - `total_price`: DECIMAL(10, 2), Not Null

3.       Insert Sample Data.      
4.       Queries:      
   - List all products.
   - Show products with stock less than 10.
   - List sales with product names and total prices.
   - Calculate the total sales for each product.


Solution:

Create database `RetailDB`;
use RetailDB;

CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
    stock INT NOT NULL CHECK (stock >= 0)
);


CREATE TABLE Suppliers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    contact VARCHAR(50)
);

CREATE TABLE Sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    date DATE NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Products(id)
);


INSERT INTO Products (name, price, stock)
VALUES 
('Laptop', 1000.00, 50),
('Smartphone', 500.00, 30),
('Tablet', 300.00, 15),
('Headphones', 100.00, 5),
('Charger', 20.00, 100);


INSERT INTO Suppliers (name, contact)
VALUES 
('Tech Corp', '123-456-7890'),
('Gadget Ltd.', '987-654-3210'),
('Mobile Supplies', '555-666-7777');


INSERT INTO Sales (product_id, date, quantity, total_price)
VALUES 
(1, '2024-11-01', 2, 2000.00),
(2, '2024-11-02', 1, 500.00),
(3, '2024-11-03', 3, 900.00),
(4, '2024-11-04', 1, 100.00),
(5, '2024-11-05', 10, 200.00);

SELECT * FROM Products;

SELECT * FROM Products WHERE stock < 10;

SELECT 
    p.name AS ProductName, 
    s.total_price AS TotalPrice, 
    s.date AS SaleDate
FROM Sales s
JOIN Products p ON s.product_id = p.id;

SELECT 
    p.name AS ProductName,
    SUM(s.quantity) AS TotalQuantitySold,
    SUM(s.total_price) AS TotalSales
FROM Sales s
JOIN Products p ON s.product_id = p.id
GROUP BY p.name;



     

    