-- TOP
-- ORDER BY zwingend notwendig!!
-- ORDER BY stellt sicher, dass die Daten in einer für uns nachvollziehbaren Reihenfolge ausgegeben werden; was ist die erste Zeile? Abhängig von ORDER BY


-- nur 1 Zeile ausgeben mit TOP 1
SELECT TOP 1 *
FROM Customers
-- aber WAS ist die erste Zeile? --> ORDER BY!!


SELECT *
FROM Customers
ORDER BY Country


-- bestimmte Spalten auswählen auch mit TOP möglich:
SELECT TOP 1  CustomerID
			, CompanyName
			, ContactName
--			, ...
FROM Customers
ORDER BY CustomerID


-- theoretisch können wir auch nach Spalten ordnen, die im SELECT gar nicht vorkommen
-- Sinn? von Fall zu Fall entscheiden
SELECT TOP 1  CustomerID
			, CompanyName
			, ContactName
--			, ...
FROM Customers
ORDER BY Country
-- CACTU


-- mit WHERE
SELECT TOP 1 CustomerID
			, CompanyName
			, ContactName
			, Region
			, Country
--			, ...
FROM Customers
WHERE Region IS NOT NULL
ORDER BY Country
-- COMMI


-- beliebig viele Zeilen ausgeben
SELECT TOP 10 CustomerID
			, CompanyName
			, ContactName
			, Region
			, Country
--			, ...
FROM Customers
WHERE Region IS NOT NULL
ORDER BY Country


-- geht auch mit Prozent... PERCENT ausschreiben, % funktioniert nicht
SELECT TOP 3 PERCENT *
FROM Customers
ORDER BY CustomerID

SELECT TOP 3 PERCENT CustomerID
					, CompanyName
					, ContactName
					, Region
					, Country
		--			, ...
FROM Customers
WHERE Region IS NOT NULL
ORDER BY Country


-- wie bekomme ich die letzten 5 Einträge?
SELECT TOP 5 *
FROM Customers
ORDER BY CustomerID DESC



SELECT TOP 17 Freight
			, OrderID
	--		, ...
	FROM Orders
ORDER BY Freight


-- wenn jemand auf Platz 18 den gleichen Wert hat, wie der auf Platz 17, soll er auch ausgegeben werden: WITH TIES
SELECT TOP 17 WITH TIES   Freight
						, OrderID
				--		, ...
	FROM Orders
ORDER BY Freight


-- Gib das teuerste Produkt aus.
SELECT TOP 1 ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC


-- Suche die Top 10% der Produkte mit den größten Verkaufsmengen (ProductName, Quantity).
-- Einschließlich Produkte mit der gleichen Einkaufsmenge wie das letzte in der ursprünglichen Ausgabe.
SELECT TOP 10 PERCENT	  p.ProductID
						, p.ProductName
						, od.Quantity
FROM Products p INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
ORDER BY od.Quantity DESC



-- Gib die drei Mitarbeiter, die als erste eingestellt wurden, aus (die schon am längsten beim Unternehmen sind).
-- Wähle nicht alle, sondern nur einige in diesem Zusammenhang sinnvolle Spalten aus.
SELECT TOP 3  FirstName
			, LastName
			, HireDate
FROM Employees
ORDER BY HireDate
