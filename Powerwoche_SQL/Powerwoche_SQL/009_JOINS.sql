-- JOINS
-- Informationen aus mehreren Tabellen abfragen

-- INNER JOIN

-- OUTER JOINS
	-- LEFT JOIN
	-- RIGHT JOIN



SELECT *
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID


-- wenn ein Spaltenname nicht eindeutig ist (wenn er in mehreren am Join beteiligten Tabellen vorkommt), müssen wir dazusagen, aus welcher Tabelle er kommt
SELECT	  OrderID
		, Customers.CustomerID
		, CompanyName
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID



-- bei den anderen Spalten mit eindeutigen Namen müssen wir nicht angeben, aus welcher Tabelle sie kommen, wir KÖNNEN aber
SELECT	  Orders.OrderID -- hier KÖNNEN wir dazuschreiben welche Tabelle
		, Customers.CustomerID -- hier müssen wir dazuschreiben
		, Customers.CompanyName -- hier KÖNNEN wir dazuschreiben
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID


-- bisschen kürzer schreiben:
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
FROM Customers AS c INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID


-- noch ein bisschen kürzer:
SELECT	  o.OrderID
		, c.CustomerID 
		, c.CompanyName
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID


-- Gib alle Kunden und ihre Frachtkosten aus
-- Kunden (CompanyName, Freight)
SELECT	  c.CustomerID
		, c.CompanyName
		, o.OrderID
		, o.Freight
FROM Customers AS c INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID


SELECT	  Customers.CustomerID
		, CompanyName
		, Freight
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID


-- Gib alle Kunden und ihre Frachtkosten aus
-- Kunden (CompanyName, Freight)
-- nur die Kunden aus Deutschland
-- vom größten zum kleinsten Frachtkostenwert geordnet
SELECT	  c.CustomerID
		, c.CompanyName
		, o.OrderID
		, o.Freight
FROM Customers AS c INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'Germany'
ORDER BY o.Freight DESC

-- Gib die Namen der Anbieter (Supplier), die Sauce verkaufen, aus. (CompanyName, ProductName, Ansprechperson, Telefonnummer). 
SELECT   p.ProductName
        ,s.CompanyName
        ,s.ContactName
        ,s.Phone
FROM Products AS p INNER JOIN Suppliers AS s ON p.SupplierID=s.SupplierID
WHERE ProductName LIKE '%sauce%'

-- oder ausgeschrieben:
SELECT   Products.ProductName
        ,Suppliers.CompanyName
        ,Suppliers.ContactName
        ,Suppliers.Phone
FROM Products INNER JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID
WHERE ProductName LIKE '%sauce%'


-- Angenommen, es gab Beschwerden bei den Bestellungen 10251, 10280, 10990 und 11000.
-- Welcher Angestellte hat diese Bestellungen bearbeitet?
-- Vor- und Nachname in einem Feld als FullName ausgeben.

-- langsam:
-- wie bekomme ich die Bestellungen mit diesen Nummern

SELECT OrderID
FROM Orders
WHERE OrderID IN(10251, 10280, 10990, 11000)

-- wie bekommen wir die EmployeeID von denen, die diese Bestellungen bearbeitet haben?
SELECT	  OrderID
		, EmployeeID
FROM Orders
WHERE OrderID IN(10251, 10280, 10990, 11000)

-- wer sind denn die Angestellten?
SELECT FirstName, LastName
FROM Employees
WHERE EmployeeID IN (2, 3)

-- wie füge ich Informationen aus mehreren Spalten zusammen:
SELECT CONCAT(FirstName, ' ', LastName)
FROM Employees


-- alles zusammenfügen:

SELECT	  FirstName
		, LastName
		, o.OrderID
FROM Orders AS o INNER JOIN Employees AS e ON o.EmployeeID = e.EmployeeID
WHERE OrderID IN(10251, 10280, 10990, 11000)


-- mit Name in einer Spalte
SELECT	  CONCAT(e.FirstName, ' ', e.LastName) AS FullName
		, o.OrderID
FROM Orders AS o INNER JOIN Employees AS e ON o.EmployeeID = e.EmployeeID
WHERE OrderID IN(10251, 10280, 10990, 11000)



-- JOINS von mehreren Tabellen
/*
SELECT    Spalte1
		, Spalte2
		, Spalte3
--		, ...
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
*/


-- Welche Kunden haben Chai Tee gekauft und wieviel?
-- (OrderID, CustomerID, CompanyName, ProductName, Quantity)

SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, p.ProductName
		, od.Quantity
FROM Orders AS o INNER JOIN Customers AS c ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
				 INNER JOIN Products AS p ON od.ProductID = p.ProductID
WHERE p.ProductName LIKE '%chai%'



-- Suche alle Bestellungen, bei denen Bier verkauft wurde. Welcher Kunde? Wieviel? Welches Bier?
-- Tipp: Der Produktname kann „Bier“ oder „Lager“ enthalten oder mit „Ale“ enden.
-- Nach Menge und Kundenname geordnet:
--Menge absteigend (größte zuerst), 	Kundenname aufsteigend (A-Z)

SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, od.Quantity
		, p.ProductName
FROM Orders AS o INNER JOIN Customers AS c ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] AS od ON od.OrderID = o.OrderID
				 INNER JOIN Products AS p ON od.ProductID = p.ProductID
WHERE p.ProductName LIKE '%bier%' OR p.ProductName LIKE '%lager%' OR p.ProductName LIKE '%ale'
ORDER BY od.Quantity DESC, c.CompanyName ASC



-- Wer ist der Chef von wem?
--Ausgabe:
--Name Angestellter, ID Angestellter, Name Chef, ID vom Chef

SELECT boss.EmployeeID AS IDChef
	, CONCAT(boss.FirstName, ' ', boss.LastName) AS Chef
	, emp.EmployeeID AS IDMA
	, CONCAT(emp.FirstName, ' ', emp.LastName) AS MA
FROM Employees AS boss INNER JOIN Employees AS emp ON boss.EmployeeID = emp.ReportsTo
ORDER BY Chef



-- INNER JOIN 

SELECT *
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID



-- OUTER JOIN
	-- LEFT JOIN
	-- RIGHT JOIN

-- RIGHT JOIN
SELECT *
FROM Customers c RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID


-- LEFT JOIN
SELECT *
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID


-- wer hat noch nichts bestellt?
SELECT *
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE OrderID IS NULL

SELECT *
FROM  Orders o RIGHT JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE OrderID IS NULL