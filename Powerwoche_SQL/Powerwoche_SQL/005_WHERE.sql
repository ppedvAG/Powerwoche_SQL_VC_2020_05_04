-- WHERE clause, WHERE-Klausel, WHERE Bedingung...
-- wenn man nur bestimmte Ergebnisse ausgeben möchte


/*
	SELECT    Spalte1
			, Spalte2
			,...
	FROM Tabelle
	WHERE Bedingung ...

	WHERE Operatoren:
						=, <, >, <=, >=
						!=, <>  -- darf NICHT diesem Wert entsprechen
						LIKE, IN, BETWEEN

						IS NOT
						NOT IN
						NOT LIKE
						NOT BETWEEN
						
	AND, OR



*/


-- bisher:
SELECT *
FROM Customers

-- einschränken, wieviele Spalten wir haben wollen:
SELECT	  CustomerID
		, CompanyName
--		, ...
FROM Customers


-- einschränken, wieviele Zeilen wir haben wollen, indem wir z.B. nur die Kunden aus Deutschland ausgeben, nicht alle weltweit
SELECT	  CustomerID
		, CompanyName
		, Country
--		, ...
FROM Customers
WHERE Country = 'Germany'


-- alle, die aus Berlin in Deutschland sind:
SELECT	  CustomerID
		, CompanyName
		, Country
		, City
--		, ...
FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'

-- alle aus Deutschland und Österreich:
SELECT	  CustomerID
		, CompanyName
		, Country
--		, ...
FROM Customers
WHERE Country = 'Germany' OR Country = 'Austria'


SELECT	  OrderID
		, CustomerID
		, Freight
--		, ...
FROM Orders
WHERE Freight < 100

-- alle, die NICHT einem bestimmten Wert entsprechen
SELECT *
FROM Orders
WHERE Freight != 148.33


-- Ausgabe nach Frachtkosten ordnen
SELECT	  OrderID
		, CustomerID
		, Freight
--		, ...
FROM Orders
WHERE Freight < 100
ORDER BY Freight ASC -- ascending (vom kleinsten zum größten Wert geordnet)
-- per Default wird aufsteigend geordnet (vom kleinsten zum größten Wert)
-- weil ASC der Default ist, müssen wir es nicht unbedingt dazuschreiben

SELECT	  OrderID
		, CustomerID
		, Freight
--		, ...
FROM Orders
WHERE Freight < 100
ORDER BY Freight DESC -- descending (vom größten zum kleinsten Wert)


SELECT	  OrderID
		, CustomerID
		, Freight
--		, ...
FROM Orders
WHERE Freight < 100
ORDER BY Freight, CustomerID
-- zuerst nach Frachtkosten geordnet, dann (wenn es welche gibt, die den gleichen Frachtkostenwert haben) nach CustomerID geordnet



-- **************************** IN ***********************************

SELECT *
FROM Customers
WHERE Country = 'Spain' OR Country = 'Portugal' OR Country = 'Argentina' OR Country = 'Brazil'

-- oder kürzer mit IN:
SELECT    CustomerID
		, Country
FROM Customers
WHERE Country IN('Spain', 'Portugal', 'Argentina', 'Brazil')
ORDER BY Country


-- ***************************** BETWEEN **************************************

SELECT    OrderID
		, Freight
FROM Orders
WHERE Freight >= 100 AND Freight <= 200
ORDER BY Freight

-- oder kürzer mit BETWEEN:
SELECT    OrderID
		, Freight
FROM Orders
WHERE Freight BETWEEN 100 AND 200
-- between macht <= und >=, nicht < und >


-- alle Bestellungen, die von Employee 3, 4 oder 7 bearbeitet worden sind
SELECT	  OrderID
		, EmployeeID
--		, ...
FROM Orders
WHERE EmployeeID = 3 OR EmployeeID = 4 OR EmployeeID = 7

-- oder so:
SELECT	  OrderID
		, EmployeeID
--		, ...
FROM Orders
WHERE EmployeeID IN(3, 4, 7)


-- Gib alle Produkte aus, deren ProduktID zwischen 10 und 15 (inklusive) liegt.
SELECT *
FROM Products
WHERE ProductID BETWEEN 10 AND 15


-- Gib alle Produkte aus, die vom Anbieter (SupplierID) 2, 7 oder 15 geliefert werden.
SELECT *
FROM Products
WHERE SupplierID IN(2, 7, 15)




