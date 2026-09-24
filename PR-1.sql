-- Table 1: Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Address VARCHAR(255)
);

-- Table 2: Orders Table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) 
);

-- Table 3: Products Table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    Stock INT
);

-- Table 4: OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- 1. CUSTOMERS TABLE QUERIES
INSERT INTO Customers (Name, Email, Address) VALUES
('Alice', 'alice@example.com', '123 MG Road, Mumbai'),
('Bob Smith', 'bob@example.com', '456 Park Avenue, Delhi'),
('Charlie Brown', 'charlie@example.com', '789 Ring Road, Bangalore'),
('Alice', 'alice.wonder@example.com', '12 Lake View, Pune'),
('David Warner', 'david@example.com', '34 Civil Lines, Jaipur');

SELECT * FROM Customers;

UPDATE Customers 
SET Address = '999 New Residency, Mumbai' 
WHERE CustomerID = 1;

DELETE FROM Customers 
WHERE CustomerID = 5;

SELECT * FROM Customers 
WHERE Name = 'Alice';


-- 2. ORDERS TABLE QUERIES
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, CURDATE(), 2500.00),
(2, DATE_SUB(CURDATE(), INTERVAL 10 DAY), 1200.00),
(3, DATE_SUB(CURDATE(), INTERVAL 25 DAY), 4500.00),
(1, DATE_SUB(CURDATE(), INTERVAL 45 DAY), 800.00),
(4, CURDATE(), 1500.00);

SELECT * FROM Orders 
WHERE CustomerID = 1;

UPDATE Orders 
SET TotalAmount = 2800.00 
WHERE OrderID = 1;

DELETE FROM Orders 
WHERE OrderID = 5;

SELECT * FROM Orders 
WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

SELECT 
    MAX(TotalAmount) AS HighestOrderAmount,
    MIN(TotalAmount) AS LowestOrderAmount,
    AVG(TotalAmount) AS AverageOrderAmount
FROM Orders;


-- 3. PRODUCTS TABLE QUERIES
INSERT INTO Products (ProductName, Price, Stock) VALUES
('Wireless Mouse', 650.00, 50),
('Mechanical Keyboard', 1800.00, 20),
('USB-C Hub', 450.00, 0), -- Out of stock
('Gaming Headset', 2200.00, 15),
('Bluetooth Speaker', 1200.00, 30);

SELECT * FROM Products 
ORDER BY Price DESC;

DELETE FROM Products 
WHERE Stock = 0;

SELECT * FROM Products 
WHERE Price BETWEEN 500 AND 2000;

SELECT 
    MAX(Price) AS MostExpensivePrice,
    MIN(Price) AS CheapestPrice
FROM Products;


-- 4. ORDERDETAILS TABLE QUERIES
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal) VALUES
(1, 1, 2, 1300.00),
(1, 2, 1, 1950.00),
(2, 5, 1, 1200.00),
(3, 4, 2, 4400.00),
(4, 1, 1, 650.00);

SELECT * FROM OrderDetails 
WHERE OrderID = 1;

SELECT SUM(SubTotal) AS TotalRevenue 
FROM OrderDetails;

SELECT 
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalQuantityOrdered DESC
LIMIT 3;

SELECT COUNT(*) AS TimesSold 
FROM OrderDetails 
WHERE ProductID = 1;