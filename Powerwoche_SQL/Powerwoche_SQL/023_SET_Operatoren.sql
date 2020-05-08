-- SET Operatoren

-- UNION, UNION ALL, INTERSECT, EXCEPT



-- ***************************** UNION ********************************

SELECT 'Testtext1'
UNION
SELECT 'Testtext2'



-- Liste von allen Kontaktpersonen?
-- nicht mit Join!!
-- NEEEEEEIIIIINNN!!!!
SELECT	  c.ContactName
		, c.Phone
		, s.ContactName
		, s.Phone
		, CONCAT(FirstName, ' ', LastName) AS EmpName
		, HomePhone
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
				 INNER JOIN Suppliers s ON s.SupplierID = p.SupplierID
				 INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID
-- damit bekommen wir keine Liste
-- wir bekommen jede Menge mehrfache Eintr�ge
-- alle Supplier, die irgendein Produkt verkauft haben, so oft, wie dieses Produkt verkauft wurde
-- alle Employees, die je eine Bestellung bearbeitet haben, f�r jede Bestellung 1 Eintrag
-- Kunden, die noch nichts bestellt haben, stehen nicht dabei!
-- h�tten wir Employees, die noch keine Bestellung bearbeitet haben, w�ren die hier nicht aufgef�hrt!
-- --> Join Katastrophe, wenn wir eine Liste haben wollen!!


-- Liste von Kontaktpersonen:
-- mit UNION
SELECT ContactName, Phone
FROM Customers
UNION
SELECT ContactName, Phone
FROM Suppliers



-- funktioniert nicht:
-- es muss die gleiche Anzahl an Spalten in allen beteiligten SELECT stehen
SELECT CompanyName, ContactName, Phone
FROM Customers
UNION
SELECT ContactName, Phone
FROM Suppliers


-- geht nicht: Datentypen m�ssen gleich (oder zumindest kompatibel) sein
SELECT CustomerID, ContactName -- CustomerID = nvarchar
FROM Customers
UNION
SELECT EmployeeID, LastName -- EmployeeID = int
FROM Employees


-- die Spalten m�ssen nicht gleich hei�en, damit das funktioniert:
-- es m�ssen nur gleich viele Spalten sein und kompatible Datentypen
SELECT Country, Phone
FROM Customers
UNION
SELECT Country, HomePhone
FROM Employees


-- NULL Werte sind erlaubt
-- SINN? Von Fall zu Fall �berlegen
SELECT CompanyName, ContactName, Phone
FROM Customers
UNION
SELECT NULL, ContactName, Phone
FROM Suppliers


-- wir d�rfen auch selbst was reinschreiben
-- SINN? Von Fall zu Fall �berlegen
SELECT CompanyName, ContactName, Phone
FROM Customers
UNION
SELECT 'blabla', ContactName, Phone
FROM Suppliers



-- Gib den Firmennamen, die Kontaktperson und die Telefonnummern aller Kunden und aller Supplier in einer Liste aus.
-- F�ge eine Kategorie �C� f�r Customer und �S� f�r Supplier hinzu.
SELECT   'C' AS Category
		, CompanyName
		, Phone
FROM Customers
UNION
SELECT 'S' -- AS Category
	  , CompanyName
	  , Phone
FROM Suppliers
-- ORDER BY Category


-- Gib alle Regionen der Kunden und der Angestellten aus.
-- F�ge eine Kategorie �C� f�r Customer und �E� f�r Employee hinzu.
SELECT Region, 'Customer' AS Art
FROM Customers
WHERE Region IS NOT NULL
UNION
SELECT Region, 'Employee' AS Art
FROM Employees
WHERE Region IS NOT NULL
-- ORDER BY Art



-- OrderID, Freight, niedrigster/h�chster Wert

-- geht NICHT:
SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Wert
FROM Orders
ORDER BY Freight ASC -- dieses ORDER BY funktioniert nicht!
UNION
SELECT TOP 1 OrderID, Freight, 'h�chster Wert' AS Wert
FROM Orders
ORDER BY Freight DESC -- dieses ORDER BY gilt f�r den gesamten Ausdruck!




-- mit tempor�rer Tabelle gehts:
SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Wert
INTO #niedrigster
FROM Orders
GROUP BY OrderID
ORDER BY Freight


SELECT TOP 1 OrderID, Freight, 'h�chster Wert' AS Wert
INTO #hoechster
FROM Orders
GROUP BY OrderID
ORDER BY Freight DESC


SELECT * FROM #niedrigster
UNION
SELECT * FROM #hoechster


-- nur mit MIN/MAX gehts auch... ABER:
SELECT MIN(Freight)
FROM Orders
UNION
SELECT MAX(Freight)
FROM Orders

SELECT MIN(Freight), 'niedrigster Wert' AS Wert
FROM Orders
UNION
SELECT MAX(Freight), 'h�chster Wert' AS Wert
FROM Orders

-- geht nicht mehr, wenn noch eine andere Spalte dabei ist (wegen GROUP BY):
SELECT OrderID, MIN(Freight), 'niedrigster Wert' AS Wert
FROM Orders
GROUP BY OrderID
UNION
SELECT OrderID, MAX(Freight), 'h�chster Wert' AS Wert
FROM Orders
GROUP BY OrderID
-- 1660 Ergebnisse (jeweils der niedrigste und h�chste Frachtkostenwert pro Bestellung, also wieder genau die Frachtkosten)


-- UNION macht auch ein DISTINCT:
SELECT 'Testtext'
UNION
SELECT 'Testtext'

-- wenn man kein DISTINCT will, sondern doppelte Eintr�ge ausgegeben werden sollen, dann mit UNION ALL
-- UNION ALL kann auch verwendet werden, wenn man sicher wei�, dass man keine doppelten Eintr�ge hat (z.B. bei IDs usw.) - Performance: schneller
SELECT 'Testtext'
UNION ALL
SELECT 'Testtext'



-- mit Subquery gehts auch:
SELECT *
FROM (
	  SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Wert
	  FROM Orders
	  ORDER BY Freight ASC
	  ) niedrigster
UNION
SELECT *
FROM (
	  SELECT TOP 1 OrderID, Freight, 'h�chster Wert' AS Wert
	  FROM Orders
	  ORDER BY Freight DESC
	  ) hoechster




-- ******************* INTERSECT, EXCEPT ************************************

CREATE TABLE #a (id int)

CREATE TABLE #b (id int)

INSERT INTO #a (id) VALUES (1), (NULL), (2), (1)

INSERT INTO #b (id) VALUES (1), (NULL), (3), (1)


-- UNION
SELECT id
FROM #a
UNION
SELECT id
FROM #b
-- NULL, 1, 2, 3

-- UNION ALL
SELECT id
FROM #a
UNION ALL
SELECT id
FROM #b
-- 1, NULL, 2, 1, 1, NULL, 3, 1

-- INTERSECT - was ist gleich?
SELECT id
FROM #a
INTERSECT
SELECT id
FROM #b
-- NULL, 1


-- EXCEPT - was ist in der ersten Tabelle, was NICHT in der zweiten Tabelle vorkommt?
SELECT id
FROM #a
EXCEPT
SELECT id
FROM #b
-- 2

-- wenn wir wissen wollen, was in Tabelle b drin ist, das nicht in Tabelle a vorkommt, Reihenfolge:
SELECT id
FROM #b
EXCEPT
SELECT id
FROM #a
-- 3


-- INNER JOIN
SELECT a.id
FROM #a a INNER JOIN #b b ON a.id = b.id
-- 1, 1, 1, 1