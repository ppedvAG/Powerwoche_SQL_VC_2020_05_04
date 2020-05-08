-- HAVING

-- Rechnungssumme?
-- OrderID, Rechnungssumme


-- nein:
SELECT o.OrderID, UnitPrice*Quantity-Discount+Freight AS Rechnungsposten
FROM [Order Details] od INNER JOIN Orders o ON o.OrderID = od.OrderID
-- damit bekommen wir nicht die Rechnungssumme, sondern den Rechnungsposten!


-- nein:
SELECT o.OrderID, SUM(UnitPrice*Quantity-Discount+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON o.OrderID = od.OrderID
GROUP BY o.OrderID
-- stimmt noch nicht ganz... Berechnung
-- hier werden Frachtkosten pro Rechnungsposten hinzuaddiert und Discount pro Rechnungsposten abgezogen


-- Klammern setzen:
SELECT o.OrderID, (SUM(UnitPrice*Quantity)+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON o.OrderID = od.OrderID
GROUP BY o.OrderID, Freight


-- nur die Bestellungen, wo die Rechnungssumme größer als 500 ist
SELECT o.OrderID, (SUM(UnitPrice*Quantity)+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON o.OrderID = od.OrderID
GROUP BY o.OrderID, Freight
HAVING (SUM(UnitPrice*Quantity)+Freight) > 500
ORDER BY Rechnungssumme


-- alle Bestellungen, wo Frachtkosten größer als der durchschnittliche Frachtkostenwert
SELECT	  OrderID
		, OrderDate
		, Freight
--		, ...
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders)


-- Wieviele Kunden gibts pro Land? Nur die, wo mehr als 5 Kunden pro Land vorhanden sind
-- Anzahl, Country
-- meiste Kunden zuerst

SELECT    Country
		, COUNT(CustomerID) AS Anzahl
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5
ORDER BY Anzahl DESC

-- funktioniert NICHT:
SELECT    Country
		, COUNT(CustomerID) AS Anzahl
FROM Customers
WHERE COUNT(CustomerID) > 5
GROUP BY Country
ORDER BY Anzahl DESC
-- An aggregate may not appear in the WHERE clause unless it is in a subquery contained in a HAVING clause or a select list, and the column being aggregated is an outer reference.



-- alle Employees, die mehr als 70 Bestellungen bearbeitet haben
-- EmployeeID, vollständiger Name, Anzahl Bestellungen
SELECT COUNT(OrderID) AS Anzahl
		, e.EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Orders AS o INNER JOIN Employees AS e ON o.EmployeeID = e.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(OrderID) > 70
ORDER BY Anzahl


-- meine Employees mit der EmployeeID 2 und 7 ausgeben, aber nur, wenn sie über 100 Bestellungen bearbeitet haben
SELECT COUNT(OrderID) AS Anzahl
		, e.EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Orders AS o INNER JOIN Employees AS e ON o.EmployeeID = e.EmployeeID
WHERE e.EmployeeID IN(2, 7)
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(OrderID) > 100
ORDER BY Anzahl


