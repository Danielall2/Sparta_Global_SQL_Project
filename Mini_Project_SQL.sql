USE Northwind -- Need to use at least once so that I am in the correct area


-- Exercise 1 --

-- 1.1 -- 
/* 1.1	Write a query that lists all Customers in either Paris or London. Include Customer ID, Company Name and all address fields. */
-- Done and Checked Output --
SELECT  c.CustomerID
        , c.CompanyName
        , c.Address
        , c.City
        , c.PostalCode
FROM    Customers c
WHERE   c.City IN ('Paris', 'London')

-- 1.2 -- 
/* 1.2	List all products stored in bottles.*/
-- Done and Checked Output --
SELECT  p.ProductID
        , p.ProductName
        , p.QuantityPerUnit
FROM    Products p
WHERE   p.QuantityPerUnit LIKE '%bottles%'

-- 1.3 --
/* 1.3	Repeat question above, but add in the Supplier Name and Country.*/
-- Done and Checked Output --
SELECT      p.ProductID
            , p.ProductName
            , p.QuantityPerUnit
            , s.SupplierID
            , s.CompanyName AS "Supplier Name"
            , s.Country
FROM        Products p
INNER JOIN  Suppliers s
ON          p.SupplierID = s.SupplierID
WHERE       p.QuantityPerUnit LIKE '%bottles%' -- Looking for any reference to bottles in the QuantityPerUnit


-- 1.4 --
/* 1.4	Write an SQL Statement that shows how many products there are in each category. Include Category Name in result set and list the highest number first.*/
-- Done and Checked Output --
SELECT      p.CategoryID
            , c.CategoryName
            , COUNT(p.ProductID) AS "Number of Products"
FROM        Products p
INNER JOIN  Categories c
ON          c.CategoryID = p.CategoryID
GROUP BY    p.CategoryID, c.CategoryName -- Do not use numbers! Make sure to specify the column and from which table!
ORDER BY    "Number of Products" DESC


-- 1.5 --
/* 1.5	List all UK employees using concatenation to join their title of courtesy, first name and last name together. Also include their city of residence.*/
-- Done and Checked Output --
SELECT  CONCAT(e.TitleOfCourtesy, ' ', e.FirstName, ' ', e.LastName) AS "Full Name"
        , e.City
FROM    Employees e
WHERE   e.Country IN ('UK')


-- 1.6 -- 
/* 1.6	List Sales Totals for all Sales Regions (via the Territories table using 4 joins) with a Sales Total greater than 1,000,000. Use rounding or FORMAT to present the numbers. */
-- LOOK AT ERD DIAGRAM TO DO WITH NORTHWIND --
-- Region -> Territories -> employee_territories -> orders -> order_details
-- Don't use Sales Total by Amount it is not supposed to be there and is wrong!

-- Done and Checked Output --

SELECT      r.RegionID
            , r.RegionDescription
            , ROUND(SUM(od.UnitPrice * od.Quantity * (1.0-od.Discount)), 2) AS "Sales Total"
FROM        [Order Details] od
INNER JOIN  Orders o
ON          od.OrderID = o.OrderID
INNER JOIN  EmployeeTerritories et
ON          o.EmployeeID = et.EmployeeID
INNER JOIN  Territories t
ON          et.TerritoryID = t.TerritoryID
INNER JOIN  Region r
ON          t.RegionID = r.RegionID
GROUP BY    r.RegionID, r.RegionDescription
HAVING      SUM(od.UnitPrice * od.Quantity * (1.0-od.Discount)) > 1000000
ORDER BY    1   



-- 1.7 --
/* 1.7	Count how many Orders have a Freight amount greater than 100.00 and either USA or UK as Ship Country.*/
-- Done and Checked Output --
-- Currently splitting by ShipCountry but can remove this in the SELECT and GROUP BY and would then give Total.
SELECT      COUNT(*) AS "Number of Freights over 100.00 going to UK or USA"
FROM        Orders o
WHERE       o.Freight > 100.00
AND         o.ShipCountry IN ('USA', 'UK')


-- 1.8 --
/* 1.8	Write an SQL Statement to identify the Order Number of the Order with the highest amount(value) of discount applied to that order.*/
-- Done and Checked Output --
-- Careful with using TOP 1 as multiple accounts had the highest amount of discount --
SELECT          o.OrderID
                , o.UnitPrice * o.Quantity * o.Discount AS "Discount Total"
FROM            [Order Details] o       
WHERE           o.UnitPrice * o.Quantity * o.Discount = 
                (SELECT
                        MAX(od.UnitPrice * od.Quantity * od.Discount)
                FROM    [Order Details] od)
ORDER BY        "Discount Total" DESC


-- Exercise 2 --

-- 2.1 --
/* Write the correct SQL statement to create the following table:
Spartans Table – include details about all the Spartans on this course. Separate Title, First Name and Last Name into separate columns,
and include University attended, course taken and mark achieved. Add any other columns you feel would be appropriate. 
IMPORTANT NOTE: For data protection reasons do NOT include date of birth in this exercise. */

-- Done and Checked Output

DROP TABLE exercise_2_daniel -- Whenever I start don't want this to be already created.

CREATE TABLE exercise_2_daniel -- Any more columns add here along with their corresponding data type
(
    id int IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(10),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    university_attended VARCHAR(30),
    course_taken VARCHAR(20),
    mark_achieved VARCHAR(20),
    main_interest VARCHAR(20),
    favourite_integer int
)

-- 2.2 --
/* Write SQL statements to add the details of the Spartans in your course to the table you have created. */

INSERT INTO exercise_2_daniel
VALUES
('Mr', 'Daniel', 'Alldritt', 'University of Unknown', 'Amazing Course 1', 'First', 'Coding', 11),
('Mr', 'Ahmed', 'Rahman', 'University of Unknown', 'Amazing Course 2', 'First', 'Coding', 12),
('Mr', 'Alex', 'Ng', 'University of Unknown', 'Amazing Course 3', 'First', 'Coding', 13),
('Mr', 'Andrei', 'Pavel', 'University of Unknown', 'Amazing Course 4', 'First', 'Coding', 14),
('Mr', 'Asakar', 'Hussain', 'University of Unknown', 'Amazing Course 5', 'First', 'Coding', 15),
('Mr', 'Ben', 'Middlehurst', 'University of Unknown', 'Amazing Course 6', 'First', 'Coding', 16),
('Mr', 'Benjamin', 'Balls', 'University of Unknown', 'Amazing Course 7', 'First', 'Coding', 17),
('Mr', 'Gregory', 'Spratt', 'University of Unknown', 'Amazing Course 8', 'First', 'Coding', 18),
('Mr', 'Ismail', 'Kadir', 'University of Unknown', 'Amazing Course 9', 'First', 'Coding', 19),
('Mr', 'James', 'Fletcher', 'University of Unknown', 'Amazing Course 10', 'First', 'Coding', 20),
('Mr', 'Jamie', 'Hammond', 'University of Unknown', 'Amazing Course 11', 'First', 'Coding', 21),
('Mr', 'Josh', 'Weeden', 'University of Unknown', 'Amazing Course 12', 'First', 'Coding', 22),
('Mr', 'Nathan', 'Johnston', 'University of Unknown', 'Amazing Course 13', 'First', 'Coding', 23),
('Mr', 'Rashawn', 'Henry', 'University of Unknown', 'Amazing Course 14', 'First', 'Coding', 24),
('Mr', 'Sidhant', 'Khosla', 'University of Unknown', 'Amazing Course 15', 'First', 'Coding', 25),
('Mr', 'Timin', 'Rickaby', 'University of Unknown', 'Amazing Course 16', 'First', 'Coding', 26),
('Mr', 'Yusuf', 'Uddin', 'University of Unknown', 'Amazing Course 17', 'First', 'Coding', 27)

-- Checking that values have been inserted --
SELECT * FROM exercise_2_daniel


-- Exercise 3 --
/* Write SQL statements to extract the data required for the following charts (create these in Excel): */

-- 3.1 --
/* List all Employees from the Employees table and who they report to. No Excel required.*/
-- Done and Checked Output --
SELECT          e.EmployeeID
                , CONCAT(e.FirstName, ' ', e.LastName) AS "Employee Name"
                , e.ReportsTo
                , CONCAT(e2.FirstName, ' ', e2.LastName) AS "Line Manager"
                -- I want to put the Reporting To Name as well but not sure how to link the Primary Key to the ReportsTo key
FROM            Employees e
LEFT JOIN       Employees e2
ON              e.ReportsTo = e2.EmployeeID


-- 3.2 --
-- Done and Checked Output --
SELECT      s.SupplierID
            , s.CompanyName
            , ROUND(SUM(od.UnitPrice * od.Quantity * (1.0-od.Discount)), 2) AS "Total Sales"
FROM        Suppliers s
INNER JOIN  Products p
ON          s.SupplierID = p.SupplierID
INNER JOIN  [Order Details] od
ON          p.ProductID = od.ProductID
GROUP BY    s.SupplierID, s.CompanyName
HAVING      SUM(od.UnitPrice * od.Quantity * (1.0-od.Discount)) > 10000
ORDER BY    3 DESC


-- 3.3 --
-- For this need to get the MAX year and then SUM all orders for that year for each supplier --
-- Also need to put TOP 10 after SELECT so that I only get the TOP 10 --
-- Because I am using TOP 10 need to make sure I do it in DESC order --

-- Done and Checked Output --
SELECT TOP 10   c.CustomerID
                , c.CompanyName
                , ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)), 2) AS "Total Value with Discount Added"
FROM            Customers c
INNER JOIN      Orders o
ON              c.CustomerID = o.CustomerID
INNER JOIN      [Order Details] od
ON              o.OrderID = od.OrderID
WHERE           YEAR(o.OrderDate) = (SELECT TOP 1 YEAR(o2.OrderDate) AS "Latest Year"
                FROM Orders o2
                ORDER BY o2.OrderDate DESC)
GROUP BY        c.CustomerID, c.CompanyName
ORDER BY        "Total Value with Discount Added" DESC


-- 3.4 --
-- Assume Ship Time is the difference between Order Date and Shipped Date

-- Done and Checked Output --
SELECT          YEAR(o.OrderDate) AS "Year"
                , MONTH(o.OrderDate) AS "Month"
                , FORMAT(o.OrderDate, 'MMM-yy') AS "Year-Month"
                , AVG(CAST(DATEDIFF(d, o.OrderDate, o.ShippedDate) AS Decimal(4,2))) AS "Average Number of Ship Days"
FROM            Orders o
GROUP BY        YEAR(o.OrderDate), MONTH(o.OrderDate), FORMAT(o.OrderDate, 'MMM-yy')
ORDER BY        1, 2





-- Supplier option for 3.3
-- This isn't right as it is looking at suppliers not customers --
SELECT TOP 10   s.SupplierID
                , s.CompanyName
FROM            Suppliers s
INNER JOIN      Products p
ON              s.SupplierID = p.SupplierID
INNER JOIN      [Order Details] od
ON              p.ProductID = od.ProductID
INNER JOIN      Orders o
ON              od.OrderID = o.OrderID
WHERE           YEAR(o.OrderDate) = (SELECT TOP 1 YEAR(o2.OrderDate) AS "Latest Year"
                FROM Orders o2
                ORDER BY o2.OrderDate DESC)