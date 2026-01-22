-- SQL Joins PW Skills Assignment
-- Creating a New Database named Company_db
Create Database company_db;
Use company_db;

-- Creating tables and inserting values into it.
Create Table Customers (
CustomerID INT Primary Key,
CustomerName Varchar(100) Not Null,
City Varchar(50)
);

-- Insert Values in Customers Table
Insert Into Customers (CustomerID, CustomerName, City)
Values 
(1, 'John Smith', 'New York'),
(2, 'Mary Johnson', 'Chicago'),
(3, 'Peter Adams', 'Los Angeles'),
(4, 'Nancy Miller', 'Houston'),
(5, 'Robert White', 'Miami');

Create Table Orders (
OrderID INT Primary Key,
CustomerID int,
OrderDate Date,
Amount decimal (10,2),
foreign key (CustomerID) references Customers(CustomerID)
);

-- Insert Values into Orders Table
Insert Into Orders (OrderID, CustomerID, OrderDate, Amount)
Values
(101, 1, '2024-10-01', 250),
(102, 2, '2024-10-05', 300),
(103, 1, '2024-10-07', 150),
(104, 3, '2024-10-10', 450),
(105, 4, '2024-10-12', 400);  -- Changed CustomerID =6 -> 4 to avoid FK error

Create Table Payments (
PaymentID Varchar(100) Primary Key,
CustomerID int,
PaymentDate Date,
Amount decimal (10,2),
foreign key (CustomerID) references Customers(CustomerID)
);

-- -- Insert values into Payments table
INSERT INTO Payments VALUES
('P001', 1, '2024-10-02', 250),
('P002', 2, '2024-10-06', 300),
('P003', 3, '2024-10-11', 450),
('P004', 4, '2024-10-15', 200);

Create Table Employees (
EmployeeID INT Primary Key,
EmployeeName Varchar(100),
ManagerID int,
foreign key (ManagerID) references Employees(EmployeeID)
);

-- Insert Values into Employees table
Insert into Employees (EmployeeID, EmployeeName, ManagerID)
Values
(1, 'Alex Green', Null),
(2, 'Brian Lee', 1),
(3, 'Carol Ray', 1),
(4, 'David Kim', 2),
(5, 'Eva Smith', 2);

-- 1- Retrieve all Customers who have placed at least one order.
SELECT DISTINCT c.CustomerID, c.CustomerName, c.City
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID;

-- 2- Retrieve all Customers and their orders, including customers who have not placed any orders.
Select c.CustomerID,
c.CustomerName,
c.City,
o.OrderID,
o.OrderDate,
o.Amount
From Customers c
Left Join Orders o
On c.CustomerID = o.CustomerID; 

-- 3- Retrieve all orders and their Corresponding Customers, including orders placed by unknown customers.
Select o.OrderID, o.CustomerID, o.OrderDate, o.Amount, c.CustomerName, c.City
From Orders o
Left Join Customers c
On c.CustomerID = o.CustomerID;

-- 4- Display all customers and orders, whether matched or not.
Select c.CustomerID, c.CustomerName, c.City, o.OrderID, o.OrderDate, o.Amount 
From Customers c
Left Join Orders o
On c.CustomerID = o.CustomerID
Union
Select c.CustomerID, c.CustomerName, c.City, o.OrderID, o.OrderDate, o.Amount 
From Customers c
Left Join Orders o
On c.CustomerID = o.CustomerID;

-- 5- Find customers who have not placed any orders.
SELECT 
    c.CustomerID,
    c.CustomerName,
    c.City
FROM Customers c
LEFT JOIN Orders o 
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- 6- Retrieve Customers who made payments but did not place any orders.
SELECT 
    c.CustomerID,
    c.CustomerName,
    c.City
FROM Customers c
JOIN Payments p 
    ON c.CustomerID = p.CustomerID
LEFT JOIN Orders o 
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- 7- Generate a list of all possible Combination between Customers and orders.
select 
c.CustomerID, c.CustomerName, c.City, o.OrderID, o.OrderDate, o.Amount
from Customers c
Cross Join Orders o;

-- 8- Show all Customers along with order and payment amount in one table.
Select
c.CustomerID, c.CustomerName, c.City, o.OrderID, o.OrderDate, o.Amount AS OrderAmount,
p.PaymentID, p.PaymentDate, p.Amount AS PaymentAmount
From Customers c
Left Join Orders o
On c.CustomerID = o.CustomerID
Left Join Payments p
On c.CustomerID = p.CustomerID;

-- 9- Retrieve all customers who have Both placed orders and made payments.
Select c.CustomerID, c.CustomerName, c.City
From Customers c
Inner Join Orders o
On c.CustomerID = o.CustomerID
Inner Join Payments p
On c.CustomerID = p.CustomerID;

