-- subquery, Subselect, Unterabfragen

-- Unterabfrage wie Spalte, wie Tabelle oder im WHERE verwenden möglich


-- Subquery wie Spalte verwenden:
SELECT	  'Text'
		, Freight
		, (SELECT TOP 1 Freight FROM Orders ORDER BY Freight)
FROM Orders
-- wenn Unterabfrage wie eine Spalte verwendet wird, darf da nur 1 Wert drinstehen



-- Subquery wie Tabelle (als Datenquelle) verwenden
SELECT *
FROM -- aus welcher Tabelle kommt die Information? Die können wir hier mittels Subquery generieren
	(SELECT OrderID, Freight FROM Orders WHERE EmployeeID = 3) AS t1
-- wenn wir Subquery als Datenquelle verwenden, dann müssen wir ein ALIAS vergeben (AS t1) - das "AS" darf weggelassen werden


-- Subquery im WHERE
-- alle Bestellungen, wo die Frachtkosten größer sind, als die durchschnittlichen Frachtkosten
SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) -- 78,2442
-- hier muss auch ein ganz konkreter Wert herauskommen, denn wir wollen ja überprüfen, ob die Frachtkosten größer sind als dieser Wert
-- hier können nicht mehrere Spalten herauskommen


-- auch mit AND kombinierbar; wir können trotz Subselect mehrere Bedingungen abfragen
SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) AND Freight < 200


-- auch mehrere Subqueries wären möglich, aber Sinn? ...und Performance :(
SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) AND Freight < (SELECT SUM(Freight) FROM Orders)


-- alle Kunden, die in einem Land wohnen, in das auch Bestellungen verschifft werden
SELECT    CustomerID
		, CompanyName
		, Country
FROM Customers
WHERE Country IN(SELECT ShipCountry FROM Orders)


-- Gib die SupplierID, den CompanyName, die Kontaktinformation und das Land aller Supplier aus, die aus dem gleichen Land sind wie der Supplier Nr. 2.
SELECT    SupplierID
		, CompanyName
		, ContactName
		, Phone
		, Country
FROM Suppliers
WHERE Country = (SELECT Country FROM Suppliers WHERE SupplierID = 2)
-- hier können wir wieder = verwenden, weil im Subselect genau 1 Wert herauskommt (der Supplier mit der ID 2 lebt in genau einem Land)



-- -- Gib die Namen und das Einstellungsdatum der Mitarbeiter aus, die im selben Jahr eingestellt wurden wie Mr. Robert King.
--Titel, Vorname und Nachname sollen überprüft werden.
--Uhrzeit soll nicht mit ausgegeben werden

-- wann ist der Robert King eingestellt worden?
SELECT YEAR(HireDate) 
FROM Employees WHERE FirstName = 'Robert' AND LastName = 'King' AND TitleOfCourtesy = 'Mr.'

-- wie bekomme ich alle Angestellten, die in einem bestimmten Jahr eingestellt wurden?
SELECT *
FROM Employees
WHERE YEAR(HireDate) = 1994

-- >
SELECT	  CONCAT(FirstName, ' ', LastName) AS FullName
		, FORMAT(HireDate, 'dd.MM.yyyy') AS Datum
FROM Employees
WHERE YEAR(HireDate) = (SELECT YEAR(HireDate) FROM Employees WHERE FirstName = 'Robert' AND LastName = 'King' AND TitleOfCourtesy = 'Mr.')


SELECT	  CONCAT(FirstName, ' ', LastName) AS FullName
		, FORMAT(HireDate, 'd', 'de-de') AS Datum
FROM Employees
WHERE DATEPART(yyyy, HireDate) = (SELECT YEAR(HireDate) FROM Employees WHERE FirstName = 'Robert' AND LastName = 'King' AND TitleOfCourtesy = 'Mr.')

-- wenn Robert King selbst nicht dabei sein soll:
SELECT	  CONCAT(FirstName, ' ', LastName) AS FullName
		, FORMAT(HireDate, 'd', 'de-de') AS Datum
FROM Employees
WHERE DATEPART(yyyy, HireDate) = (SELECT YEAR(HireDate) FROM Employees WHERE FirstName = 'Robert' AND LastName = 'King' AND TitleOfCourtesy = 'Mr.') AND EmployeeID != 7

-- welche EmpID hat denn King?
SELECT EmployeeID
FROM Employees
WHERE FirstName = 'Robert' AND LastName = 'King' AND TitleOfCourtesy = 'Mr.'
-- 7
