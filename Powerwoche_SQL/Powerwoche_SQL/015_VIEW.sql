-- VIEWS (Sichten)



CREATE VIEW v_Customers
AS
SELECT CustomerID, CompanyName
FROM Customers


SELECT CompanyName
FROM v_Customers
WHERE CompanyName LIKE 'a%'

CREATE VIEW v_Customers_Region_DE
AS
SELECT CustomerID, CompanyName, Country
FROM Customers
WHERE Country IN('Germany', 'Austria', 'Switzerland')


SELECT *
FROM v_Customers_Region_DE


CREATE VIEW v_Customers_Contacts
AS
SELECT CustomerID
		, CompanyName
		, ContactName
		, Phone
FROM Customers

DROP VIEW v_Customers_Contacts

SELECT CompanyName, Phone
FROM v_Customers_Contacts



CREATE VIEW v_Customers_Freight
AS
SELECT	  c.CustomerID
		, c.CompanyName
		, c.City
		, c.ContactName
		, c.Phone
		, o.OrderID
		, o.Freight
--		, ...
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID


-- v_Rechnungen
-- CustomerID, CompanyName, Address, City, OrderID, OrderDate, ShippedDate,..., ProductName, ...
CREATE VIEW v_Rechnungen
AS
SELECT	  c.CustomerID
		, c.CompanyName
		, c.Address
		, c.City
--		, ...
		, o.OrderID
		, o.OrderDate
		, o.ShippedDate
--		, ...
		, od.UnitPrice
		, od.Quantity
		, p.ProductID
		, p.ProductName
--		, ...
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID


SELECT    CustomerID
		, CompanyName
--		, ...
		, OrderID
--		, ...
		, ProductID
		, ProductName
--		, ...
FROM v_Rechnungen

SELECT * FROM Customers